{% set form_id = 31 %}

{{ config(
    materialized='view',
    alias='pivot_form31'
) }}

{{ generate_pivot_sql(form_id) }}
