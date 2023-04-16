{% macro cents_to_dollars(column_name, decimal_plates=2) %}
   round( {{ column_name }} /  100::decimal, {{ decimal_plates }} )
{% endmacro %}