WITH app AS (
    SELECT *
    FROM {{ ref('stg_application') }}
),
prog AS (
    SELECT *
    FROM {{ ref('stg_program') }}
),
org AS (
    SELECT *
    FROM {{ ref('dim_organization') }}
),
thematiques AS (
    SELECT *
    FROM {{ ref('dim_thematique') }}
)
SELECT app.application_id,
    app.submitted_on,
    EXTRACT(YEAR FROM app.submitted_on) AS year,
    app.organization_id,
    org.organization_name,
    org.city,
    org.country,
    app.program_id,
    prog.program_name,
    prog.city AS program_city,
    prog.country AS program_country,
    thematiques.thematique
FROM app
    LEFT JOIN prog ON app.program_id = prog.program_id
    LEFT JOIN org ON app.organization_id = org.organization_id
    LEFT JOIN thematiques ON app.application_id = thematiques.application_id 