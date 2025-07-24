WITH source AS (
    SELECT *
    FROM {{ ref('stg_organization') }}
)
SELECT DISTINCT organization_id,
    organization_name,
    city,
    country
FROM source
WHERE organization_id IS NOT NULL
    AND organization_name IS NOT NULL
    AND organization_name != ''
    AND city IS NOT NULL
    AND city != ''
    AND country IS NOT NULL
    AND country != ''
    AND country != 'null'
    AND country != 'NULL'
    AND country != 'None'
    AND country != 'none'