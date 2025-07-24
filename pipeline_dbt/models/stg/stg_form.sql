with source as (
    select *
    from {{ ref('src_form') }}
)
select id as form_id,
    program_id,
    organization_id,
    created_by_id,
    closed_by_id,
    close_confirmed_by_id,
    name,
    form_json,
    type,
    description,
    start
    timezone,
    created,
    auto_launch,
    status,
    closed,
    closed_on,
    close_confirmed,
    close_confirmed_on,
    level,
    evaluation_system_id,
    expired,
    is_paginated
from source