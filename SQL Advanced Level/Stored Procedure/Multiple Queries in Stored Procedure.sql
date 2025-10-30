/* ==============================================================================
   Multiple Queries in Stored Procedure
============================================================================== */

-- Update the Stored Procedure
ALTER PROCEDURE GetCustomerSummary @country NVARCHAR(50) = 'USA' AS
BEGIN
	SELECT
        COUNT(*) AS TotalCustomers,
        AVG(Score) AS AvgScore
    FROM Sales.Customers
    WHERE Country = @country

	SELECT
		COUNT(*) AS TotalOrders,
		SUM(Sales) AS TotalSales
	FROM Sales.Customers AS c
	JOIN Sales.Orders AS o
	ON c.CustomerID = o.CustomerID
	WHERE c.Country = @country
END

--Execute Stored Procedure
EXEC GetCustomerSummary @country = 'Germany'
EXEC GetCustomerSummary