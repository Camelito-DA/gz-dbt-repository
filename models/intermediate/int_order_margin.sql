WITH purchase AS( --join table between sales and products on product's granularity and calculation of purchase cost
SELECT
    *,
    quantity * purchase_price as purchase_cost
FROM {{ref("stg_raw__sales")}}
LEFT JOIN {{ref("stg_raw__product")}}
    USING(products_id)
),
orders AS( --moving into orders granularity and calculation of revenue and purchase cost per order
SELECT
    orders_id,
    date_date,
    ROUND(SUM(revenue),2) AS total_revenue,
    ROUND(SUM(purchase_cost),2) AS purchase_cost,
    SUM(quantity) AS nb_products
FROM purchase
GROUP BY 
    orders_id,
    date_date
),
ship_join AS( --join table between sales+products and ship
SELECT
    *
FROM orders
LEFT JOIN {{ref("stg_raw__ship")}}
    USING(orders_id)
)
SELECT    --calculation of the margin and operational margin given all the necessaries columns
    orders_id,
    date_date,
    total_revenue,
    purchase_cost,
    nb_products,
    ROUND(total_revenue - purchase_cost,2) AS margin,
    {{ margin_percent('total_revenue', 'purchase_cost') }} AS margin_percent
    ROUND((total_revenue - purchase_cost) + shipping_fee - log_cost - ship_cost,2) AS operational_margin,
    shipping_fee,
    ship_cost,
    log_cost
FROM ship_join
ORDER BY operational_margin ASC