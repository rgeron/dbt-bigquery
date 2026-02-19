with source as (
    select * from {{ source('rgeron', 'fundings') }}
),

renamed as (
    select
        funding_id,
        company_id,
        crunchbase_organization_id,
        funding_name,
        investment_type,
        cast(announced_on as date) as announced_on,
        cast(raised_amount_usd as numeric) as raised_amount_usd,
        cast(post_money_valuation_usd as numeric) as post_money_valuation_usd,
        cast(investor_count as int64) as investor_count
    from source
)

select * from renamed
