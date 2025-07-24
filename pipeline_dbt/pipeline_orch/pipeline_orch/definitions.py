import os
from dagster import Definitions
from dagster_dbt import DbtCliResource
from .constants import dbt
from .assets import pipeline_dbt_dbt_assets
from .constants import dbt_project_dir
from .schedules import schedules

defs = Definitions(
    assets=[pipeline_dbt_dbt_assets],
    schedules=schedules,
    resources={"dbt": dbt},
)