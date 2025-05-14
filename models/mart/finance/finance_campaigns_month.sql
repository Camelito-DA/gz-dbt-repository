WITH monthfromdate AS(
SELECT
    *,
    EXTRACT(MONTH FROM date_date) AS date_month
FROM {{ref("finance_campaigns_day")}}
)
SELECT
    date_month,
    ROUND(SUM(ads_margin),2) AS ads_margin,
    ROUND(AVG(average_basket),2) AS average_basket,
    ROUND(SUM(operational_margin),2) AS operational_margin,
    SUM(ads_cost) AS ads_cost,
    SUM(ads_impression) AS ads_impression,
    SUM(ads_clicks) AS ads_clicks,
    SUM(quantity) AS quantity,
    SUM(nb_transactions) AS transactions,
    ROUND(SUM(revenue),2) AS revenue,
    ROUND(SUM(purchase_cost),2) AS purchase_cost,
    ROUND(SUM(margin),2) AS margin,
    ROUND(SUM(shipping_fee),2) AS shipping_fee,
    SUM(log_cost) AS log_cost,
    SUM(ship_cost) AS ship_cost
FROM monthfromdate
GROUP BY
    date_month
ORDER BY date_month
