SELECT
    pc.product_category_name_english AS Category,
    COUNT(DISTINCT o.order_id) AS Num_order,
    SUM(pay.payment_value) AS Revenue
FROM olist_order_items AS oi
JOIN olist_products AS p ON p.product_id = oi.product_id
JOIN product_category_name_translation AS pc ON pc.product_category_name = p.product_category_name
JOIN olist_orders AS o ON o.order_id = oi.order_id
JOIN olist_order_payments AS pay ON o.order_id = pay.order_id
WHERE 
    o.order_status = 'delivered' AND 
    o.order_delivered_customer_date IS NOT NULL AND 
    p.product_category_name IS NOT NULL
GROUP BY Category
ORDER By Revenue ASC
LIMIT 10
;
