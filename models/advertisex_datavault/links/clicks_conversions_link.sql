{{
    config(
        materialized ='incremental'
    )
}}

{%- set source_model = "v_stg_clicks_conversions" -%}
{%- set src_pk = "clicks_conversions_hk" -%}
{%- set src_fk = ["user_id","clicks_conversions_hk"] -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                    src_source=src_source, source_model=source_model) }}
