
{% macro generate_pivot_sql(form_id) %}

    {% set fields = dbt_utils.get_column_values(
        table=ref('stg_field'),
        column='caption',
        where="form_id = " ~ form_id
    ) %}

    {% set sql %}
    WITH base_data AS (
        SELECT d.application_id, f.caption, d.value
        FROM {{ ref('stg_data') }} d
        JOIN {{ ref('stg_field') }} f ON d.field_id = f.field_id
        WHERE f.form_id = {{ form_id }}
    )
    SELECT
        application_id,
        {% for caption in fields %}
            MAX(CASE WHEN caption = '{{ caption }}' THEN value END) AS "{{ caption }}"{{ "," if not loop.last }}
        {% endfor %}
    FROM base_data
    GROUP BY application_id
    {% endset %}

    {{ return(sql) }}

{% endmacro %}
