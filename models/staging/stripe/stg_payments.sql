select
    orderid as order_id,
    paymentmethod as payment_method,
    status,
    amount
from raw.stripe.payment