/* ==============================================================================
   Parameters in Stored Procedure
============================================================================== */

-- Define the Stored Procedure
ALTER PROCEDURE GetCustomerSummary @country NVARCHAR(50) = 'USA' AS
BEGIN
	SELECT
        COUNT(*) AS TotalCustomers,
        AVG(Score) AS AvgScore
    FROM Sales.Customers
    WHERE Country = @country
END

--Execute Stored Procedure
EXEC GetCustomerSummary @country = 'USA'
EXEC GetCustomerSummary @country = 'Germany'
EXEC GetCustomerSummary