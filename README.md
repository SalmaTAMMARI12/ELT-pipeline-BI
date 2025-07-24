# 📦 Data Pipeline: MySQL to PostgreSQL + Kafka + Dagster + DBT + Metabase

Ce projet met en place un pipeline de données complet qui :

- 🔄 **Migre les données** de **MySQL** vers **PostgreSQL** (via `pgloader`)  
- 🔁 **Capture les changements** avec **Debezium** et les transmet à **Kafka**  
- ⚙️ **Orchestre** les traitements avec **Dagster**  
- 🛠️ **Transforme** les données dans PostgreSQL avec **DBT**  
- 📊 **Analyse et visualise** les données dans **Metabase**

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
