{% macro margin_percent(revenue, purchase_cost, decimals=2) %}
    return(ROUND(SAFE_DIVIDE(({{revenue}} - {{purchase_cost}}), {{revenue}}), {{decimals}}))
 {% endmacro %}