-- RIGHT ANTI JOIN USING -> LEFT ANTI JOIN
/* Get all customers who haven't place any orders */

SELECT *
FROM orders AS o
LEFT JOIN customers AS c
ON c.id = o.customer_id
WHERE c.id IS NULL