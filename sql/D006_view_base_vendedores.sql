-- VIEW BASE PARA ANÁLISE DE VENDEDORES (MESMA ESTRUTURA DAS CATEGORIAS)

-- VIEW BASE PARA ANÁLISE DE VENDEDORES (MESMA ESTRUTURA DAS CATEGORIAS)
CREATE OR REPLACE VIEW `olist-sandbox-portfolio.olist_analysis.vw_base_vendedores` AS
SELECT 
  fp.seller_id AS vendedor_id,
  s.seller_city AS cidade_vendedor,
  s.seller_state AS estado_vendedor,

  -- NOVA COLUNA FORMATADA PARA USO EM GRÁFICOS (PRIMEIRAS LETRAS EM MAIÚSCULO)
  CONCAT(INITCAP(s.seller_city), ' - ', s.seller_state) AS cidade_estado_vendedor,
  
  -- MÉTRICAS PRINCIPAIS
  COUNT(DISTINCT fp.order_id) AS total_pedidos,
  SUM(fp.GMV) AS gmv_total,
  COUNT(DISTINCT fp.product_id) AS produtos_unicos,
  COUNT(DISTINCT fp.customer_id) AS clientes_unicos,
  
  -- MÉTRICAS DE PERFORMANCE
  AVG(fp.tempo_preparacao_vendedor_dias) AS tempo_medio_preparacao,
  AVG(fp.valor_frete) AS valor_medio_frete,
  
  -- CÁLCULOS DERIVADOS
  CASE 
    WHEN COUNT(DISTINCT fp.order_id) > 0 
    THEN SUM(fp.GMV) / COUNT(DISTINCT fp.order_id) 
    ELSE 0 
  END AS ticket_medio_vendedor,
  
  -- RANKINGS (PARA FILTROS NO LOOKER STUDIO)
  RANK() OVER (ORDER BY SUM(fp.GMV) DESC) AS ranking_gmv,
  RANK() OVER (ORDER BY COUNT(DISTINCT fp.order_id) DESC) AS ranking_pedidos,
  RANK() OVER (ORDER BY COUNT(DISTINCT fp.customer_id) DESC) AS ranking_clientes,

  -- INDICADORES DE RELEVÂNCIA
  CASE 
    WHEN COUNT(DISTINCT fp.order_id) >= 100 THEN 'Alta'
    WHEN COUNT(DISTINCT fp.order_id) >= 50 THEN 'Média' 
    ELSE 'Baixa'
  END AS relevancia_vendedor

FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido` fp
JOIN `olist-sandbox-portfolio.olist_analysis.sellers` s 
  ON fp.seller_id = s.seller_id
WHERE fp.status_pedido = 'delivered'
GROUP BY fp.seller_id, s.seller_city, s.seller_state
ORDER BY gmv_total DESC;
