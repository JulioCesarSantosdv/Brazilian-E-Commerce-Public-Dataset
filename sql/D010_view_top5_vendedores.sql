--CRIANDO A VIEW TOP5 VENDEDORES TME

CREATE OR REPLACE VIEW `olist-sandbox-portfolio.olist_analysis.vw_top5_vendedores_tme` AS
SELECT 
  seller_id,

  -- FORMATAÇÃO: Primeira letra maiúscula na cidade + Estado em maiúsculo
  CONCAT(INITCAP(cidade_vendedor), ' / ', UPPER(estado_vendedor)) AS vendedor,

  COUNT(order_id) AS total_pedidos,
  ROUND(AVG(TME), 2) AS tempo_medio_entrega

FROM `olist-sandbox-portfolio.olist_analysis.vw_dashboard_operacional`

WHERE seller_id IS NOT NULL
GROUP BY seller_id, cidade_vendedor, estado_vendedor
HAVING COUNT(order_id) >= 5  -- Vendedores com pelo menos 5 pedidos
ORDER BY tempo_medio_entrega DESC
LIMIT 6;-- Para que fique em formato top 5
