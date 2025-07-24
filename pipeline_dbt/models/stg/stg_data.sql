with source as (
    select *
    from {{ ref('src_data') }}
)
SELECT id AS data_id,
    application_id,
    field_id,
    value
FROM source
WHERE application_id IS NOT NULL