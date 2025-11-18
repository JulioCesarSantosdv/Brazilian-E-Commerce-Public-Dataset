--VIEW DASHBOARD OPERACIONAL

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
  
  -- DIMENSÕES GEOGRÁFICAS (com formatação)
  UPPER(fp.estado_cliente) AS estado_cliente,
  INITCAP(fp.cidade_cliente) AS cidade_cliente,
  UPPER(fp.estado_vendedor) AS estado_vendedor,
  INITCAP(fp.cidade_vendedor) AS cidade_vendedor,
  
  -- DIMENSÕES PRODUTO/VENDEDOR (com formatação)
  INITCAP(fp.product_category_name) AS product_category_name,
  
  -- KPIs OPERACIONAIS PRINCIPAIS
  fp.tempo_aprovacao_entrega_dias AS TME,
  
  -- KPI 2: Indicador de Entrega no Prazo
  CASE 
    WHEN fp.data_entrega_cliente IS NOT NULL 
      AND fp.data_estimada_entrega IS NOT NULL
      AND fp.data_entrega_cliente <= fp.data_estimada_entrega 
    THEN 1 ELSE 0 
  END AS entregue_no_prazo,
  
  -- KPI 3: Tempo de Preparação do Vendedor
  fp.tempo_preparacao_vendedor_dias AS tempo_preparacao,
  
  -- KPI 4: Indicador de Atraso (SIMPLIFICADO)
  CASE 
    WHEN fp.data_entrega_cliente > fp.data_estimada_entrega THEN 1 
    ELSE 0 
  END AS indicador_atraso,
  
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
