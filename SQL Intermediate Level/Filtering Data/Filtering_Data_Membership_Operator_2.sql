/* Retrieve all customers who are not from germany or france */

SELECT *
FROM customers
WHERE country NOT IN ('Germany','France')