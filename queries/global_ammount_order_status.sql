
SELECT order_status, COUNT(order_status) as Ammount
FROM olist_orders AS o
GROUP BY order_status
ORDER BY order_status ASC;
