# Data Pipeline: MySQL → PostgreSQL + Kafka + Dagster + DBT + Metabase

Ce projet met en place un pipeline de données complet qui :

-  **Migre les données** de **MySQL** vers **PostgreSQL** (via `pgloader`)  
-  **Capture les changements** avec **Debezium** et les transmet à **Kafka**  
-  **Orchestre** les traitements avec **Dagster**  
- **Transforme** les données dans PostgreSQL avec **DBT**  
- **Analyse et visualise** les données dans **Metabase**




## Table des matières

1. [Architecture du Pipeline](#-architecture-overview)  
2. [Installation et Configuration de la Partie Extraction](#-extraction-migration)  
3. [Installation et Configuration de DBT](#-dbt-installation-et-configuration)  
4. [Intégration Dagster](#-dagster-integration)  
5. [Installation et Configuration de Metabase](#-metabase-installation-et-configuration)  
 

---

## Architecture du Pipeline

Voici l’architecture globale de la solution :
![WhatsApp Image 2025-12-01 à 20 38 00_5f8b65ac](https://github.com/user-attachments/assets/f9cf37d2-2ec2-4e19-85b2-4f9915fd66dc)

- **Pipeline ELT** : Extract, Load, Transform

- **Extraction** : les données sont extraites de MySQL (source).

- **Chargement** : les données brutes sont chargées dans PostgreSQL, via pgloader (migration initiale) ,kafka et via Debezium .

- **Transformation** : DBT transforme et modélise les données dans PostgreSQL, préparant les tables pour l’analyse.

- **Visualisation** : Metabase permet de créer des dashboards basés sur les données transformées.

- **L’orchestration globale** : Elle est gérée par Dagster qui lance les étapes DBT, contrôle la qualité des données, etc.

---
##  Docker Services

Services utilisés :
- **mysql:5.7**
- **postgres:15**
- **confluentinc/cp-kafka**
- **debezium/connect**
- **metabase**
---
##  Getting Started

docker-compose up --build

- **Metabase**: http://localhost:3001

- **Dagster** : http://localhost:3000 

##  DBT Installation et Configuration

Installer DBT:
```bash
dbt debug
```
```bash
dbt deps
```
```bash
dbt run
```
```bash
dbt docs generate
```
```bash
dbt docs serve
```
 
## Détails sur l'exécution de DBT avec variables d’environnement

Avant de lancer les commandes DBT, il est nécessaire d’exécuter un script envbat (ou tout autre script d’environnement) qui permet de charger les variables d’environnement nécessaires au fonctionnement global du pipeline.

Pourquoi exécuter envbat ?

Ce script définit des variables d’environnement (par exemple des chemins, des clés API, des paramètres de connexion...) indispensables au bon fonctionnement des étapes suivantes.

Sans ces variables, certains scripts, notamment le script Python de génération de fichiers SQL, risquent de ne pas fonctionner correctement.

- Lancer le script env.bat
  
```bash
call env.bat
```
- Exécuter le script Python 

Ce script crée automatiquement plusieurs fichiers .sql, un par ID disponible .
Ces fichiers SQL font appel à des macros DBT réutilisables, permettant de standardiser et simplifier les transformations.

```bash

cd <chemin_du_dossier_dbt>
```

## Dagster Integration

Installer Dagster et plugins DBT
```bash
pip install dagster dagster-dbt dagster-webserver
```
```bash
Scaffold un projet Dagster DBT
```
```bash
dagster-dbt project scaffold --project-name my_dagster_project --dbt-project-dir <path_to_dbt_project>
```
Lancer Dagster
```bash
cd my_dagster_project
```
```bash
dagster dev -p 4000
```
 ## Metabase Installation et Configuration
Configurer la connexion à PostgreSQL

- **Database Name**: <database_name>
- **Host**: host.docker.internal
- **Port**: 5432
- **Username**: postgres (ou celui configuré)
- **Password**: <votre_mot_de_passe>

