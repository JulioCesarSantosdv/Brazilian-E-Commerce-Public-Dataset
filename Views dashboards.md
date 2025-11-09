# VIEWS DASHBOARDS

Consultas para dashboards

---

## 1. View: vw_dashboard_comercial

### Descrição da Funcionalidade
View principal para o Dashboard Comercial, agregando métricas de vendas, cancelamentos e inadimplência por múltiplas dimensões temporais e geográficas.

### Análise Técnica
*   **Tabelas Envolvidas:** `fato_pedido` (fp).
*   **Joins Utilizados:** Nenhum (consulta direta da fato).
*   **Agregações:** `COUNT(DISTINCT)`, `SUM`, `CASE` condicional.
*   **Filtros Aplicados:** Agrupamento multidimensional.

### Objetivo de Negócio
Fornecer visão consolidada do desempenho comercial para análise de GMV, ticket médio, cancelamentos e inadimplência por período, estado, categoria e forma de pagamento.

### Observações Importantes
*   A Taxa de Inadimplência combina pedidos com status 'unavailable' e cancelamentos pagos com cartão de crédito.
*   Os cálculos evitam divisão por zero com a cláusula `CASE WHEN`.
*   O agrupamento permite a análise detalhada em múltiplas dimensões.

### Código SQL
```sql
-- VIEW COMERCIAL DEFINITIVA - ATUALIZADA COM INADIMPLÊNCIA
CREATE OR REPLACE VIEW `olist-sandbox-portfolio.olist_analysis.vw_dashboard_comercial` AS
SELECT
  -- DIMENSÕES PRINCIPAIS
  DATE(fp.data_compra) as data,
  EXTRACT(YEAR FROM fp.data_compra) as ano,
  EXTRACT(MONTH FROM fp.data_compra) as mes,
  fp.estado_cliente,
  fp.product_category_name,
  fp.tipo_pagamento,
  -- MÉTRICAS CORRETAS (SEM DUPLICAÇÃO)
  COUNT(DISTINCT fp.order_id) as total_pedidos,
  SUM(fp.GMV) as GMV_total,
  -- CÁLCULOS CORRETOS
  CASE
    WHEN COUNT(DISTINCT fp.order_id) > 0
    THEN SUM(fp.GMV) / COUNT(DISTINCT fp.order_id)
    ELSE 0
  END as ticket_medio,
  -- TAXA DE CANCELAMENTO
  CASE
    WHEN COUNT(DISTINCT fp.order_id) > 0
    THEN SUM(CASE WHEN fp.status_pedido = 'canceled' THEN 1 ELSE 0 END) / COUNT(DISTINCT fp.order_id)
    ELSE 0
  END as taxa_cancelamento,
  -- TAXA DE INADIMPLÊNCIA (NOVO - CONFORME REQUISITO)
  CASE
    WHEN COUNT(DISTINCT fp.order_id) > 0
    THEN (
      SUM(CASE WHEN fp.status_pedido = 'unavailable' THEN 1 ELSE 0 END) +
      SUM(CASE WHEN fp.status_pedido = 'canceled' AND fp.tipo_pagamento = 'credit_card' THEN 1 ELSE 0 END)
    ) / COUNT(DISTINCT fp.order_id)
    ELSE 0
  END as taxa_inadimplencia
FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido` fp
GROUP BY
  data, ano, mes, estado_cliente, product_category_name, tipo_pagamento;
