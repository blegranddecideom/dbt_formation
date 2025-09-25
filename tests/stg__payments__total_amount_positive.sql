select
    count(*) as failures,
    count(*) != 0 as should_warn,
    count(*) != 0 as should_error
from (
with all_values as (

    select
        order_id as value_field,
        sum(amount) as n_records

    from {{ ref('stg__payments') }}
    group by order_id

)
select *
from all_values
where n_records<0 
)