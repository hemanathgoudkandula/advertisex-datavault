{{
    config(
        materialized ='incremental'
    )
}}

{%- set source_model = "v_stg_ad_impressions" -%}
{%- set src_pk = "ad_impressions_hk" -%}
{%- set src_fk = ["user_id","ad_impressions_hk"] -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                    src_source=src_source, source_model=source_model) }}
