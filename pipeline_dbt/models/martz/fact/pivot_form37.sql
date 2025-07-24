{% set form_id = 37 %}

{{ config(
    materialized='view',
    alias='pivot_form37'
) }}

{{ generate_pivot_sql(form_id) }}
