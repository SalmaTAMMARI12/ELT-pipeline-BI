WITH source AS (
  SELECT *
  FROM {{ ref('stg_data') }}
)
SELECT d.application_id,
  d.value AS thematique
FROM source d
  JOIN {{ ref('stg_field') }} f ON d.field_id = f.field_id
WHERE f.name IN (
    'Titre du projet',
    'Résumé',
    'Objectifs',
    'Description détaillée'
  )
  AND d.value IS NOT NULL
  AND d.value != ''
  AND d.value != 'null'
  AND d.value != 'NULL'
  AND d.value != 'None'
  AND d.value != 'none'