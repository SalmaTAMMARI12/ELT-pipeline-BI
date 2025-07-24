@echo off
REM Se placer dans le dossier racine du projet
cd /d %~dp0

REM Activer l'environnement virtuel
call venv\Scripts\activate

REM Charger les variables d'environnement via env.bat (dans pipeline_dbt)
call pipeline_dbt\env.bat

REM Lancer le script Python à la racine
python ..\script.py

echo ✅ Script exécuté avec succès
pause
