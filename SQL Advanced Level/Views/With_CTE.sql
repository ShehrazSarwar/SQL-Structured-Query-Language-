-- Find the running total of sales for each month.

WITH CTE_Monthly_Summary AS (
	SELECT
		DATETRUNC(MONTH, OrderDate) AS OrderMonth,
		SUM(Sales) AS TotalSales
	FROM Sales.Orders
	GROUP BY DATETRUNC(MONTH, OrderDate)
)
SELECT
	OrderMonth,
	TotalSales,
	SUM(TotalSales) OVER(ORDER BY OrderMonth) AS RunningTotal
FROM CTE_Monthly_Summary
