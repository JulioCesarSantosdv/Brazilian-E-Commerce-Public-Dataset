--VIEW DASHBOARD COMERCIAL

-- VIEW COMERCIAL DEFINITIVA - ATUALIZADA COM INADIMPLÊNCIA
CREATE OR REPLACE VIEW `olist-sandbox-portfolio.olist_analysis.vw_dashboard_comercial` AS
SELECT 
    -- DIMENSÕES PRINCIPAIS
    DATE(fp.data_compra) as data,
    EXTRACT(YEAR FROM fp.data_compra) as ano,
    EXTRACT(MONTH FROM fp.data_compra) as mes,
    fp.estado_cliente,
    fp.product_category_name,
    fp.tipo_pagamento,

    -- MÉTRICAS CORRETAS (SEM DUPLICAÇÃO)
    COUNT(DISTINCT fp.order_id) as total_pedidos,
    SUM(fp.GMV) as GMV_total,
    
    -- CÁLCULOS CORRETOS
    CASE 
        WHEN COUNT(DISTINCT fp.order_id) > 0 
        THEN SUM(fp.GMV) / COUNT(DISTINCT fp.order_id) 
        ELSE 0 
    END as ticket_medio,
    
    -- TAXA DE CANCELAMENTO
    CASE 
        WHEN COUNT(DISTINCT fp.order_id) > 0 
        THEN SUM(CASE WHEN fp.status_pedido = 'canceled' THEN 1 ELSE 0 END) / COUNT(DISTINCT fp.order_id)
        ELSE 0 
    END as taxa_cancelamento,

    -- TAXA DE INADIMPLÊNCIA (NOVO - CONFORME REQUISITO)
    CASE 
        WHEN COUNT(DISTINCT fp.order_id) > 0 
        THEN (
            SUM(CASE WHEN fp.status_pedido = 'unavailable' THEN 1 ELSE 0 END) +
            SUM(CASE WHEN fp.status_pedido = 'canceled' AND fp.tipo_pagamento = 'credit_card' THEN 1 ELSE 0 END)
        ) / COUNT(DISTINCT fp.order_id)
        ELSE 0 
    END as taxa_inadimplencia

FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido` fp
GROUP BY 
    data, ano, mes, estado_cliente, product_category_name, tipo_pagamento;
