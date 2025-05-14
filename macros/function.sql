{% macro margin_percent(revenue, purchase_cost, decimals=2) %}
    ROUND(SAFE_DIVIDE(({{revenue}} - {{purchase_cost}}), {{revenue}}), {{decimals}}) * 100
 {% endmacro %}