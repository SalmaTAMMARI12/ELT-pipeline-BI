{% set form_id = 32 %}

{{ config(
    materialized='view',
    alias='pivot_form32'
) }}

{{ generate_pivot_sql(form_id) }}
