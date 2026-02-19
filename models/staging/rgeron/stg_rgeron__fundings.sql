with source as (
    select * from {{ source('rgeron', 'fundings') }}
),

renamed as (
    select
        *
    from source
)

select * from renamed
