with source as (
    select *
    from {{ ref('stg_user') }}
)
select user_id,
    firstname,
    lastname,
    email,
    country,
    -- Correction : utilise PostgreSQL pour extraire le premier rôle d'un tableau JSON
    roles::jsonb ->> 0 as role
from source