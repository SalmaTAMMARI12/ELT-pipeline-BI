with source as (
    select *
    from {{ ref('src_user') }}
)
select id as user_id,
    firstname,
    lastname,
    job,
    company,
    phone,
    photo,
    cover,
    created,
    lastvisit,
    lastip,
    email,
    roles,
    password,
    confirmed,
    confirmed_on,
    token,
    organism,
    is_jury,
    country
from source