-- Creating Logic For Replacing View
IF OBJECT_ID('Sales.V_Monthly_Summary','V') IS NOT NULL
	DROP VIEW Sales.V_Monthly_Summary
GO
-- Creating View
CREATE VIEW Sales.V_Monthly_Summary AS (
	SELECT
		DATETRUNC(MONTH, OrderDate) AS OrderMonth,
		SUM(Sales) AS TotalSales,
		COUNT(OrderID) AS TotalOrders,
		SUM(Quantity) AS TotalQuantity
	FROM Sales.Orders
	GROUP BY DATETRUNC(MONTH, OrderDate)
)