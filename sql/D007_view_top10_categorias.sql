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