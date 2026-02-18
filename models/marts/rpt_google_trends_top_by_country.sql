{{
    config(
        materialized='table'
    )
}}

{#
    Mart: Rapport des tops termes actuels par pays
    Vue synthétique pour analyses par pays - derniers termes les plus recherchés
#}

with latest_data as (
    select *
    from {{ ref('stg_google_trends__international_top_terms') }}
    where week = (select max(week) from {{ ref('stg_google_trends__international_top_terms') }})
)

select
    country_name,
    country_code,
    coalesce(region_name, 'All') as region_name,
    term,
    rank,
    score
from latest_data
order by country_name, rank
