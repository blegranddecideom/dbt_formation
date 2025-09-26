{{
    config(
        materialized='table'       
    )
}}
with my_cte as (
    select     
        id as product_id,
        groupe,
        description,
        desactivated_date
from {{ source('jaffle_shop', 'product') }}
),
deduplicated_cte as (
  {{ dbt_utils.deduplicate(
      relation='my_cte',
      partition_by='product_id',
      order_by='desactivated_date desc',
     )
  }}
)
select * from deduplicated_cte