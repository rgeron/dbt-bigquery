{% macro parse_categories(column_name) %}
    (
        select string_agg(
            trim(trim(replace(cat, '""', '"'), '"')),
            '|'
        )
        from unnest(
            split(
                trim(
                    {{ column_name }}, 
                    '{}'
                ),
                case when strpos({{ column_name }}, '|') > 0 then '|' else ',' end
            )
        ) as cat
        where length(trim(cat)) > 0
    )
{% endmacro %}
