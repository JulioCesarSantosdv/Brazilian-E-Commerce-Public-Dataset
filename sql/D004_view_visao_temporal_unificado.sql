-- VIEW TEMPORAL UNIFICADA PARA TODAS AS ÁREAS

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