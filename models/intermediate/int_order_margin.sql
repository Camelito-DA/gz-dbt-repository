WITH purchase AS(
SELECT
    *,
    quantity * purchase_price as purchase_cost
FROM {{ref("stg_raw__sales")}}
LEFT JOIN {{ref("stg_raw__product")}}
    USING(products_id)
),
orders AS(
SELECT
    orders_id,
    date_date,
    ROUND(SUM(revenue),2) AS total_revenue,
    ROUND(SUM(purchase_cost),2) AS purchase_cost
FROM purchase
GROUP BY orders_id, date_date
),
ship_join AS(
SELECT
    *
FROM orders
LEFT JOIN {{ref("stg_raw__ship")}}
    USING(orders_id)
)
SELECT
    orders_id,
    date_date,
    total_revenue,
    purchase_cost,
    ROUND(total_revenue - purchase_cost,2) AS margin,
    ROUND((total_revenue - purchase_cost) + shipping_fee - log_cost - ship_cost,2) AS operational_margin
FROM ship_join
ORDER BY date_date