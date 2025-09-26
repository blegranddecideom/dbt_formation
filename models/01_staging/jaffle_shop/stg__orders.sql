{{
    config(
        materialized='incremental',
        unique_key='order_id'
    )
}}

{% set clause_where_filtre = "" %}

{% if target.name == 'default' %}
    {% set clause_where_filtre = "where year(order_date) <= year(current_date())" %}
{% endif %}

{% set clause_where = clause_where_filtre %}

{% if is_incremental() %}
    {% set clause_where = clause_where_filtre ~ " and order_date > (select coalesce(max(order_date), '1900-01-01') from " ~ this ~ ")" %}
{% endif %}

select
    id as order_id,
    user_id as customer_id,
    order_date,
    status,
from {{ source('jaffle_shop', 'orders') }}
{{clause_where}}

