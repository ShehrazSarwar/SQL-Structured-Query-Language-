-- DATEDIFF(part, start_date, end_date)-> Use to calculate the difference between dates
-- TASK: Find the average shipping duration in days for each month.

SELECT
	DATENAME(MONTH,OrderDate) AS Order_Month,
	CAST(AVG(DATEDIFF(day, OrderDate, ShipDate)) AS VARCHAR) + ' days' AS Avg_Shipping_Duration
FROM Sales.Orders
GROUP BY DATENAME(MONTH,OrderDate)
ORDER BY MIN(MONTH(OrderDate))