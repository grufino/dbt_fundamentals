with payments as (

    select * from {{ ref('stg_payments')}}

),

orders as (

    select * from {{ ref('stg_orders') }}

),

payment_orders as (

    select
        order_id,
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,
        sum(amount) as total_amount
    from orders

    left join payments using (order_id)
    left join stg_customers using (customer_id)
    where payments.status = 'success'
    group by order_id, customer_id

)

select * from payment_orders