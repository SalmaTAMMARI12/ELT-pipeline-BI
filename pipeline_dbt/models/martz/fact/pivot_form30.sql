{% set form_id = 30 %}

{{ config(
    materialized='view',
    alias='pivot_form30'
) }}

{{ generate_pivot_sql(form_id) }}













