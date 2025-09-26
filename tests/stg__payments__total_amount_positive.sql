{{config(enabled=true)}}

select
    order_id as value_field,
    sum(amount) as n_records

from {{ ref('stg__payments') }}
group by order_id
having  sum(amount) <0

