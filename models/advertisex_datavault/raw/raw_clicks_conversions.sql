{{
    config(
        materialized ='view'
    )
}}

select
id,
user_id,
ad_campaign_id,
event_timestamp,
conversion_type,
load_date
from {{source("advertisex","clicks_conversions")}}