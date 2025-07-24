{% set form_id = 34 %}

{{ config(
    materialized='view',
    alias='pivot_form34'
) }}

{{ generate_pivot_sql(form_id) }}
