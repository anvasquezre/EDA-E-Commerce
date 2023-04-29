SELECT
c.customer_state AS customer_state,
CAST (SUM(p.payment_value) AS FLOAT) AS Revenue
FROM olist_order_payments AS p
JOIN olist_orders AS o
ON o.order_id = p.order_id
JOIN olist_customers AS c
ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered' AND o.order_delivered_customer_date IS NOT NULL
GROUP BY customer_state
ORDER BY Revenue DESC
LIMIT 10
;

