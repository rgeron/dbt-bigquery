with fundings as (
    select * from {{ ref('stg_rgeron__fundings') }}
),

metrics as (
    select
        company_id,
        count(funding_id) as total_funding_rounds,
        sum(raised_amount_usd) as total_funding_raised_usd,
        min(announced_on) as first_funding_date,
        max(announced_on) as last_funding_date,
        avg(raised_amount_usd) as avg_round_size_usd
    from fundings
    group by company_id
)

select * from metrics
