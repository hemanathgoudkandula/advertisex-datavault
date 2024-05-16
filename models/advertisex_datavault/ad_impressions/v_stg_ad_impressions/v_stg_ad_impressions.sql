{{
    config(
        materialized ='view'
    )
}}

{%- set yaml_metadata -%}
source_model: "raw_ad_impressions"
ranked_columns:
    dv_rank:
        partition_by :
            - ad_impressions_hk
            - ad_impressions_hashdiff
            - load_date
        order_by :
            load_date: asc
derived_columns:
    source: "!1"
    record_source: " 'S3' "
    load_date: "load_date"

hashed_columns:
    ad_impressions_hk: "user_id"
    ad_impressions_hashdiff:
        is_hashdiff: true
        columns:
        - "id"
        - "user_id"
        - "ad_creative_id"
        - "timestamp"
        - "website"
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