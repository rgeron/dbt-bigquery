{{
    config(
        materialized='table'
    )
}}

{#
    Mart: Table de fait des tendances quotidiennes internationales
    Grain: 1 ligne par (refresh_date, country_name, region_name, term, rank)
    Prêt pour analyses BI / dashboards
#}

select
    refresh_date,
    country_name,
    country_code,
    region_name,
    term,
    rank,
    score,
    week,
    dataset_type
from {{ ref('stg_google_trends__international_top_terms') }}
order by refresh_date desc, country_name, rank
