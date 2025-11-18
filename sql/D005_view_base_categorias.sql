-- VIEW BASE PARA ANÁLISE DE CATEGORIAS
CREATE OR REPLACE VIEW `olist-sandbox-portfolio.olist_analysis.vw_base_categorias` AS
SELECT 
  fp.product_category_name AS categoria_original,

  --  TRATAMENTO DE NOMES DE CATEGORIAS
  CASE 
    WHEN fp.product_category_name = 'informatica_acessorios' THEN 'Informática e Acessórios'
    WHEN fp.product_category_name = 'cama_mesa_banho' THEN 'Cama, Mesa e Banho'
    WHEN fp.product_category_name = 'beleza_saude' THEN 'Beleza e Saúde'
    WHEN fp.product_category_name = 'esporte_lazer' THEN 'Esporte e Lazer'
    WHEN fp.product_category_name = 'relogios_presentes' THEN 'Relógios e Presentes'
    WHEN fp.product_category_name = 'moveis_decoracao' THEN 'Móveis e Decoração'
    WHEN fp.product_category_name = 'telefonia' THEN 'Telefonia'
    WHEN fp.product_category_name = 'informatica' THEN 'Informática'
    WHEN fp.product_category_name = 'consoles_games' THEN 'Consoles e Games'
    WHEN fp.product_category_name = 'brinquedos' THEN 'Brinquedos'
    WHEN fp.product_category_name = 'bebes' THEN 'Bebês'
    WHEN fp.product_category_name = 'malas_acessorios' THEN 'Malas e Acessórios'
    ELSE INITCAP(REPLACE(fp.product_category_name, '_', ' '))
  END AS categoria,
  
  -- MÉTRICAS PRINCIPAIS
  COUNT(DISTINCT fp.order_id) AS total_pedidos,
  SUM(fp.GMV) AS gmv_total,
  COUNT(DISTINCT fp.product_id) AS produtos_unicos,
  COUNT(DISTINCT fp.seller_id) AS vendedores_unicos,
  
  -- MÉTRICAS SECUNDÁRIAS
  SUM(fp.valor_pagamento) AS valor_total_pago,
  AVG(fp.tempo_entrega_total_dias) AS tempo_medio_entrega,
  
  -- CÁLCULOS DERIVADOS
  CASE 
    WHEN COUNT(DISTINCT fp.order_id) > 0 
    THEN SUM(fp.GMV) / COUNT(DISTINCT fp.order_id) 
    ELSE 0 
  END AS ticket_medio_categoria,
  
  -- RANKINGS (PARA FILTROS NO LOOKER STUDIO)
  RANK() OVER (ORDER BY SUM(fp.GMV) DESC) AS ranking_gmv,
  RANK() OVER (ORDER BY COUNT(DISTINCT fp.order_id) DESC) AS ranking_pedidos,
  RANK() OVER (ORDER BY COUNT(DISTINCT fp.product_id) DESC) AS ranking_produtos_unicos,

  -- INDICADORES DE RELEVÂNCIA
  CASE 
    WHEN COUNT(DISTINCT fp.order_id) >= 100 THEN 'Alta'
    WHEN COUNT(DISTINCT fp.order_id) >= 50 THEN 'Média' 
    ELSE 'Baixa'
  END AS relevancia_pedidos

FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido` fp
WHERE fp.product_category_name IS NOT NULL
  AND fp.status_pedido = 'delivered'  -- Apenas pedidos entregues
GROUP BY fp.product_category_name
ORDER BY gmv_total DESC;
