-- How many orders were placed each year, formatted by month and year (e.g., "Jan 25")?
SELECT 
	FORMAT(CreationTime, 'MMM yy') AS OrderDate,
	COUNT(*) AS OrderPlaced
FROM Sales.Orders
GROUP BY FORMAT(CreationTime, 'MMM yy')
ORDER BY MIN(MONTH(CreationTime))
