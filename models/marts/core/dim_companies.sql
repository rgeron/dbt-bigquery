with companies as (
    select * from {{ ref('stg_rgeron__companies') }}
),

funding_metrics as (
    select * from {{ ref('int_company_funding_metrics') }}
),

country_codes as (
    select * from {{ ref('country_codes') }}
),

final as (
    select
        c.company_id,
        c.company_name,
        c.homepage_url,
        c.company_status,
        c.country_code,
        cc.country_name,
        c.founded_on,
        c.description,
        c.category_list,
        -- Funding metrics
        coalesce(fm.total_funding_rounds, 0) as total_funding_rounds,
        coalesce(fm.total_funding_raised_usd, 0) as total_funding_raised_usd,
        fm.first_funding_date,
        fm.last_funding_date,
        fm.avg_round_size_usd
    from companies c
    left join funding_metrics fm on c.company_id = fm.company_id
    left join country_codes cc on c.country_code = cc.country_code
)

select * from final
