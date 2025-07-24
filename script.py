import os
import psycopg2
from dotenv import load_dotenv
# 1. Charger les variables d’environnement
env_path = os.path.join("pipeline_dbt", ".env")
load_dotenv(dotenv_path=env_path)
# 2. Récupération des variables
host = os.getenv("DBT_HOST")
port = os.getenv("DBT_PORT")
user = os.getenv("DBT_USER")
password = os.getenv("DBT_PASSWORD")
dbname = os.getenv("DBT_DB")
# 3. Connexion à PostgreSQL
try:
    conn = psycopg2.connect(
        host=host,
        port=port,
        user=user,
        password=password,
        dbname=dbname
    )
    cursor = conn.cursor()
except Exception as e:
    raise ConnectionError(f" Connexion échouée : {e}")

# 4. Récupération des form_id
schema = "staging"
try:
    cursor.execute(f"SELECT DISTINCT form_id FROM {schema}.stg_form ORDER BY form_id")
    form_ids = cursor.fetchall()
except Exception as e:
    raise RuntimeError(f" Erreur récupération form_id : {e}")

# 5. Génération des fichiers SQL
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
output_dir = os.path.join(BASE_DIR, "pipeline_dbt", "models", "martz", "fact")
os.makedirs(output_dir, exist_ok=True)
count = 0
for (form_id,) in form_ids:
    alias = f"pivot_form{form_id}"
    filename = f"{alias}.sql"
    filepath = os.path.join(output_dir, filename)
    with open(filepath, "w", encoding="utf-8") as f:
        f.write(
            f"""{{% set form_id = {form_id} %}}

{{{{ config(
    materialized='view',
    alias='{alias}'
) }}}}

{{{{ generate_pivot_sql(form_id) }}}}
"""
        )
    count += 1
print(f"{count} fichiers SQL générés dans {output_dir}")
