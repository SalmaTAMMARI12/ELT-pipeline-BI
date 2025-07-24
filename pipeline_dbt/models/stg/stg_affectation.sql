with source as (
    select *
    from {{ ref('src_affectation') }}
)
select id as affectation_id,
    expert_id,
    application_id,
    status,
    round_id
from source
where status::text in ('in_progress', 'completed')
    and expert_id is not null
    and application_id is not null
    and round_id is not null
    and expert_id IS NOT NULL
    and application_id IS NOT NULL
    and round_id IS NOT NULL -- Exclude rows with empty strings or nulls