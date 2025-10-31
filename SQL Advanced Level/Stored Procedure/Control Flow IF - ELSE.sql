/* ==============================================================================
   Control Flow IF - ELSE in Stored Procedure
============================================================================== */

-- Edit the Stored Procedure
ALTER PROCEDURE GetCustomerSummary @country NVARCHAR(50) = 'USA' AS
BEGIN

	DECLARE @TotalCustomers INT, @AvgScore INT

	-- Prepare & Cleanup Data
	IF EXISTS(SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @country)
	BEGIN
		PRINT 'Updating NULLS Scores to 0';
		UPDATE Sales.Customers
		SET Score = 0
		WHERE Score IS NULL AND Country = @country;
	END
	ELSE
	BEGIN
		PRINT 'No NULLS Found In Score';
	END;

	-- Generating Reports
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
EXEC GetCustomerSummary;
EXEC GetCustomerSummary @Country = 'Germany';
