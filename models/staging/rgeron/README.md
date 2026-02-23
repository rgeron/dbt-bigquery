# Documentation : Layer de Staging (`models/staging/rgeron`)

Ce dossier contient les modèles de staging dbt pour les données sources du projet `rgeron` (les bases de données issues de `testing-dbt-487819`).

## Objectif du layer de Staging

Le but principal de ces modèles est de préparer les données brutes provenant de BigQuery pour qu'elles puissent être facilement utilisées par les modèles en aval (dossiers `marts`). Les opérations effectuées ici sont basiques mais essentielles pour garantir la cohérence et la qualité des données :

1.  **Renommage :** Uniformisation des noms de colonnes pour respecter les conventions d'ingénierie analytique (ex: `name` en `company_name`, `status` en `company_status`).
2.  **Typage (Casting) :** Conversion explicite des types de données (ex: dates en type `date`, montants financiers en `numeric`, nombres entiers en `int64`) afin d'éviter des erreurs de calcul dans les modèles ultérieurs.
3.  **Nettoyage de base :** Application de macros pour nettoyer ou parser des champs complexes (ex: `clean_description` pour la description et `parse_categories` pour la liste des catégories).
4.  **Dé-duplication et filtrage léger :** Si nécessaire, bien que cette couche se concentre principalement sur le nettoyage en ligne.

## Modèles inclus

- **`stg_rgeron__companies.sql`** : Modèle de la table `companies`. Traduit les principales caractéristiques des startups. Cette table subit un nettoyage approfondi sur la description et les catégories professionnelles, et les montants/dates sont proprement typés. Cette table est triée par date de fondation (`founded_on`).
- **`stg_rgeron__fundings.sql`** : Modèle de la table `fundings`. Traite les différents événements de levées de fonds par entreprise. Prépare notamment les dates d'annonce et standardise les types de variables contenant des montants ou le nombre d'investisseurs.
- **`stg_rgeron__funding_investments.sql`** : Modèle de la table `funding_investments`. Contient la granularité fine des investissements (au niveau de chaque intervenant ou organisme pour une levée donnée). Actuellement, il récupère les champs natifs et assure la sélection standardisée.
- **`src_rgeron.yml`** : Le fichier YAML d'initialisation déclarant les tables brutes comme sources de données pour dbt. Cela nous permet d'utiliser la fonction `{{ source(...) }}` dans nos modèles `SQL` ci-dessus pour bâtir en toute fiabilité le tracking du lineage.

## Utilisation

Ces modèles ne doivent pas être liés entre eux (`JOIN`) ici. Les jointures et la logique métier complexe (telles que le calcul des montants totaux cumulés ou l'agrégation de séries) doivent être appliquées dans des couches plus éloignées (les layers `intermediate` ou de `marts`). Les tables créées par ce dossier de staging sont considérées comme les uniques "portes d'entrée" vers la donnée brute pour les niveaux d'analyses supérieurs.
