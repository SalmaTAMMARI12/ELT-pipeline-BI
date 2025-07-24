with source as (
    select *
    from {{ ref('src_program') }}
)
SELECT id AS program_id,
    organization_id,
    name AS program_name,
    start,
    city,
    country
FROM source