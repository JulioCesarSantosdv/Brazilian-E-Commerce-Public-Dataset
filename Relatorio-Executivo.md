<h1>Análise Exploratória dos Dados</h1>

<h2>Contexto e Objetivo da Investigação</h2>
<p>
Com base nos dashboards implementados, identificamos que apenas <strong>3,05% dos clientes retornam para segunda compra</strong>.  
Esta investigação teve como objetivo descobrir as <strong>causas raiz da baixa retenção</strong> e propor soluções baseadas em dados.
</p>

<hr>

<h2>Metodologia de Análise</h2>

<h3>Abordagem Investigativa</h3>
<ul>
  <li>6 consultas SQL para diagnóstico do problema;</li>
  <li>9 consultas SQL para análise de padrões e correlações;</li>
  <li>Análise multidimensional: experiência do cliente, fatores regionais e categorias de produtos.</li>
</ul>

<h3>Fontes de Dados Utilizadas</h3>
<ul>
  <li><strong>Tabela fato_pedido:</strong> 99.441 pedidos;</li>
  <li><strong>Visualizações especializadas</strong> do projeto Olist;</li>
  <li><strong>Dados de 95.420 clientes únicos.</strong></li>
</ul>

<hr>

<h2>Principais Descobertas</h2>

<h3>1. Problema de Churn Crítico Confirmado</h3>
<pre><code>-- Resultado da Investigação 1 
-- Análise detalhada do comportamento de clientes únicos vs recorrentes
  
Única Compra:   92.507 clientes (96,95%)
Recorrente:      2.913 clientes (3,05%)
</code></pre>

<h3>2. Clientes de Alto Valor Não Retornam</h3>
<pre><code>-- Resultado da Investigação 2
-- Análise de Valor do Cliente + Comportamento de Compra
  
Alto Valor + Única Compra: 1.244 clientes
Alto Valor + Frequente:       12 clientes
</code></pre>

<h3>3. Disparidade Regional Significativa</h3>
<pre><code>-- Resultado da Investigação 3
-- Análise geográfica detalhada de performance
  
SP: TME 8,18 dias | Taxa Atraso: 4,28%
RJ: TME 14,68 dias | Taxa Atraso: 11,25%
RS: TME 14,51 dias | Taxa Atraso: 5,64%
</code></pre>

<hr>

<h2>Causas Raiz Identificadas</h2>

<h3>Correlação entre Experiência e Retorno</h3>
<pre><code>-- Investigação 6: Impacto da Primeira Experiência
-- A experiência da primeira compra impacta a decisão de retornar?
TME Médio + Frete Baixo:    3,96% retorno
TME Lento + Frete Alto:     2,86% retorno (-28%)
</code></pre>

<h3>Produtos com Zero Retenção</h3>
<pre><code>-- Investigação 7: Categorias Problemáticas
  -- Quais categorias têm pior retenção após primeira compra?
cine_foto:                   0% retenção | 65 clientes
construcao_ferramentas:      0% retenção | 97 clientes
fashion_underwear:           0% retenção | 121 clientes
artes:                       0% retenção | 202 clientes
</code></pre>

<h3>Fórmula dos Clientes Campeões</h3>
<pre><code>-- Investigação 9: Perfil dos Clientes Fiéis
  -- Análise dos clientes que começaram bem e viraram recorrentes
TME Médio + Frete Médio:   88 campeões | GMV: R$ 817
ZERO ATRASOS na 1ª compra: Fator crítico
</code></pre>

<hr>

<h2>Recomendações Estratégicas</h2>

<h3>Ações Imediatas (0–3 meses)</h3>
<ul>
  <li>Implementar "<strong>Padrão Ouro</strong>" para primeira compra:
    <ul>
      <li>TME ≤ 14 dias</li>
      <li>Frete ≤ R$ 30</li>
      <li>Zero atrasos garantidos</li>
    </ul>
  </li>
  <li>Revisar 6 categorias problemáticas com zero retenção;</li>
  <li>Otimizar operações no RJ — reduzir TME de 21 para 14 dias.</li>
