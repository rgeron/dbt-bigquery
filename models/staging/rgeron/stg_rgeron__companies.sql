with source as (
    select * from {{ source('rgeron', 'companies') }}
),

renamed as (
    select
        company_id,
        name as company_name,
        homepage_url,
        status as company_status,
        country_code,
        cast(num_funding_rounds as int64) as num_funding_rounds,
        cast(total_funding_usd as numeric) as total_funding_usd,
        cast(founded_on as date) as founded_on,
        description,
        category_list
    from source
)

select * from renamed
