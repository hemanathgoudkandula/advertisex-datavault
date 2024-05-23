{{
  config(
    apply_source_filter = true,
    materialized = 'incremental'
  )
}}

{%- set yaml_metadata -%}
source_model: "v_stg_clicks_conversions"
src_pk: "clicks_conversions_hk"
src_hashdiff: 
  source_column: "clicks_conversions_hashdiff"
  alias: "HASHDIFF"
src_payload:
    - "USER_ID"
    - "AD_CAMPAIGN_ID"
    - "EVENT_TIMESTAMP"
    - "CONVERSION_TYPE"
    - "LOAD_DATE"
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