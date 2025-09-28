-- Retrieve all customers who are not from the Germany

SELECT *
FROM customers
WHERE country != 'Germany'