```

---

## 2. View: vw_dashboard_marketing

### Descrição da Funcionalidade
View para análise de marketing com segmentação RFM, LTV e comportamento de clientes, utilizando Common Table Expressions (CTEs) para agregação hierárquica.

### Análise Técnica
*   **Tabelas Envolvidas:** `fato_pedido`.
*   **Joins Utilizados:** `LEFT JOIN` entre CTEs.
*   **Agregações:** `COUNT(DISTINCT)`, `SUM`, `AVG`, `MIN`, `MAX`.
*   **Filtros Aplicados:** Subquery para data máxima.

### Objetivo de Negócio
Segmentar clientes por valor e comportamento (RFM), calcular LTV e identificar padrões de recorrência para estratégias de marketing.

### Observações Importantes
*   A Recência é calculada com a data máxima do dataset (evita `CURRENT_DATE` para dados históricos).
*   Métricas de engajamento foram removidas devido a dados corrompidos.
*   A segmentação RFM foi adaptada para o contexto histórico dos dados.

### Código SQL
```sql
CREATE OR REPLACE VIEW `olist-sandbox-portfolio.olist_analysis.vw_dashboard_marketing` AS
-- PRIMEIRO: Agregação por cliente (nível correto)
WITH clientes_agg AS (
  SELECT
    customer_unique_id,
    estado_cliente,
    cidade_cliente,
    -- MÉTRICAS CONSOLIDADAS POR CLIENTE
    COUNT(DISTINCT order_id) as total_pedidos_cliente,
    SUM(GMV) as LTV_total,
    AVG(GMV) as ticket_medio_cliente,
    MIN(data_compra) as primeira_compra,
    MAX(data_compra) as ultima_compra,
    -- RFM BASE CORRIGIDO: usar data máxima do dataset em vez de CURRENT_DATE()
    DATE_DIFF(
      (SELECT MAX(data_compra) FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido`),
      MAX(data_compra),
      DAY
    ) as recencia_dias,
    COUNT(DISTINCT order_id) as frequencia_compras,
    SUM(GMV) as valor_monetario_total
    -- REMOVIDO: campos de avaliação (dados corrompidos)
  FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido`
  GROUP BY customer_unique_id, estado_cliente, cidade_cliente
),
-- SEGUNDO: Buscar categoria da primeira compra (separado)
primeira_compra_cat AS (
  SELECT DISTINCT
    customer_unique_id,
    FIRST_VALUE(product_category_name) OVER (
      PARTITION BY customer_unique_id
      ORDER BY data_compra
    ) as categoria_primeira_compra
  FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido`
  WHERE data_compra IS NOT NULL
)
-- TERCEIRO: Juntar tudo SEM GROUP BY complexo
SELECT
  c.*,
  p.categoria_primeira_compra,
  -- SEGMENTAÇÃO RFM CORRIGIDA (critérios ajustados para dados históricos)
  CASE
    WHEN c.recencia_dias <= 60 AND c.frequencia_compras >= 2 AND c.valor_monetario_total >= 300 THEN 'Campeões'
    WHEN c.recencia_dias <= 120 AND c.frequencia_compras >= 2 THEN 'Clientes Leais'
    WHEN c.recencia_dias <= 60 AND c.frequencia_compras = 1 THEN 'Novos'
    WHEN c.recencia_dias > 180 THEN 'Clientes Inativos'
    ELSE 'Clientes Regulares'
  END as segmento_rfm,
  -- INDICADOR RECORRÊNCIA
  CASE WHEN c.total_pedidos_cliente > 1 THEN 1 ELSE 0 END as cliente_recorrente,
  -- NOVA MÉTRICA: CATEGORIA DE VALOR (substitui engajamento)
  CASE
    WHEN c.total_pedidos_cliente >= 3 THEN 'Alto Valor'
    WHEN c.total_pedidos_cliente = 2 THEN 'Médio Valor'
    ELSE 'Baixo Valor'
  END as categoria_valor
  -- REMOVIDO: taxa_engajamento (dados corrompidos)
FROM clientes_agg c
LEFT JOIN primeira_compra_cat p
  ON c.customer_unique_id = p.customer_unique_id;
```

---

## 3. View: vw_dashboard_operacional

### Descrição da Funcionalidade
View para análise operacional com KPIs de tempo de entrega, preparação, atrasos e performance logística.

### Análise Técnica
*   **Tabelas Envolvidas:** `fato_pedido` (fp).
*   **Joins Utilizados:** Nenhum.
*   **Agregações:** Nenhuma (dados no nível do pedido).
*   **Filtros Aplicados:** `WHERE` para dados de entrega não nulos.

### Objetivo de Negócio
Monitorar performance operacional: tempo médio de entrega (TME), cumprimento de prazos, eficiência de vendedores e identificar gargalos logísticos.

### Observações Importantes
*   Filtra apenas pedidos com dados de entrega completos.
*   Indicadores binários (0/1) para facilitar agregações.
*   Mantém dados no nível mais granular para flexibilidade.

### Código SQL
```sql
CREATE OR REPLACE VIEW `olist-sandbox-portfolio.olist_analysis.vw_dashboard_operacional` AS
SELECT
  -- CHAVES PRIMÁRIAS
  fp.order_id,
  fp.seller_id,
  fp.customer_id,
  -- DATAS PARA ANÁLISE TEMPORAL
  fp.data_compra,
  fp.data_aprovacao,
  fp.data_envio_transportadora,
  fp.data_entrega_cliente,
  fp.data_estimada_entrega,
  -- DIMENSÕES GEOGRÁFICAS
  fp.estado_cliente,
  fp.cidade_cliente,
  fp.estado_vendedor,
  fp.cidade_vendedor,
  -- DIMENSÕES PRODUTO/VENDEDOR
  fp.product_category_name,
  -- KPIs OPERACIONAIS PRINCIPAIS
  fp.tempo_aprovacao_entrega_dias as TME,
  -- KPI 2: Indicador de Entrega no Prazo
  CASE
    WHEN fp.data_entrega_cliente IS NOT NULL
    AND fp.data_estimada_entrega IS NOT NULL
    AND fp.data_entrega_cliente <= fp.data_estimada_entrega
    THEN 1 ELSE 0
  END as entregue_no_prazo,
  -- KPI 3: Tempo de Preparação do Vendedor
  fp.tempo_preparacao_vendedor_dias as tempo_preparacao,
  -- KPI 4: Indicador de Atraso (SIMPLIFICADO)
  CASE
    WHEN fp.data_entrega_cliente > fp.data_estimada_entrega
    THEN 1
    ELSE 0
  END as indicador_atraso,
  -- KPI 5: Status do Pedido
  fp.status_pedido,
  fp.indicador_problema,
  -- KPI 6: Dados de Frete e Dimensões
  fp.valor_frete,
  fp.product_weight_g,
  fp.product_length_cm,
  fp.product_height_cm,
  fp.product_width_cm,
  -- Dados para agregações
  fp.valor_produto,
  fp.GMV
FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido` fp
WHERE fp.data_entrega_cliente IS NOT NULL
  AND fp.data_aprovacao IS NOT NULL;
```

---

## 4. View: vw_temporal_unificada

### Descrição da Funcionalidade
View consolidada para análise temporal com métricas mensais de todas as áreas (comercial, marketing, operacional) e variação de GMV.

### Análise Técnica
*   **Tabelas Envolvidas:** `fato_pedido` (fp).
*   **Joins Utilizados:** Nenhum.
*   **Agregações:** `SUM`, `COUNT(DISTINCT)`, `AVG`, `CASE` condicional.
*   **Filtros Aplicados:** `WHERE` para dados não nulos.

### Objetivo de Negócio
Fornecer visão unificada da performance da empresa ao longo do tempo, permitindo análise de tendências e variações mensais.

### Observações Importantes
*   A Variação do GMV é calculada com a função `LAG`.
*   Múltiplos campos de ordenação são utilizados para garantir a consistência temporal.
*   A variação é formatada como texto para exibição direta no dashboard.

### Código SQL
```sql
-- VIEW TEMPORAL UNIFICADA COM VARIAÇÃO GMV CORRIGIDA
CREATE OR REPLACE VIEW `olist-sandbox-portfolio.olist_analysis.vw_temporal_unificada` AS
WITH dados_mensais AS (
  SELECT
    DATE_TRUNC(DATE(fp.data_compra), MONTH) as mes,
    FORMAT_DATE('%b/%Y', DATE(fp.data_compra)) as mes_formatado,
    EXTRACT(YEAR FROM fp.data_compra) as ano,
    EXTRACT(MONTH FROM fp.data_compra) as mes_numero,
    -- CAMPOS EXTRAS PARA ORDENAÇÃO EXPLÍCITA
    EXTRACT(YEAR FROM fp.data_compra) * 100 + EXTRACT(MONTH FROM fp.data_compra) as ano_mes_ordenacao,
    FORMAT_DATE('%Y-%m', DATE(fp.data_compra)) as mes_ordenacao_string,
    -- MÉTRICAS COMERCIAIS
    SUM(fp.GMV) as gmv_total,
    COUNT(DISTINCT fp.order_id) as total_pedidos,
    CASE
      WHEN COUNT(DISTINCT fp.order_id) > 0
      THEN SUM(fp.GMV) / COUNT(DISTINCT fp.order_id)
      ELSE 0
    END as ticket_medio,
    -- MÉTRICAS DE PAGAMENTO
    SUM(fp.valor_pagamento) as valor_total_pago,
    COUNT(DISTINCT fp.customer_id) as clientes_ativos,
    -- MÉTRICAS OPERACIONAIS
    AVG(fp.tempo_entrega_total_dias) as tempo_medio_entrega_dias,
    AVG(fp.tempo_preparacao_vendedor_dias) as tempo_preparacao_vendedor_dias,
    -- INDICADORES DE PERFORMANCE
    CASE
      WHEN COUNT(DISTINCT fp.order_id) > 0
      THEN SUM(CASE WHEN fp.status_pedido = 'delivered' THEN 1 ELSE 0 END) / COUNT(DISTINCT fp.order_id)
      ELSE 0
    END as taxa_entrega_sucesso,
    CASE
      WHEN COUNT(DISTINCT fp.order_id) > 0
      THEN SUM(fp.indicador_atraso) / COUNT(DISTINCT fp.order_id)
      ELSE 0
    END as taxa_atraso,
    CASE
      WHEN COUNT(DISTINCT fp.order_id) > 0
      THEN SUM(CASE WHEN fp.status_pedido = 'canceled' THEN 1 ELSE 0 END) / COUNT(DISTINCT fp.order_id)
      ELSE 0
    END as taxa_cancelamento,
    -- MÉTRICAS DE PRODUTOS
    COUNT(DISTINCT fp.product_id) as produtos_unicos,
    COUNT(DISTINCT fp.seller_id) as vendedores_ativos,
    -- MÉTRICAS GEOGRÁFICAS
    COUNT(DISTINCT fp.estado_cliente) as estados_ativos
  FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido` fp
  WHERE fp.data_compra IS NOT NULL
    AND fp.status_pedido IS NOT NULL
  GROUP BY
    mes, mes_formatado, ano, mes_numero, ano_mes_ordenacao, mes_ordenacao_string
)
SELECT
  *,
  -- VARIAÇÃO GMV MENSAL (NOVO KPI)
  LAG(gmv_total) OVER (ORDER BY mes) as gmv_mes_anterior,
  CASE
    WHEN LAG(gmv_total) OVER (ORDER BY mes) > 0
    THEN ((gmv_total - LAG(gmv_total) OVER (ORDER BY mes)) / LAG(gmv_total) OVER (ORDER BY mes))
    ELSE NULL
  END as variacao_gmv_mensal,
  -- VARIAÇÃO FORMATADA COMO TEXTO (SOLUÇÃO DO PROBLEMA)
  CASE
    WHEN LAG(gmv_total) OVER (ORDER BY mes) > 0
    THEN FORMAT('%.1f%%', ((gmv_total - LAG(gmv_total) OVER (ORDER BY mes)) / LAG(gmv_total) OVER (ORDER BY mes)) * 100)
    ELSE 'N/A'
  END as variacao_gmv_formatada,
  -- INDICADOR DE CRESCIMENTO (PARA CORES/FORMATAÇÃO)
  CASE
    WHEN LAG(gmv_total) OVER (ORDER BY mes) > 0
    AND ((gmv_total - LAG(gmv_total) OVER (ORDER BY mes)) / LAG(gmv_total) OVER (ORDER BY mes)) > 0
    THEN 'crescimento'
    WHEN LAG(gmv_total) OVER (ORDER BY mes) > 0
    AND ((gmv_total - LAG(gmv_total) OVER (ORDER BY mes)) / LAG(gmv_total) OVER (ORDER BY mes)) < 0
    THEN 'queda'
    ELSE 'estavel'
  END as tendencia_gmv
FROM dados_mensais
ORDER BY mes;
```

---

## 5. View: vw_base_categorias

### Descrição da Funcionalidade
View base para análise dimensional de categorias de produtos, com rankings e indicadores de relevância.

### Análise Técnica
*   **Tabelas Envolvidas:** `fato_pedido` (fp).
*   **Joins Utilizados:** Nenhum.
*   **Agregações:** `COUNT(DISTINCT)`, `SUM`, `AVG`, `RANK()`.
*   **Filtros Aplicados:** `WHERE` para categorias não nulas e status 'delivered'.

### Objetivo de Negócio
Identificar categorias mais relevantes por GMV, volume de pedidos e diversidade de produtos, permitindo priorização estratégica.

### Observações Importantes
*   Filtra apenas pedidos entregues para análise de performance real.
*   Rankings múltiplos para diferentes perspectivas de análise.
*   Indicador de relevância baseado em volume de pedidos.

### Código SQL
```sql
-- VIEW BASE PARA ANÁLISE DE CATEGORIAS (COMPLETA E FLEXÍVEL)
CREATE OR REPLACE VIEW `olist-sandbox-portfolio.olist_analysis.vw_base_categorias` AS
SELECT
  fp.product_category_name as categoria,
  -- MÉTRICAS PRINCIPAIS
  COUNT(DISTINCT fp.order_id) as total_pedidos,
  SUM(fp.GMV) as gmv_total,
  COUNT(DISTINCT fp.product_id) as produtos_unicos,
  COUNT(DISTINCT fp.seller_id) as vendedores_unicos,
  -- MÉTRICAS SECUNDÁRIAS
  SUM(fp.valor_pagamento) as valor_total_pago,
  AVG(fp.tempo_entrega_total_dias) as tempo_medio_entrega,
  -- CÁLCULOS DERIVADOS
  CASE
    WHEN COUNT(DISTINCT fp.order_id) > 0
    THEN SUM(fp.GMV) / COUNT(DISTINCT fp.order_id)
    ELSE 0
  END as ticket_medio_categoria,
  -- RANKINGS (PARA FILTROS NO LOOKER STUDIO)
  RANK() OVER (ORDER BY SUM(fp.GMV) DESC) as ranking_gmv,
  RANK() OVER (ORDER BY COUNT(DISTINCT fp.order_id) DESC) as ranking_pedidos,
  RANK() OVER (ORDER BY COUNT(DISTINCT fp.product_id) DESC) as ranking_produtos_unicos,
  -- INDICADORES DE RELEVÂNCIA
  CASE
    WHEN COUNT(DISTINCT fp.order_id) >= 100 THEN 'Alta'
    WHEN COUNT(DISTINCT fp.order_id) >= 50 THEN 'Média'
    ELSE 'Baixa'
  END as relevancia_pedidos
FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido` fp
WHERE fp.product_category_name IS NOT NULL
  AND fp.status_pedido = 'delivered' -- Apenas pedidos entregues
GROUP BY fp.product_category_name
ORDER BY gmv_total DESC;
```

---

## 6. View: vw_base_vendedores

### Descrição da Funcionalidade
View base para análise dimensional de vendedores, seguindo a mesma estrutura da view de categorias para consistência.

### Análise Técnica
*   **Tabelas Envolvidas:** `fato_pedido` (fp), `sellers` (s).
*   **Joins Utilizados:** `INNER JOIN` com `sellers`.
*   **Agregações:** `COUNT(DISTINCT)`, `SUM`, `AVG`, `RANK()`.
*   **Filtros Aplicados:** `WHERE` para status 'delivered'.

### Objetivo de Negócio
Analisar performance de vendedores por GMV, volume, tempo de preparação e diversidade de clientes, identificando top performers.

### Observações Importantes
*   O `GROUP BY` foi corrigido com campos corretos da tabela `sellers`.
*   O `JOIN` explícito é utilizado para garantir dados geográficos consistentes.
*   O indicador de relevância é baseado em volume.

### Código SQL
```sql
-- VIEW BASE PARA ANÁLISE DE VENDEDORES (MESMA ESTRUTURA DAS CATEGORIAS)
CREATE OR REPLACE VIEW `olist-sandbox-portfolio.olist_analysis.vw_base_vendedores` AS
SELECT
  fp.seller_id as vendedor_id,
  s.seller_city as cidade_vendedor,
  s.seller_state as estado_vendedor,
  -- MÉTRICAS PRINCIPAIS
  COUNT(DISTINCT fp.order_id) as total_pedidos,
  SUM(fp.GMV) as gmv_total,
  COUNT(DISTINCT fp.product_id) as produtos_unicos,
  COUNT(DISTINCT fp.customer_id) as clientes_unicos,
  -- MÉTRICAS DE PERFORMANCE
  AVG(fp.tempo_preparacao_vendedor_dias) as tempo_medio_preparacao,
  AVG(fp.valor_frete) as valor_medio_frete,
  -- CÁLCULOS DERIVADOS
  CASE
    WHEN COUNT(DISTINCT fp.order_id) > 0
    THEN SUM(fp.GMV) / COUNT(DISTINCT fp.order_id)
    ELSE 0
  END as ticket_medio_vendedor,
  -- RANKINGS (PARA FILTROS NO LOOKER STUDIO)
  RANK() OVER (ORDER BY SUM(fp.GMV) DESC) as ranking_gmv,
  RANK() OVER (ORDER BY COUNT(DISTINCT fp.order_id) DESC) as ranking_pedidos
  -- O restante do código foi truncado na extração, mas a estrutura principal está aqui.
FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido` fp
INNER JOIN `olist-sandbox-portfolio.olist_analysis.sellers` s ON fp.seller_id = s.seller_id
WHERE fp.status_pedido = 'delivered'
GROUP BY 1, 2, 3;
```

---

## 7. View: vw_top10_categorias

### Descrição da Funcionalidade
View simplificada para filtros, contendo apenas as top 10 categorias por GMV.

### Análise Técnica
*   **Tabelas Envolvidas:** `vw_base_categorias`.
*   **Joins Utilizados:** Nenhum.
*   **Agregações:** Nenhuma.
*   **Filtros Aplicados:** `WHERE` para ranking `<= 10`.

### Objetivo de Negócio
Fornecer lista otimizada para uso em filtros de dashboards, contendo apenas categorias mais relevantes.

### Observações Importantes
*   View de conveniência para melhor performance em filtros.
*   Mantém sincronia automática com view base.
*   Ordenação consistente com ranking.

### Código SQL
```sql
-- VIEW ESPECÍFICA PARA O FILTRO (TOP 10 CATEGORIAS)
CREATE OR REPLACE VIEW `olist-sandbox-portfolio.olist_analysis.vw_top10_categorias` AS
SELECT
  categoria,
  gmv_total,
  total_pedidos,
  ranking_gmv
FROM `olist-sandbox-portfolio.olist_analysis.vw_base_categorias`
WHERE ranking_gmv <= 10
ORDER BY ranking_gmv;
```

---

## 8. View: vw_top5_cidades_atraso

### Descrição da Funcionalidade
View para alertas operacionais - identifica as 5 cidades com maior taxa de atraso na entrega.

### Análise Técnica
*   **Tabelas Envolvidas:** `vw_dashboard_operacional`.
*   **Joins Utilizados:** Nenhum.
*   **Agregações:** `COUNT`, `CASE` condicional.
*   **Filtros Aplicados:** `HAVING` para cidades com volume significativo.

### Objetivo de Negócio
Identificar problemas logísticos regionais para ações corretivas prioritárias.

### Observações Importantes
*   `HAVING` corrigido (não `WHERE`) para filtro em agregações.
*   Limite de 5 cidades para foco em problemas mais críticos.
*   Filtro mínimo de 10 pedidos para relevância estatística.

### Código SQL
```sql
CREATE OR REPLACE VIEW `olist-sandbox-portfolio.olist_analysis.vw_top5_cidades_atraso` AS
SELECT
  cidade_cliente,
  COUNT(order_id) as total_pedidos,
  COUNT(CASE WHEN data_entrega_cliente > data_estimada_entrega THEN order_id END) as pedidos_atrasados,
  ROUND(
    (COUNT(CASE WHEN data_entrega_cliente > data_estimada_entrega THEN order_id END) / COUNT(order_id)) * 100,
    2
  ) as taxa_atraso_percent
FROM `olist-sandbox-portfolio.olist_analysis.vw_dashboard_operacional`
WHERE cidade_cliente IS NOT NULL
GROUP BY cidade_cliente
HAVING COUNT(order_id) >= 10 -- CORREÇÃO: usar HAVING em vez de WHERE para agregações
ORDER BY taxa_atraso_percent DESC
LIMIT 5;
```

---

## 9. View: vw_top5_vendedores_tme

### Descrição da Funcionalidade
View para alertas operacionais - identifica vendedores com pior tempo médio de entrega (TME).

### Análise Técnica
*   **Tabelas Envolvidas:** `vw_dashboard_operacional`.
*   **Joins Utilizados:** Nenhum.
*   **Agregações:** `COUNT`, `AVG`.
*   **Filtros Aplicados:** `HAVING` para vendedores com volume mínimo.

### Objetivo de Negócio
Identificar vendedores com problemas de performance logística para treinamento ou intervenção.

### Observações Importantes
*   `LIMIT 6` (não 5) por questão prática de visualização no Looker Studio.
*   Filtro mínimo de 5 pedidos para relevância estatística.
*   Decisão consciente de nomenclatura vs funcionalidade.

### Código SQL
```sql
CREATE OR REPLACE VIEW `olist-sandbox-portfolio.olist_analysis.vw_top5_vendedores_tme` AS
SELECT
  seller_id,
  cidade_vendedor,
  estado_vendedor,
  COUNT(order_id) as total_pedidos,
  ROUND(AVG(TME), 2) as tempo_medio_entrega
FROM `olist-sandbox-portfolio.olist_analysis.vw_dashboard_operacional`
WHERE seller_id IS NOT NULL
GROUP BY seller_id, cidade_vendedor, estado_vendedor
HAVING COUNT(order_id) >= 5 -- Vendedores com pelo menos 5 pedidos
ORDER BY tempo_medio_entrega DESC
LIMIT 6;
```

---

## 10. View: vw_frete_vs_peso 

### Descrição da Funcionalidade
View para análise de correlação entre o custo do frete e o peso do produto, agrupando os produtos em faixas de peso.

### Análise Técnica
*   **Tabelas Envolvidas:** `order_items` (oi), `products` (p).
*   **Joins Utilizados:** `JOIN` entre `order_items` e `products`.
*   **Agregações:** `COUNT`, `AVG`, `CASE` para faixas.
*   **Filtros Aplicados:** `WHERE` para remover *outliers* e dados inválidos.

### Objetivo de Negócio
Entender a relação entre características físicas do produto e custos de frete para otimização logística.

### Observações Importantes
*   Filtros proativos para remover *outliers* extremos.
*   Categorização em faixas para análise segmentada.
*   Ordenação por lógica de peso (não alfabética).

### Código SQL
```sql
CREATE OR REPLACE VIEW `olist-sandbox-portfolio.olist_analysis.vw_frete_vs_peso` AS
SELECT
  CASE
    WHEN p.product_weight_g <= 1000 THEN '0-1kg'
    WHEN p.product_weight_g <= 3000 THEN '1-3kg'
    WHEN p.product_weight_g <= 5000 THEN '3-5kg'
    WHEN p.product_weight_g <= 10000 THEN '5-10kg'
    ELSE '10kg+'
  END as faixa_peso,
  COUNT(oi.order_id) as total_pedidos,
  ROUND(AVG(oi.freight_value), 2) as frete_medio,
  ROUND(AVG(p.product_weight_g), 2) as peso_medio,
  ROUND(AVG(p.product_length_cm), 2) as comprimento_medio,
  ROUND(AVG(p.product_height_cm), 2) as altura_media,
  ROUND(AVG(p.product_width_cm), 2) as largura_media
FROM `olist-sandbox-portfolio.olist_analysis.order_items` oi
JOIN `olist-sandbox-portfolio.olist_analysis.products` p
  ON oi.product_id = p.product_id
WHERE p.product_weight_g IS NOT NULL
  AND p.product_weight_g > 0
  AND p.product_weight_g <= 50000 -- Remove outliers extremos
  AND oi.freight_value IS NOT NULL
  AND oi.freight_value > 0
  AND oi.freight_value <= 500 -- Remove outliers de frete
GROUP BY faixa_peso
ORDER BY
  CASE faixa_peso
    WHEN '0-1kg' THEN 1
    WHEN '1-3kg' THEN 2
    WHEN '3-5kg' THEN 3
    WHEN '5-10kg' THEN 4
    WHEN '10kg+' THEN 5
  END;
```


