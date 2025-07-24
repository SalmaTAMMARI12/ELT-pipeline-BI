{% set form_id = 36 %}

{{ config(
    materialized='view',
    alias='pivot_form36'
) }}

{{ generate_pivot_sql(form_id) }}
