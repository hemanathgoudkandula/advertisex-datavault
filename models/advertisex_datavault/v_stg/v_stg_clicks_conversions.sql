{{
    config(
        materialized ='view'
    )
}}

{%- set yaml_metadata -%}
source_model: "raw_clicks_conversions"
ranked_columns:
    dv_rank:
        partition_by :
            - clicks_conversions_hk
            - clicks_conversions_hashdiff
            - load_date
        order_by :
            id: asc
derived_columns:
    source: "!1"
    record_source: " 'S3' "
    load_date: "load_date"

hashed_columns:
    clicks_conversions_hk: "user_id"
    clicks_conversions_hashdiff:
        is_hashdiff: true
        columns:
        - "id"
        - "user_id"
        - "ad_campaign_id"
        - "event_timestamp"
        - "conversion_type"
        - "load_date"    
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}


WITH staging AS (
{{ automate_dv.stage(include_source_columns=true,
                  source_model=metadata_dict['source_model'],
                  derived_columns=metadata_dict['derived_columns'],
                  hashed_columns=metadata_dict['hashed_columns'],
                  ranked_columns=metadata_dict['ranked_columns']) }}
)

SELECT
  *
FROM staging