</ul>

<h3>Estratégias de Longo Prazo (3–12 meses)</h3>
<ul>
  <li>Programa de fidelidade pós-primeira-compra;</li>
  <li>Gestão ativa de categorias de risco;</li>
  <li>Padrões regionais de qualidade baseados em métricas.</li>
</ul>

<hr>

<h2>Impacto Esperado</h2>

<table>
  <thead>
    <tr>
      <th>Métrica</th>
      <th>Atual</th>
      <th>Meta (6 meses)</th>
      <th>Impacto</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Taxa de Retenção</td>
      <td>3,05%</td>
      <td>4,00%</td>
      <td>+31%</td>
    </tr>
    <tr>
      <td>Clientes Recorrentes</td>
      <td>2.913</td>
      <td>3.800</td>
      <td>+887 clientes</td>
    </tr>
    <tr>
      <td>GMV de Clientes Fiéis</td>
      <td>R$ 2,3M</td>
      <td>R$ 3,0M</td>
      <td>+R$ 700K</td>
    </tr>
  </tbody>
</table>

<hr>

<h2>Consultas SQL Desenvolvidas</h2>

<h3>Estrutura das Investigações</h3>
<pre><code>investigacoes_sql/
├── 1001_analise_churn.sql
├── 1002_segmentacao_avancada.sql
├── 1003_performance_regional.sql
├── 1004_clientes_alto_valor.sql
├── 1005_sazonalidade_compras.sql
├── 1006_experiencia_retorno.sql
├── 1007_produtos_matadores.sql
├── 1008_analise_categorias_problematicas.sql
└── 1009_clientes_campeoes.sql
</code></pre>

<h3>Código da Consulta Principal</h3>
<details>
  <summary><strong>Consulta 1001 — Análise de Churn</strong></summary>
  <pre><code>WITH clientes_recorrencia AS (
  SELECT 
    customer_unique_id,
    COUNT(DISTINCT order_id) as total_pedidos,
    MIN(data_compra) as primeira_compra,
    MAX(data_compra) as ultima_compra,
    CASE 
      WHEN COUNT(DISTINCT order_id) > 1 THEN 'Recorrente'
      ELSE 'Única Compra'
    END as tipo_cliente
  FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido`
  GROUP BY customer_unique_id
)
SELECT 
  tipo_cliente,
  COUNT(*) as total_clientes,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentual
FROM clientes_recorrencia
GROUP BY tipo_cliente;
  </code></pre>
</details>
<details>
  <summary><strong>Consulta 1002 — Segmento RFM</strong></summary>
  <pre><code>WITH segmentacao_avancada AS (
  SELECT 
    customer_unique_id,
    -- Valor Monetário
    SUM(GMV) as valor_total_cliente,
    AVG(GMV) as ticket_medio,
    
    -- Frequência
    COUNT(DISTINCT order_id) as frequencia_compras,
    
    -- Recência
    DATE_DIFF((SELECT MAX(data_compra) FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido`), 
              MAX(data_compra), DAY) as recencia_dias,
    
    -- Variedade
    COUNT(DISTINCT product_category_name) as categorias_compradas,
    
    -- Engajamento (se tivesse dados de avaliação)
    AVG(tempo_entrega_avaliacao_dias) as tempo_avaliacao
    
  FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido`
  GROUP BY customer_unique_id
)

SELECT 
  CASE 
    WHEN valor_total_cliente > 1000 THEN 'Alto Valor'
    WHEN valor_total_cliente > 500 THEN 'Médio Valor' 
    ELSE 'Baixo Valor'
  END as segmento_valor,
  
  CASE 
    WHEN frequencia_compras > 3 THEN 'Frequente'
    WHEN frequencia_compras > 1 THEN 'Ocasional'
    ELSE 'Única Compra'
  END as segmento_frequencia,
  
  COUNT(*) as total_clientes,
  AVG(valor_total_cliente) as valor_medio,
  AVG(frequencia_compras) as freq_media,
  AVG(categorias_compradas) as variedade_media
  
FROM segmentacao_avancada
GROUP BY segmento_valor, segmento_frequencia
ORDER BY valor_medio DESC;
  </code></pre>
</details>

<details>
  <summary><strong>Consulta 1003 — Performance Regional</strong></summary>
  <pre><code>SELECT 
  estado_cliente,
  COUNT(DISTINCT order_id) as total_pedidos,
  COUNT(DISTINCT customer_unique_id) as total_clientes,
  
  -- Performance Comercial
  SUM(GMV) as gmv_total,
  AVG(GMV) as ticket_medio,
  
  -- Performance Operacional
  AVG(tempo_aprovacao_entrega_dias) as TME,
  AVG(indicador_atraso)*100 as taxa_atraso,
  AVG(tempo_preparacao_vendedor_dias) as tempo_preparacao,
  
  -- Satisfação (se disponível)
  AVG(valor_frete) as frete_medio

FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido`
WHERE estado_cliente IS NOT NULL
GROUP BY estado_cliente
HAVING total_pedidos >= 100
ORDER BY gmv_total DESC;
  </code></pre>
