with source as (
    select * from {{ source('rgeron', 'companies') }}
),

renamed as (
    select
        *
    from source
)

select * from renamed
