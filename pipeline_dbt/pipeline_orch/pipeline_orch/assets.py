# assets.py
from dagster import AssetExecutionContext
from dagster_dbt import dbt_assets, DbtCliResource
from .constants import dbt, dbt_manifest_path

@dbt_assets(manifest=dbt_manifest_path)
def pipeline_dbt_dbt_assets(context: AssetExecutionContext, dbt: DbtCliResource):
    yield from dbt.cli(["build"], context=context).stream()
