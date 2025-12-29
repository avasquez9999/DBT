
{{ config(materialized='table') }}

WITH TRIPS as (
    select
        RIDE_ID,
        -- Convert clean strings to actual dates
        DATE(TO_TIMESTAMP(REPLACE(STARTED_AT, '"', ''))) AS TRIP_DATE,
        START_STATIO_ID AS START_STATION_ID,
        MEMBER_CSUAL AS MEMBER_CASUAL,
        -- Calculate trip duration in seconds
        TIMESTAMPDIFF(
            SECOND, 
            TO_TIMESTAMP(REPLACE(STARTED_AT, '"', '')), 
            TO_TIMESTAMP(REPLACE(ENDED_AT, '"', ''))
        ) AS TRIP_DURATION_SECONDS

    -- Use source() here to match the YML file above
    from {{ source('DEMO', 'BIKE') }}

    where RIDE_ID != '"bikeid"' and RIDE_ID != 'bikeid'
)

select * from TRIPS