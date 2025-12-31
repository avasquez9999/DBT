{% macro function1(x) %}
case when TO_TIMESTAMP({{x}})< CURRENT_DATE then 'past'
else 'future' 
end
{%endmacro%}

{% macro SEASON_OF_YEAR(x) %}
    case 
        when MONTH(TO_TIMESTAMP({{x}})) in (12, 1, 2) then 'WINTER'
        when MONTH(TO_TIMESTAMP({{x}})) in (3, 4, 5) then 'SPRING'
        when MONTH(TO_TIMESTAMP({{x}})) in (6, 7, 8) then 'SUMMER'
        when MONTH(TO_TIMESTAMP({{x}})) in (9, 10, 11) then 'FALL'
    end
{% endmacro %}

{% macro  DAY_TYPE(x) %}
    case
            when DAYNAME(DATE(TO_TIMESTAMP({{x}}))) in ('Sat', 'Sun')
            then 'WEEKEND'
            else 'BUSINESSDAY' 
        end
{% endmacro %}