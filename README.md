# dbt project (BigQuery)

## Setup

1. Install dbt for BigQuery:

```bash
python -m pip install --upgrade pip
pip install dbt-bigquery
```

2. Create your dbt profile:

- Copy `profiles.yml.example` to `~/.dbt/profiles.yml`
- Replace `project: your-gcp-project-id`
- Ensure `dataset: mydataset` matches where you want dbt to build models

## Run

```bash
dbt debug
dbt build
```

## Notes on your sources

- `google_trends.top_terms` points at the public dataset: `bigquery-public-data.google_trends.top_terms`
- `raw_trends.trends` points at `{{ target.database }}.mydataset.trends`
# dbt-bigquery
