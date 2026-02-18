{% macro trends_partition_filter() %}
    {#
        Filtre de partition pour optimiser les coûts BigQuery.
        Évite de scanner les 30 jours de rétention.
        Override via var: trends_partition_days (défaut: 1 = hier)
    #}
    DATE_SUB(CURRENT_DATE(), INTERVAL {{ var('trends_partition_days', 1) }} DAY)
{% endmacro %}
