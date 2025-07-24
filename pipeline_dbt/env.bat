@echo off
REM Aller dans le dossier contenant ce script (pipeline_dbt)
cd /d %~dp0

REM Charger chaque ligne de .env si elle contient un "="
for /f "usebackq tokens=1,* delims==" %%A in (".env") do (
    if not "%%A"=="" (
        if not "%%A"=="#" (
            set "%%A=%%B"
        )
    )
)

echo ✅ Variables d'environnement chargées depuis .env
