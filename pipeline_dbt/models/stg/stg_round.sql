with source as (
    select * from {{ ref('src_round') }}
)
select
    id as round_id,
    program_id,
    scoring_system_id,
    name,
    status,
    created,
    has_scoring_form,
    has_program_form,
    application_form_id,
    evaluation_form_id,
    step
from source
