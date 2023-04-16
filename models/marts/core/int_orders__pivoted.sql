{%- set my_payment_methods_query -%}
SELECT DISTINCT payment_method 
FROM {{ ref('stg_payments') }} 
ORDER BY 1
{%- endset -%}

{%- set rows = run_query(my_payment_methods_query) -%}

{%- if execute -%}
{%- set payment_methods = rows.columns[0].values() %}
{%- else %}
{%- set payment_methods = [] -%}
{%- endif -%}


SELECT order_id,
    {%- for payment_method in payment_methods %}
    SUM(CASE WHEN payment_method = '{{ payment_method }}' THEN AMOUNT ELSE 0 END) AS {{ payment_method }}_amount
    {%- if not loop.last -%}
    ,
    {%- endif -%}
    {%- endfor %}
FROM {{ ref('stg_payments') }}
WHERE STATUS = 'success'
GROUP BY 1