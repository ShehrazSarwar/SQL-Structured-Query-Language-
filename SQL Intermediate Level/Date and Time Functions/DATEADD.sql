-- DATEADD(part, interval, date)

SELECT
	OrderID,
	OrderDate,
	DATEADD(day, -10, OrderDate) AS TenDaysBefore,
	DATEADD(month, 3, OrderDate) AS ThreeMonthsLater,
	DATEADD(year, 2, OrderDate) AS TwoYearSLater
FROM Sales.Orders