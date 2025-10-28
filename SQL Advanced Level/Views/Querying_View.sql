-- Find the running total of sales for each month using View.
SELECT
	OrderMonth,
	TotalSales,
	TotalOrders,
	TotalQuantity,
	SUM(TotalSales) OVER(ORDER BY OrderMonth) AS RunningTotal
FROM Sales.V_Monthly_Summary