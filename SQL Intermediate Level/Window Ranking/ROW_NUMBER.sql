-- ROW_NUMBER()
-- Rank the orders based on their sales from highest to lowest

SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) AS SalesRank_Row
FROM Sales.Orders

-- USE CASE HackerRank Question:
-- Query the median of Sales From Orders

SELECT 
	AVG(CONVERT(float,Sales)) AS Median
FROM ( SELECT
			Sales,
			ROW_NUMBER() OVER(ORDER BY Sales) AS RN,
			COUNT(*) OVER() AS N
		FROM Sales.Orders
) AS X
WHERE RN IN (FLOOR((N + 1)/2.0),CEILING((N + 1)/2.0))