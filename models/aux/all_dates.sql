{{
  config(
    materialized = "table"
  )
}}

{{ dbt_utils.date_spine(
    datepart='day',
    start_date="'2020-01-01'::date",
    end_date="'2020-12-31'::date"
)}}