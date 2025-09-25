-- Retrieve customers from Germany

SELECT 
	first_name,
	country,
	score
FROM customers
WHERE country = 'Germany'