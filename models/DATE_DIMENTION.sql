with cte as (
    select
        -- Use unique aliases and avoid functions in the alias name
        TO_TIMESTAMP(STARTED_AT) as STARTED_TIMESTAMP,
        DATE(TO_TIMESTAMP(STARTED_AT)) as STARTED_DATE,
        HOUR(TO_TIMESTAMP(STARTED_AT)) as STARTED_HOUR,

        case
            when DAYNAME(DATE(TO_TIMESTAMP(STARTED_AT))) in ('Sat', 'Sun')
            then 'WEEKEND'
            else 'BUSINESSDAY' 
        end as DAY_TYPE,

        case 
            when MONTH(TO_TIMESTAMP(STARTED_AT)) in (12, 1, 2) then 'WINTER'
            when MONTH(TO_TIMESTAMP(STARTED_AT)) in (3, 4, 5) then 'SPRING'
            when MONTH(TO_TIMESTAMP(STARTED_AT)) in (6, 7, 8) then 'SUMMER'
            when MONTH(TO_TIMESTAMP(STARTED_AT)) in (9, 10, 11) then 'FALL'
        end as SEASON_OF_YEAR

    from {{ source('DEMO', 'BIKE') }}
    -- Ensure we are not trying to parse the header row if it exists in the data
    where STARTED_AT != 'started_at'
)

select *
from cte



