# dbt

Projet dbt structuré selon les bonnes pratiques.

## Données sources

dataset: rgeron

- companies
- funding_investments
- fundings

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
  trends_partition_days: 1 # 1 = hier, 7 = dernière semaine, etc.
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

| Couche           | Rôle                                  | Materialization |
| ---------------- | ------------------------------------- | --------------- |
| **Staging**      | Renommage, types, filtres de base     | View            |
| **Intermediate** | Jointures, agrégations intermédiaires | View            |
| **Marts**        | Tables business-ready pour BI         | Table           |

- **Sources** : Déclaration YAML avec `source()` pour traçabilité
- **Tests** : `not_null` sur les clés (refresh_date, term, rank)
- **Filtre de partition** : Toujours appliqué pour limiter le scan BigQuery (1 TB/mois gratuit)
