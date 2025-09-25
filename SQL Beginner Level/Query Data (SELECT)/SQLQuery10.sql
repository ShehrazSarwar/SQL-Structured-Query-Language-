-- Find the total score and total no of customers for each country

SELECT 
	country,
	SUM(score) AS total_score,
	COUNT(id) AS no_of_customers
FROM customers
GROUP BY country