</details>

<details>
  <summary><strong>Consulta 1004 — Análise do Perfil dos Clientes</strong></summary>
  <pre><code>WITH clientes_alto_valor_unico AS (
  SELECT 
    fp.customer_unique_id,
    fp.estado_cliente,
    fp.product_category_name as categoria_principal,
    fp.valor_produto,
    fp.valor_frete,
    fp.tempo_aprovacao_entrega_dias as TME,
    fp.indicador_atraso,
    fp.GMV
  FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido` fp
  JOIN (
    SELECT customer_unique_id
    FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido`
    GROUP BY customer_unique_id
    HAVING SUM(GMV) > 1000 AND COUNT(DISTINCT order_id) = 1
  ) av ON fp.customer_unique_id = av.customer_unique_id
)

SELECT 
  estado_cliente,
  categoria_principal,
  COUNT(*) as total_clientes,
  AVG(GMV) as valor_medio_compra,
  AVG(TME) as tempo_medio_entrega,
  AVG(indicador_atraso)*100 as taxa_atraso,
  AVG(valor_frete) as frete_medio
FROM clientes_alto_valor_unico
GROUP BY estado_cliente, categoria_principal
ORDER BY total_clientes DESC
LIMIT 15;
  </code></pre>
</details>

<details>
  <summary><strong>Consulta 1005 — Sazonalidade das Primeiras Compras</strong></summary>
  <pre><code>WITH primeiras_compras AS (
  SELECT 
    customer_unique_id,
    MIN(data_compra) as data_primeira_compra,
    COUNT(DISTINCT order_id) as total_pedidos,
    EXTRACT(YEAR FROM MIN(data_compra)) as ano_primeira_compra,
    EXTRACT(MONTH FROM MIN(data_compra)) as mes_primeira_compra
  FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido`
  GROUP BY customer_unique_id
)

SELECT 
  ano_primeira_compra,
  mes_primeira_compra,
  COUNT(*) as total_novos_clientes,
  SUM(CASE WHEN total_pedidos > 1 THEN 1 ELSE 0 END) as clientes_que_retornaram,
  ROUND(SUM(CASE WHEN total_pedidos > 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as taxa_retencao
FROM primeiras_compras
GROUP BY ano_primeira_compra, mes_primeira_compra
ORDER BY ano_primeira_compra, mes_primeira_compra;
  </code></pre>
</details>

<details>
  <summary><strong>Consulta 1006 — Experência e Retorno</strong></summary>
  <pre><code>WITH experiencia_primeira_compra AS (
  SELECT 
    fp.customer_unique_id,
    -- Experiência da primeira compra
    MIN(fp.data_compra) as data_primeira_compra,
    AVG(fp.tempo_aprovacao_entrega_dias) as TME_primeira_compra,
    AVG(fp.indicador_atraso) as atraso_primeira_compra,
    AVG(fp.valor_frete) as frete_primeira_compra,
    AVG(fp.GMV) as valor_primeira_compra,
    
    -- Comportamento futuro
    COUNT(DISTINCT fp.order_id) as total_pedidos,
    CASE WHEN COUNT(DISTINCT fp.order_id) > 1 THEN 1 ELSE 0 END as retornou
    
  FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido` fp
  GROUP BY fp.customer_unique_id
)

