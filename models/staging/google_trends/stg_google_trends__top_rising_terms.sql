{{
    config(
        materialized='view'
    )
}}

{# Staging: Top 25 termes à la croissance la plus rapide - US #}

with source as (
    select *
    from {{ source('google_trends', 'top_rising_terms') }}
    where refresh_date = {{ trends_partition_filter() }}
),

renamed as (
    select
        refresh_date,
        week,
        dma_name,
        term,
        rank,
        cast(score as int64) as score,
        percent_gained,
        'US' as dataset_type
    from source
)

select * from renamed
