{{
    config(
        materialized='view'
    )
}}

{# Staging: transformations minimales - renommage, types, filtres de base #}
{# Source: bigquery-public-data.google_trends.top_terms (US, par DMA) #}

with source as (
    select *
    from {{ source('google_trends', 'top_terms') }}
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
        'US' as dataset_type
    from source
)

select * from renamed
