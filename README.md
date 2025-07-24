# 📦 Data Pipeline: MySQL to PostgreSQL + Kafka + Dagster + DBT + Metabase

Ce projet met en place un pipeline de données complet qui :

- 🔄 **Migre les données** de **MySQL** vers **PostgreSQL** (via `pgloader`)  
- 🔁 **Capture les changements** avec **Debezium** et les transmet à **Kafka**  
- ⚙️ **Orchestre** les traitements avec **Dagster**  
- 🛠️ **Transforme** les données dans PostgreSQL avec **DBT**  
- 📊 **Analyse et visualise** les données dans **Metabase**

---

## 📚 Table des matières

1. [Architecture du Pipeline](#-architecture-overview)  
2. [Installation et Configuration de la Partie Extraction](#-extraction-migration)  
3. [Installation et Configuration de DBT](#-dbt-installation-et-configuration)  
4. [Intégration Dagster](#-dagster-integration)  
5. [Installation et Configuration de Metabase](#-metabase-installation-et-configuration)  
6. [Démarrage du Pipeline](#-demarrage-du-pipeline)  

---

## 🗺️ Architecture du Pipeline

Voici l’architecture globale de la solution :
![Diagramme d’architecture](pipeline_de_données.png)


```text
MySQL (source) 
  │
  ├──▶ pgloader (migration initiale)
  │
  └──▶ Debezium → Kafka (CDC)
                          │
                          └──▶ Dagster (orchestration)
                                    │
                                    ├──▶ DBT (transformations SQL dans PostgreSQL)
                                    │
                                    └──▶ PostgreSQL (données transformées)
                                                │
                                                └──▶ Metabase (visualisation)

Pipeline ELT : Extract, Load, Transform
Extraction : les données sont extraites de MySQL (source).

Chargement : les données brutes sont chargées dans PostgreSQL, via pgloader (migration initiale) ou via Debezium + Kafka (CDC en temps réel).

Transformation : DBT transforme et modélise les données dans PostgreSQL, préparant les tables pour l’analyse.

Visualisation : Metabase permet de créer des dashboards basés sur les données transformées.

L’orchestration globale est gérée par Dagster qui lance les étapes DBT, contrôle la qualité des données, etc.
🔧 Extraction & Migration (pgloader, Debezium, Kafka)
🐳 Docker Services
Service	Description
source-mysql	MySQL 5.7 instance with initialized data
target-postgres	PostgreSQL 15 for storing migrated data
pgloader	One-time migration from MySQL to PostgreSQL
zookeeper	Zookeeper instance required for Kafka
kafka	Apache Kafka message broker
debezium	Debezium CDC connector for MySQL to Kafka
metabase	Visualization and BI dashboard
🛠️ Prérequis
Python (pour Dagster dans data_pipeline/data_pipeline/):

bash
Copier
Modifier
pip install great-expectations==0.15.50 pandas==1.5.3 numpy==1.23.5 SQLAlchemy==1.4.5
pip install dagster==1.11.2 dagster-webserver==1.11.2 dagster-graphql==1.11.2 \
            dagster-dbt==0.27.2 dagster-postgres==0.27.2 dagster-ge==0.27.2
🚀 Démarrage - Extraction & Migration
Cloner le dépôt

bash
Copier
Modifier
git clone <repo-url>
cd <repo-folder>
Lancer la stack Docker

bash
Copier
Modifier
docker-compose up --build
⚠️ Assurez-vous que les ports 3307, 5433, 29092, 8083 et 3001 sont libres.

Accès aux services

Metabase: http://localhost:3001

Dagster: http://localhost:3000 (après démarrage avec dagster dev)

Identifiants des bases

Composant	Host	Port	DB Name	User	Password
MySQL	localhost	3307	uatrs_db	uatrs_user	uatrs_pass
PostgreSQL	localhost	5433	uatrs_db	uatrs_user	uatrs_pass

🛠️ DBT Installation et Configuration
Créer un environnement virtuel et activer

bash
Copier
Modifier
python -m venv dbt_venv
# Sur Windows PowerShell
.\dbt_venv\Scripts\Activate.ps1
# Sur Linux/Mac
source dbt_venv/bin/activate
Installer DBT

bash
Copier
Modifier
pip install dbt-core dbt-postgres
Cloner le projet DBT (ou utiliser le dossier existant)

bash
Copier
Modifier
git clone https://github.com/Idriss-Abidi/DataWarehouse_BI
Configurer le fichier profiles.yml

Exemple :

yaml
Copier
Modifier
dbt_proj:
  outputs:
    dev:
      type: "postgres"
      host: "localhost"
      user: "your_user"
      password: "your_password"
      port: 5432
      dbname: "ourDatabase"
      schema: "public"
      threads: 1
  target: "dev"
Tester la connexion

bash
Copier
Modifier
dbt debug
Lancer les transformations

bash
Copier
Modifier
dbt run
⚙️ Dagster Integration
Installer Dagster et plugins DBT

bash
Copier
Modifier
pip install dagster dagster-dbt dagster-webserver
Scaffold un projet Dagster DBT

bash
Copier
Modifier
dagster-dbt project scaffold --project-name my_dagster_project --dbt-project-dir <path_to_dbt_project>
Lancer Dagster

bash
Copier
Modifier
cd my_dagster_project
dagster dev -p 5000
Interface accessible sur http://localhost:5000

📊 Metabase Installation et Configuration
Installer Metabase avec Docker

bash
Copier
Modifier
docker pull metabase/metabase
docker run -d --name metabase -p 3000:3000 <path_to_dashboard_folder>:/metabase.db metabase/metabase
Accéder à Metabase

http://localhost:3000

Configurer la connexion à PostgreSQL

Database Name: <database_name>

Host: host.docker.internal

Port: 5432

Username: postgres (ou celui configuré)

Password: <votre_mot_de_passe>

Créer vos dashboards

🏁 Démarrage complet du pipeline
docker-compose up --build pour lancer les services

dagster dev -p 5000 pour Dagster

Accéder aux dashboards Metabase

Lancer les pipelines et transformations via Dagster

T


