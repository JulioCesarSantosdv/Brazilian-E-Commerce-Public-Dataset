--CRIANDO VIEW FRETE VS PESO

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
  AND p.product_weight_g <= 50000  -- Remove outliers extremos
  AND oi.freight_value IS NOT NULL
  AND oi.freight_value > 0
  AND oi.freight_value <= 500  -- Remove outliers de frete
GROUP BY faixa_peso
ORDER BY 
  CASE faixa_peso
    WHEN '0-1kg' THEN 1
    WHEN '1-3kg' THEN 2
    WHEN '3-5kg' THEN 3  
    WHEN '5-10kg' THEN 4
    WHEN '10kg+' THEN 5
  END;