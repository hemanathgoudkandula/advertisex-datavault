{{
    config(
        materialized ='view'
    )
}}

select
ID,
USER_ID,
AGE,
GENDER,
DEVICE,
TIMESTAMP,
AUCTION_ID,
AD_FORMAT,
AD_POSITION,
AD_RANK,
BID_AMOUNT,
QUALITY_SCORE,
AUDIENCE_AGE,
DAY_PARTING,
AUDIENCE_GENDER,
LOCATION ,
LOAD_DATE 

from {{source('advertisex','bids_request')}}