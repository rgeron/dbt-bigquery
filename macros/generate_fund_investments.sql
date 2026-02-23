{% macro generate_fund_investments(fund_name) %}

with companies as (
    select * from {{ ref('stg_rgeron__companies') }}
),

fundings as (
    select * from {{ ref('stg_rgeron__fundings') }}
),

investments as (
    select * from {{ ref('stg_rgeron__funding_investments') }}
),

target_investments as (
    select *
    from investments
    where lower(investor_name) like '%{{ fund_name | lower }}%'
),

final as (
    select
        -- Investment details
        i.investment_id,
        i.investor_name,
        i.investor_type,
        i.is_lead_investor,
        
        -- Funding round details
        f.funding_id,
        f.funding_name,
        f.investment_type,
        f.announced_on as funding_announced_on,
        f.raised_amount_usd as funding_raised_amount_usd,
        f.post_money_valuation_usd,
        f.investor_count as round_investor_count,
        
        -- Company details
        c.company_id,
        c.company_name,
        c.company_status,
        c.country_code as company_country_code,
        c.founded_on as company_founded_on,
        c.category_list as company_category_list,
        c.total_funding_usd as company_total_funding_usd
        
    from target_investments i
    left join fundings f on i.funding_id = f.funding_id
    left join companies c on f.company_id = c.company_id
)

select * from final

{% endmacro %}
