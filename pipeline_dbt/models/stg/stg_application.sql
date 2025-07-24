with source as (
    select *
    from {{ ref('src_application') }}
)
SELECT app.id AS application_id,
    app.organization_id,
    app.program_id,
    app.submitted_by_id,
    app.form_id,
    app.submitted,
    app.submitted_on,
    app.created_on
FROM source app
WHERE app.submitted = TRUE