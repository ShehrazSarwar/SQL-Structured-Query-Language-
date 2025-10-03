-- DATEDIFF(part, start_date, end_date)-> Use to calculate the difference between dates

SELECT
	OrderID,
	OrderDate,
	ShipDate,
	DATEDIFF(day,OrderDate, ShipDate) AS DaysTaken,
	OrderStatus
FROM Sales.Orders