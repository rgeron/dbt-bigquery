{{
    config(
        materialized='view'
    )
}}

{# Staging: Top 25 termes internationaux #}

with source as (
    select *
    from {{ source('google_trends', 'international_top_terms') }}
    where refresh_date = {{ trends_partition_filter() }}
),

renamed as (
    select
        refresh_date,
        week,
        country_name,
        country_code,
        region_name,
        term,
        rank,
        cast(score as int64) as score,
        'international' as dataset_type
    from source
)

select * from renamed