SELECT 
  -- Grupos por experiência
  CASE 
    WHEN TME_primeira_compra <= 7 THEN 'TME Rápido (≤7 dias)'
    WHEN TME_primeira_compra <= 14 THEN 'TME Médio (8-14 dias)'
    ELSE 'TME Lento (>14 dias)'
  END as grupo_tme,
  
  CASE 
    WHEN frete_primeira_compra <= 15 THEN 'Frete Baixo (≤R$15)'
    WHEN frete_primeira_compra <= 30 THEN 'Frete Médio (R$16-30)'
    ELSE 'Frete Alto (>R$30)'
  END as grupo_frete,
  
  COUNT(*) as total_clientes,
  AVG(retornou)*100 as taxa_retorno_percent,
  AVG(TME_primeira_compra) as tme_medio,
  AVG(frete_primeira_compra) as frete_medio,
  AVG(atraso_primeira_compra)*100 as taxa_atraso
  
FROM experiencia_primeira_compra
GROUP BY grupo_tme, grupo_frete
ORDER BY taxa_retorno_percent DESC;  
  </code></pre>
</details>

<details>
  <summary><strong>Consulta 1007 — Produtos com Alta Taxa de Churn</strong></summary>
  <pre><code>WITH retencao_por_categoria AS (
  SELECT 
    fp.product_category_name,
    fp.customer_unique_id,
    COUNT(DISTINCT fp.order_id) as total_pedidos,
    CASE WHEN COUNT(DISTINCT fp.order_id) > 1 THEN 1 ELSE 0 END as cliente_retido
  FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido` fp
  WHERE fp.product_category_name IS NOT NULL
  GROUP BY fp.product_category_name, fp.customer_unique_id
)
SELECT 
  product_category_name as categoria,
  COUNT(DISTINCT customer_unique_id) as total_clientes,
  SUM(cliente_retido) as clientes_que_retornaram,
  ROUND(SUM(cliente_retido) * 100.0 / COUNT(DISTINCT customer_unique_id), 2) as taxa_retencao,
  AVG(total_pedidos) as pedidos_medio_por_cliente
FROM retencao_por_categoria
GROUP BY categoria
HAVING total_clientes >= 50  -- Apenas categorias significativas
ORDER BY taxa_retencao ASC   -- Ordenar das piores para as melhores
LIMIT 15;
  </code></pre>
</details>

<details>
  <summary><strong>Consulta 1008 — Produtos com Zero Retenção</strong></summary>
  <pre><code>WITH categorias_problematicas AS (
  SELECT 
    fp.product_category_name,
    fp.customer_unique_id,
    fp.estado_cliente,
    fp.tempo_aprovacao_entrega_dias as TME,
    fp.indicador_atraso,
    fp.valor_frete,
    fp.valor_produto,
    fp.GMV
  FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido` fp
  WHERE fp.product_category_name IN (
    'cine_foto', 'construcao_ferramentas_ferramentas', 'fashion_underwear_e_moda_praia',
    'artes', 'portateis_casa_forno_e_cafe', 'tablets_impressao_imagem'
  )
)

