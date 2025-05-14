WITH jointable AS(
SELECT
    *,
FROM {{ref("finance_days")}}
    JOIN {{ref("int_campaigns_day")}}
        USING(date_date)
)
SELECT
    date_date,
    ROUND(total_operational_margin - ads_cost,2) AS ads_margin,
    average_basket,
    total_operational_margin AS operational_margin,
    ads_cost,
    impression AS ads_impression,
    click AS ads_clicks,
    nb_products AS quantity,
    nb_transactions,
    total_revenue AS revenue,
    total_purchase_cost AS purchase_cost,
    ROUND(total_revenue - total_purchase_cost,2) AS margin,
    total_shipping_fee AS shipping_fee,
    total_log_cost AS log_cost,
    total_ship_cost AS ship_cost
FROM jointable
ORDER BY
    date_date