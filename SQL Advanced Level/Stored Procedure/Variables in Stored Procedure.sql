/* ==============================================================================
   Variables in Stored Procedure
============================================================================== */

-- Edit the Stored Procedure
ALTER PROCEDURE GetCustomerSummary @country NVARCHAR(50) = 'USA' AS
BEGIN

	DECLARE @TotalCustomers INT, @AvgScore INT

	SELECT
        @TotalCustomers = COUNT(*),
        @AvgScore = AVG(Score)
    FROM Sales.Customers
    WHERE Country = @country

	PRINT 'Total Customers From ' + @country + ' : ' + CAST(@TotalCustomers AS NVARCHAR);
	PRINT 'Avg Score From ' + @country + ' : ' + CAST(@AvgScore AS NVARCHAR);

	SELECT
		COUNT(*) AS TotalOrders,
		SUM(Sales) AS TotalSales
	FROM Sales.Customers AS c
	JOIN Sales.Orders AS o
	ON c.CustomerID = o.CustomerID
	WHERE c.Country = @country;
END

--Execute Stored Procedure
EXEC GetCustomerSummary @Country = 'Germany';
EXEC GetCustomerSummary @Country = 'USA';
EXEC GetCustomerSummary;