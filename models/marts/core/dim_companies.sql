with companies as (
    select * from {{ ref('stg_rgeron__companies') }}
)

select * from companies
