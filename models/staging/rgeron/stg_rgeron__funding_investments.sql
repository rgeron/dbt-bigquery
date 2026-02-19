with source as (
    select * from {{ source('rgeron', 'funding_investments') }}
),

renamed as (
    select
        investment_id,
        funding_id,
        is_lead_investor,
        investor_name,
        investor_type
    from source
)

select * from renamed
