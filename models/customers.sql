with customers as (

    select
        id as customer_id,
        first_name,
        last_name
    from HEVO_ASSESSMENT.HEVO_PUBLIC.RAW_CUSTOMERS

),

orders as (

    select
        user_id as customer_id,
        min(order_date) as first_order,
        max(order_date) as most_recent_order,
        count(*) as number_of_orders
    from HEVO_ASSESSMENT.HEVO_PUBLIC.RAW_ORDERS
    group by user_id

),

payments as (

    select
        o.user_id as customer_id,
        sum(p.amount) as customer_lifetime_value
    from HEVO_ASSESSMENT.HEVO_PUBLIC.RAW_PAYMENTS p
    inner join HEVO_ASSESSMENT.HEVO_PUBLIC.RAW_ORDERS o
        on p.order_id = o.id
    group by o.user_id

)

select
    c.customer_id,
    c.first_name,
    c.last_name,
    o.first_order,
    o.most_recent_order,
    coalesce(o.number_of_orders, 0) as number_of_orders,
    coalesce(p.customer_lifetime_value, 0) as customer_lifetime_value

from customers c
left join orders o
    on c.customer_id = o.customer_id
left join payments p
    on c.customer_id = p.customer_id
