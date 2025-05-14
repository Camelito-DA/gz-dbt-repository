SELECT
    date_date,
    COUNT(orders_id) AS nb_transactions,
    ROUND(SUM(total_revenue),2) AS total_revenue,
    ROUND(SUM(total_revenue)/COUNT(orders_id),2) AS average_basket,
    ROUND(SUM(operational_margin),2) AS total_operational_margin,
    ROUND(SUM(purchase_cost),2) AS total_purchase_cost,
    ROUND(SUM(shipping_fee),2) AS total_shipping_fee,
    ROUND(SUM(ship_cost),2) AS total_ship_cost,
    ROUND(SUM(log_cost),2) AS total_log_cost,
    SUM(nb_products) AS nb_products
FROM {{ref("int_order_margin")}}
GROUP BY
    date_date
ORDER BY
    date_date