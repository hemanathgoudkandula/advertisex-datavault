{{
    config(
        materialized ='view'
    )
}}

select
id,
user_id,
ad_Creative_id,
timestamp,
website,
load_date
from {{source('ad_impressions','AD_IMPRESSIONS')}}

