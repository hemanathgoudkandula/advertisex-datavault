{{
  config(
    apply_source_filter = true,
    materialized = 'incremental'
  )
}}

{%- set yaml_metadata -%}
source_model: "v_stg_ad_impressions"
src_pk: "ad_impressions_hk"
src_hashdiff: 
  source_column: "ad_impressions_hashdiff"
  alias: "HASHDIFF"
src_payload:
  - "user_id"
  - "ad_creative_id"
  - "timestamp"
  - "website"
  - "load_date"
src_ldts: "LOAD_DATE"
src_source: "RECORD_SOURCE"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.sat(src_pk=metadata_dict["src_pk"],
                src_hashdiff=metadata_dict["src_hashdiff"],
                src_payload=metadata_dict["src_payload"],                
                src_ldts=metadata_dict["src_ldts"],
                src_source=metadata_dict["src_source"],
                source_model=metadata_dict["source_model"])   }}