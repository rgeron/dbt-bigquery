{% macro categorize_funding_round(funding_round_type) %}
    case 
        when lower({{ funding_round_type }}) in ('pre-seed', 'angel', 'grant') then 'Pre-Seed/Angel'
        when lower({{ funding_round_type }}) in ('seed') then 'Seed'
        when lower({{ funding_round_type }}) in ('series a') then 'Series A'
        when lower({{ funding_round_type }}) in ('series b') then 'Series B'
        when lower({{ funding_round_type }}) in ('series c') then 'Series C'
        when lower({{ funding_round_type }}) in ('series d', 'series e', 'series f', 'series g', 'series h') then 'Late Stage'
        when lower({{ funding_round_type }}) in ('private equity', 'post-ipo equity', 'post-ipo debt', 'secondary market') then 'Private Equity/Post-IPO'
        when lower({{ funding_round_type }}) in ('debt financing', 'convertible note') then 'Debt/Convertible'
        else 'Other'
    end
{% endmacro %}
