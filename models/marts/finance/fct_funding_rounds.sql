with fundings as (
    select * from {{ ref('stg_rgeron__fundings') }}
),

companies as (
    select * from {{ ref('stg_rgeron__companies') }}
),

final as (
    select
        f.funding_id,
        f.company_id,
        c.company_name,
        c.country_code,
        f.funding_name,
        {{ categorize_funding_round('f.investment_type') }} as funding_stage_category,
        f.investment_type,
        f.announced_on,
        f.raised_amount_usd,
        f.post_money_valuation_usd,
        f.investor_count
    from fundings f
    left join companies c on f.company_id = c.company_id
)

select * from final
