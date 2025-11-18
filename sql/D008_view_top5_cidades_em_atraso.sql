--TOP 5 CIDADES EM ATRASO

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
HAVING COUNT(order_id) >= 10  -- CORREÇÃO: usar HAVING em vez de WHERE para agregações
ORDER BY taxa_atraso_percent DESC
LIMIT 5;