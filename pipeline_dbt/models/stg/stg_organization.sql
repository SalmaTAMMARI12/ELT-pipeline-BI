with source as (
    select *
    from {{ ref('src_organization') }}
)
SELECT id AS organization_id,
    name AS organization_name,
    city,
    country,
    email
FROM source