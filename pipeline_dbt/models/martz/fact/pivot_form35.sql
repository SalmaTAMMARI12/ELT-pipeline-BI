{% set form_id = 35 %}

{{ config(
    materialized='view',
    alias='pivot_form35'
) }}

{{ generate_pivot_sql(form_id) }}
