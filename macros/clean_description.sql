{% macro clean_description(column_name) %}
    trim(
        trim(
            replace(
                {{ column_name }}, 
                '""', '"'
            ), 
            '"'
        )
    )
{% endmacro %}
