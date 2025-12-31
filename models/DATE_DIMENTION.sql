
with cte as (
    select
        TO_TIMESTAMP(STARTED_AT) as STARTED_TIMESTAMP,
        DATE(TO_TIMESTAMP(STARTED_AT)) as STARTED_DATE,
        HOUR(TO_TIMESTAMP(STARTED_AT)) as STARTED_HOUR, 

        -- Call first macro
        {{ DAY_TYPE('STARTED_AT') }} as DAY_TYPE,

        -- Call second macro (Note the comma is at the end of the previous line now)
        {{ SEASON_OF_YEAR('STARTED_AT') }} as station_of_year

    from {{ ref('stg_bike') }}
    where STARTED_AT != 'started_at'
)

select *
from cte