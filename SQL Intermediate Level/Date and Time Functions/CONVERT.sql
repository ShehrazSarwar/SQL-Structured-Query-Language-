-- CONVERT(data_type, Col or Val, [,style])
--  Demonstrate conversion using CONVERT.

SELECT
    CONVERT(INT,'123') AS [String to Int CONVERT],
	CONVERT(DATE,'2025-10-03') AS [String to Date CONVERT],
	CreationTime,
	CONVERT(DATE, CreationTime) AS [Datetime to Date CONVERT],
	CONVERT(VARCHAR, CreationTime, 32) AS [USA Std. Style:32],
	CONVERT(VARCHAR, CreationTime, 34) AS [EURO Std. Style:34]
FROM Sales.Orders;
