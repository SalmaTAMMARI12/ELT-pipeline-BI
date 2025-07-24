{% set form_id = 33 %}

{{ config(
    materialized='view',
    alias='pivot_form33'
) }}

{{ generate_pivot_sql(form_id) }}
