{% if target.name=='default' %}
{% set clause_where = 'Where Year(order_date)=Year(current_date())' %}
{% endif %}

select
    id as order_id,
    user_id as customer_id,
    order_date,
    status,
from {{ source('jaffle_shop', 'orders') }}
{{clause_where}}