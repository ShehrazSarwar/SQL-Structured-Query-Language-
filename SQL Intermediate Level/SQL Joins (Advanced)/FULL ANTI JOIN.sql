-- FULL ANIT JOIN
/* Find customers without orders and orders without customers */

SELECT *
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL or o.customer_id IS NULL