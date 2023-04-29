WITH temp_table AS
(
SELECT
    strftime('%m', o.order_delivered_customer_date) AS month_no,
	strftime('%Y', o.order_delivered_customer_date) AS year,
    p.payment_value AS revenue
FROM olist_orders as o
JOIN olist_order_payments as p
ON o.order_id = p.order_id
WHERE o.order_status = 'delivered' AND o.order_delivered_customer_date IS NOT NULL AND o.order_purchase_timestamp IS NOT NULL
GROUP BY o.order_id 
)
SELECT month_no,
substr ("--JanFebMarAprMayJunJulAugSepOctNovDec", month_no * 3, 3) AS month,
SUM(CASE WHEN year = '2016' THEN revenue ELSE '0.00' END) AS Year2016,
SUM(CASE WHEN year = '2017' THEN revenue ELSE '0.00' END) AS Year2017,
SUM(CASE WHEN year = '2018' THEN revenue ELSE '0.00' END) AS Year2018
FROM temp_table
GROUP BY month_no
ORDER By month_no ASC
;

