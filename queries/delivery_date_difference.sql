
SELECT c.customer_state as State,
CAST (ABS(AVG((JULIANDAY(STRFTIME('%Y-%m-%d',o.order_delivered_customer_date)) - JULIANDAY(STRFTIME('%Y-%m-%d',o.order_estimated_delivery_date))))) AS Int)
AS Delivery_Difference
FROM olist_orders AS o
LEFT JOIN olist_customers AS c
ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY State
ORDER BY Delivery_Difference ASC;