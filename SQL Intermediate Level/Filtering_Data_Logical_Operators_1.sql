/* Retrieve all customers who are from USA
and have a score greater than 500. */

SELECT *
FROM customers
WHERE country = 'USA' AND score > 500