{% snapshot snapshot__orders %}

{{
    config(
      unique_key='id',
      strategy='timestamp',
      updated_at='_etl_loaded_at',
    )
}}

select
    id,
    user_id,
    order_date,
    status,
    _etl_loaded_at,
from {{source("jaffle_shop","orders")}}

{% endsnapshot %}
