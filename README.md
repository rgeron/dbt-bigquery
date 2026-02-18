# dbt Google Trends

Projet dbt structuré selon les bonnes pratiques pour travailler avec les données **Google Trends open source** sur BigQuery.

## Données sources

- **Dataset**: `bigquery-public-data.google_trends`
- **Tables**:
  - `top_terms` – Top 25 termes US par DMA (Nielsen)
  - `top_rising_terms` – Top 25 termes à la croissance la plus rapide US
  - `international_top_terms` – Top 25 termes internationaux (~50 pays)
  - `international_top_rising_terms` – Top 25 rising internationaux

[Documentation Google Trends BigQuery](https://support.google.com/trends/answer/12764470)

## Structure du projet (bonnes pratiques dbt)

```
models/
├── staging/                    # Couche staging (sources → vues conformes)
│   └── google_trends/
│       ├── stg_google_trends__top_terms.sql
│       ├── stg_google_trends__top_rising_terms.sql
│       ├── stg_google_trends__international_top_terms.sql
│       └── stg_google_trends__international_top_rising_terms.sql
├── intermediate/               # Transformations intermédiaires
│   └── int_google_trends__latest_international.sql
└── marts/                      # Tables business-ready
    ├── fct_google_trends_daily_international.sql
    └── rpt_google_trends_top_by_country.sql
```

## Setup

1. **Installer dbt pour BigQuery** :

```bash
pip install dbt-bigquery
```

2. **Configurer le profil** :

```bash
cp profiles.yml.example ~/.dbt/profiles.yml
# Éditer ~/.dbt/profiles.yml : remplacer your-gcp-project-id et mydataset
```

3. **Partition filter** (optionnel) – Pour optimiser les coûts BigQuery, le filtre de partition utilise la veille par défaut. Modifier dans `dbt_project.yml` :

```yaml
vars:
  trends_partition_days: 1  # 1 = hier, 7 = dernière semaine, etc.
```

## Commandes

```bash
dbt debug          # Vérifier la connexion
dbt deps           # Dépendances (si packages)
dbt build          # Compiler et exécuter tous les modèles + tests
dbt run            # Exécuter les modèles uniquement
dbt test           # Lancer les tests
dbt docs generate  # Générer la documentation
dbt docs serve     # Servir la doc (interface web)
```

## Bonnes pratiques appliquées

| Couche | Rôle | Materialization |
|--------|------|-----------------|
| **Staging** | Renommage, types, filtres de base | View |
| **Intermediate** | Jointures, agrégations intermédiaires | View |
| **Marts** | Tables business-ready pour BI | Table |

- **Sources** : Déclaration YAML avec `source()` pour traçabilité
- **Tests** : `not_null` sur les clés (refresh_date, term, rank)
- **Filtre de partition** : Toujours appliqué pour limiter le scan BigQuery (1 TB/mois gratuit)
