{{
    config(
        materialized='view'
    )
}}

{#
    Intermediate: Derniers top terms par pays (semaine max)
    Agrège les termes les plus récents pour chaque pays
    Inspiration: https://oscarleo.com/google-trends-bigquery/
#}

with latest_international as (
    select
        country_name,
        country_code,
        region_name,
        term,
        rank,
        score,
        week,
        refresh_date
    from {{ ref('stg_google_trends__international_top_terms') }}
    qualify
        row_number() over (
            partition by country_name, region_name, term
            order by week desc, refresh_date desc
        ) = 1
)

select * from latest_international
