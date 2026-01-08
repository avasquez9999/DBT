select
 *
from {{ source('DEMO', 'BIKE') }}

limit 10 