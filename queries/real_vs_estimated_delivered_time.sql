WITH time_stamps AS
(SELECT
        strftime('%m', order_purchase_timestamp) AS month_no,
	strftime('%Y', order_purchase_timestamp) AS year,
        (JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_purchase_timestamp)) AS real_time,
        (JULIANDAY(order_estimated_delivery_date) - JULIANDAY(order_purchase_timestamp)) AS estimated_time
FROM olist_orders
WHERE order_status = 'delivered' AND order_delivered_customer_date IS NOT NULL
)
SELECT month_no,
substr ("--JanFebMarAprMayJunJulAugSepOctNovDec", month_no * 3, 3) AS month,
AVG(CASE WHEN year = '2016' THEN real_time ELSE Null END) AS Year2016_real_time,
AVG(CASE WHEN year = '2017' THEN real_time ELSE Null END) AS Year2017_real_time,
AVG(CASE WHEN year = '2018' THEN real_time ELSE Null END) AS Year2018_real_time,
AVG(CASE WHEN year = '2016' THEN estimated_time ELSE Null END) AS Year2016_estimated_time,
AVG(CASE WHEN year = '2017' THEN estimated_time ELSE Null END) AS Year2017_estimated_time,
AVG(CASE WHEN year = '2018' THEN estimated_time ELSE Null END) AS Year2018_estimated_time 
FROM time_stamps
GROUP BY month_no;