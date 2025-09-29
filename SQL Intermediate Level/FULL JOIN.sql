-- FULL JOIN
/* Get all customers and all orders, even if there’s no match */

SELECT 
	c.id,
	c.first_name,
	c.country,
	o.order_id,
	o.order_date,
	o.sales
FROM customers AS c
FULL JOIN orders as o
ON c.id = o.customer_id