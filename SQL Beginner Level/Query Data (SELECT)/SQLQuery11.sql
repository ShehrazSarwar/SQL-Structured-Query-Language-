SELECT 
	country,
	SUM(score) as total_score
FROM customers
WHERE score > 400
GROUP BY country
HAVING SUM(score) > 750