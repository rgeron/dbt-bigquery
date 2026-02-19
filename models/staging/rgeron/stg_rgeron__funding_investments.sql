with source as (
    select * from {{ source('rgeron', 'funding_investments') }}
),

renamed as (
    select
        *
    from source
)

select * from renamed