SELECT 
  product_category_name as categoria_problema,
  estado_cliente,
  COUNT(DISTINCT customer_unique_id) as total_clientes,
  AVG(TME) as tempo_medio_entrega,
  AVG(indicador_atraso)*100 as taxa_atraso_percent,
  AVG(valor_frete) as frete_medio,
  AVG(valor_produto) as valor_produto_medio,
  AVG(GMV) as gmv_medio
FROM categorias_problematicas
GROUP BY categoria_problema, estado_cliente
HAVING total_clientes >= 10
ORDER BY categoria_problema, total_clientes DESC;  
  </code></pre>
</details>

<details>
  <summary><strong>Consulta 1009 — Clientes Campeões</strong></summary>
  <pre><code>WITH primeira_compra AS (
  SELECT 
    customer_unique_id,
    MIN(data_compra) as data_primeira_compra
  FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido`
  GROUP BY customer_unique_id
),

dados_primeira_compra AS (
  SELECT 
    fp.customer_unique_id,
    fp.tempo_aprovacao_entrega_dias as TME_primeira_compra,
    fp.valor_frete as frete_primeira_compra,
    fp.indicador_atraso as atraso_primeira_compra
  FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido` fp
  JOIN primeira_compra pc ON fp.customer_unique_id = pc.customer_unique_id 
    AND fp.data_compra = pc.data_primeira_compra
),

clientes_campeoes AS (
  SELECT 
    fp.customer_unique_id,
    dpc.TME_primeira_compra,
    dpc.frete_primeira_compra,
    dpc.atraso_primeira_compra,
    COUNT(DISTINCT fp.order_id) as total_pedidos,
    SUM(fp.GMV) as gmv_total,
    COUNT(DISTINCT fp.product_category_name) as categorias_compradas
  FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido` fp
  JOIN dados_primeira_compra dpc ON fp.customer_unique_id = dpc.customer_unique_id
  GROUP BY fp.customer_unique_id, dpc.TME_primeira_compra, dpc.frete_primeira_compra, dpc.atraso_primeira_compra
  HAVING COUNT(DISTINCT fp.order_id) >= 3  -- Clientes realmente recorrentes
)

SELECT 
  CASE 
    WHEN TME_primeira_compra <= 7 THEN 'TME Rápido (≤7 dias)'
    WHEN TME_primeira_compra <= 14 THEN 'TME Médio (8-14 dias)'
    ELSE 'TME Lento (>14 dias)'
  END as experiencia_entrega,
  
  CASE 
    WHEN frete_primeira_compra <= 15 THEN 'Frete Baixo (≤R$15)'
    WHEN frete_primeira_compra <= 30 THEN 'Frete Médio (R$16-30)'
    ELSE 'Frete Alto (>R$30)'
  END as nivel_frete,
  
  COUNT(*) as total_campeoes,
  AVG(total_pedidos) as pedidos_medio,
  AVG(gmv_total) as gmv_medio_total,
  AVG(categorias_compradas) as variedade_categorias,
  AVG(atraso_primeira_compra)*100 as taxa_atraso_primeira_compra
  
FROM clientes_campeoes
GROUP BY experiencia_entrega, nivel_frete
ORDER BY total_campeoes DESC;
  </code></pre>
</details>



<hr>

<h2>Conclusão</h2>
<p>
A investigação revelou que a <strong>experiência consistente na primeira compra</strong> é o fator determinante para retenção de clientes.  
A implementação do <strong>"Padrão Ouro" operacional</strong> pode aumentar significativamente a taxa de retenção e o valor vitalício do cliente.
</p>

<p><strong>Próximos Passos:</strong> Apresentação para stakeholders e implementação das recomendações prioritárias.</p>

<hr>

<p>
<a href="https://github.com/JulioCesarSantosdv/Brazilian-E-Commerce-Public-Dataset/blob/main/README.md#passo-5-hipóteses-analíticas" target="_blank" rel="noopener noreferrer">Voltar</a>
</p>



