with source as (
    select *
    from {{ ref('src_field') }}
)
SELECT id AS field_id,
    name,
    form_id,
    caption
FROM source
WHERE form_id IS NOT NULL