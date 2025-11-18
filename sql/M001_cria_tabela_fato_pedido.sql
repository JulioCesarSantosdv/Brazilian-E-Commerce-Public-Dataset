--CRIANDO A TABELA FATO PEDIDO

CREATE OR REPLACE TABLE `olist-sandbox-portfolio.olist_analysis.fato_pedido` AS
SELECT 
    -- CHAVES PRIMARIAS E ESTRANGEIRAS
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,
    o.customer_id,
    c.customer_unique_id,
    
    -- METRICAS FINANCEIRAS (COMERCIAL)
    oi.price as valor_produto,
    oi.freight_value as valor_frete,
    (oi.price + oi.freight_value) as GMV,
    op.payment_value as valor_pagamento,
    op.payment_type as tipo_pagamento,
    op.payment_installments as parcelas,
    
    -- DATAS PARA ANALISE TEMPORAL
    DATE(o.order_purchase_timestamp) as data_compra,
    DATE(o.order_approved_at) as data_aprovacao,
    DATE(o.order_delivered_carrier_date) as data_envio_transportadora,
    DATE(o.order_delivered_customer_date) as data_entrega_cliente,
    DATE(o.order_estimated_delivery_date) as data_estimada_entrega,
    
    -- CALCULOS DE TEMPO (OPERACIONAL) - COM TRATAMENTO DE NULL
    CASE 
        WHEN o.order_delivered_customer_date IS NOT NULL 
        AND o.order_purchase_timestamp IS NOT NULL
        THEN DATE_DIFF(
            DATE(o.order_delivered_customer_date), 
            DATE(o.order_purchase_timestamp), 
            DAY
        )
    END as tempo_entrega_total_dias,
    
    CASE 
        WHEN o.order_delivered_customer_date IS NOT NULL 
        AND o.order_approved_at IS NOT NULL
        THEN DATE_DIFF(
            DATE(o.order_delivered_customer_date), 
            DATE(o.order_approved_at), 
            DAY
        )
    END as tempo_aprovacao_entrega_dias,
    
    CASE 
        WHEN o.order_delivered_carrier_date IS NOT NULL 
        AND o.order_approved_at IS NOT NULL
        THEN DATE_DIFF(
            DATE(o.order_delivered_carrier_date), 
            DATE(o.order_approved_at), 
            DAY
        )
    END as tempo_preparacao_vendedor_dias,
    
    -- INDICADORES DE PERFORMANCE
    CASE 
        WHEN o.order_delivered_customer_date IS NOT NULL
        AND o.order_estimated_delivery_date IS NOT NULL
        AND DATE(o.order_delivered_customer_date) > DATE(o.order_estimated_delivery_date) 
        THEN 1 ELSE 0 
    END as indicador_atraso,
    
    CASE 
        WHEN o.order_status IN ('canceled', 'unavailable') 
        THEN 1 ELSE 0 
    END as indicador_problema,
    
    -- DIMENSOES DO PRODUTO
    p.product_category_name,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm,
    
    -- DIMENSOES GEOGRAFICAS
    c.customer_city as cidade_cliente,
    c.customer_state as estado_cliente,
    s.seller_city as cidade_vendedor,
    s.seller_state as estado_vendedor,
    
    -- DIMENSOES DO PEDIDO E STATUS
    o.order_status as status_pedido,
    
    -- DADOS PARA ANALISE DE MARKETING (AVALIACOES) - CORRIGIDOS
    r.string_field_1 as review_id,
    r.string_field_2 as order_id_review,
    r.string_field_3 as review_comment_title,
    r.string_field_4 as review_comment_message,
    CASE 
        WHEN r.string_field_5 IS NOT NULL 
        THEN DATE(PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', r.string_field_5))
    END as data_avaliacao,
    
    CASE 
        WHEN r.string_field_5 IS NOT NULL 
        AND o.order_delivered_customer_date IS NOT NULL
        THEN DATE_DIFF(
            DATE(PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', r.string_field_5)), 
            DATE(o.order_delivered_customer_date), 
            DAY
        )
    END as tempo_entrega_avaliacao_dias

FROM `olist-sandbox-portfolio.olist_analysis.order_items` oi
JOIN `olist-sandbox-portfolio.olist_analysis.orders` o 
    ON oi.order_id = o.order_id
JOIN `olist-sandbox-portfolio.olist_analysis.customers` c 
    ON o.customer_id = c.customer_id
JOIN `olist-sandbox-portfolio.olist_analysis.products` p 
    ON oi.product_id = p.product_id
JOIN `olist-sandbox-portfolio.olist_analysis.sellers` s 
    ON oi.seller_id = s.seller_id
LEFT JOIN `olist-sandbox-portfolio.olist_analysis.order_payments` op 
    ON oi.order_id = op.order_id
LEFT JOIN `olist-sandbox-portfolio.olist_analysis.order_reviews` r 
    ON oi.order_id = r.string_field_2  -- CORREÇÃO CRÍTICA: string_field_2 é o order_id
-- REMOVI O WHERE para incluir todos os status de pedido
;