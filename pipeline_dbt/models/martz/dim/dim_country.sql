with source as (
    select *
    from {{ ref('stg_organization') }}
)
SELECT DISTINCT country
FROM source
WHERE country IS NOT NULL
    AND country != ''
    AND country != 'null'
    AND country != 'NULL'
    AND country != 'None'
    AND country != 'none'