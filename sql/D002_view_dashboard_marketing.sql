-- VIEW DASHBOARD MARKETING
CREATE OR REPLACE VIEW `olist-sandbox-portfolio.olist_analysis.vw_dashboard_marketing` AS

-- SEGUNDO: Agregação por cliente
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
    
    -- CORREÇÃO DEFINITIVA: usar data fixa '2018-09-03'
    DATE_DIFF(DATE('2018-09-03'), MAX(data_compra), DAY) as recencia_dias,
    
    COUNT(DISTINCT order_id) as frequencia_compras,
    SUM(GMV) as valor_monetario_total

  FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido`
  GROUP BY customer_unique_id, estado_cliente, cidade_cliente
),

-- TERCEIRO: Buscar categoria da primeira compra
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

-- QUARTO: Juntar tudo
SELECT 
  c.*,

  -- FORMATAÇÃO DE CATEGORIA: substitui "_" por espaço e coloca iniciais maiúsculas
  INITCAP(REPLACE(p.categoria_primeira_compra, '_', ' ')) as categoria_primeira_compra,
  
  -- SEGMENTAÇÃO RFM CORRIGIDA
  CASE 
    WHEN c.recencia_dias <= 60 AND c.frequencia_compras >= 2 AND c.valor_monetario_total >= 300 THEN 'Campeões'
    WHEN c.recencia_dias <= 120 AND c.frequencia_compras >= 2 THEN 'Clientes Leais' 
    WHEN c.recencia_dias <= 60 AND c.frequencia_compras = 1 THEN 'Novos'
    WHEN c.recencia_dias > 180 THEN 'Clientes Inativos'
    ELSE 'Clientes Regulares'
  END as segmento_rfm,
  
  -- INDICADOR RECORRÊNCIA
  CASE WHEN c.total_pedidos_cliente > 1 THEN 1 ELSE 0 END as cliente_recorrente,
  
  -- CATEGORIA DE VALOR
  CASE 
    WHEN c.total_pedidos_cliente >= 3 THEN 'Alto Valor'
    WHEN c.total_pedidos_cliente = 2 THEN 'Médio Valor' 
    ELSE 'Baixo Valor'
  END as categoria_valor

FROM clientes_agg c
LEFT JOIN primeira_compra_cat p 
  ON c.customer_unique_id = p.customer_unique_id;