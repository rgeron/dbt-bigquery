with fundings as (
    select * from {{ ref('stg_rgeron__fundings') }}
),

companies as (
    select * from {{ ref('dim_companies') }}
),

joined as (
    select
        f.permalink,
        f.company_name,
        f.company_category_list,
        f.funding_round_type,
        f.funded_at,
        f.raised_amount_usd,
        c.status,
        c.country_code,
        c.region,
        c.city
    from fundings f
    left join companies c on f.permalink = c.permalink
)

select * from joined
