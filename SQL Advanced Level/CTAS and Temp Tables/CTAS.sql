-- Creating Logic For Replacing CTAS
IF OBJECT_ID('Sales.MonthlyOrders','U') IS NOT NULL
	DROP TABLE Sales.MonthlyOrders
GO
-- Creating View
SELECT
	DATETRUNC(MONTH,OrderDate) AS OrderMonth,
	SUM(Sales) AS Sales,
	COUNT(*) AS NoOfOrders
INTO Sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATETRUNC(MONTH,OrderDate)

