{{
    config(
        materialized ='view'
    )
}}

{%- set yaml_metadata -%}
source_model: "raw_bids_request"
ranked_columns:
    dv_rank:
        partition_by :
            - bids_request_hk
            - bids_request_hashdiff
            - load_date
        order_by :
            id: asc
derived_columns:
    source: "!1"
    record_source: " 'S3' "
    load_date: "load_date"

hashed_columns:
    bids_request_hk: "user_id"
    bids_request_hashdiff:
        is_hashdiff: true
        columns:            
            - "ID"
            - "USER_ID"
            - "AGE"
            - "GENDER"
            - "DEVICE"
            - "TIMESTAMP"
            - "AUCTION_ID"
            - "AD_FORMAT"
            - "AD_POSITION"
            - "AD_RANK"
            - "BID_AMOUNT"
            - "QUALITY_SCORE"
            - "AUDIENCE_AGE"
            - "DAY_PARTING"
            - "AUDIENCE_GENDER"
            - "LOCATION"
            - "LOAD_DATE"  
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



