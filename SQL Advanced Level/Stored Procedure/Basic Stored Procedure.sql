/* ==============================================================================
   Basic Stored Procedure
============================================================================== */

-- Define the Stored Procedure
CREATE PROCEDURE GetCustomerSummary AS
BEGIN
	SELECT
        COUNT(*) AS TotalCustomers,
        AVG(Score) AS AvgScore
    FROM Sales.Customers
    WHERE Country = 'USA'
END

--Execute Stored Procedure
EXEC GetCustomerSummary

-- DROP Procedure
DROP PROCEDURE GetCustomerSummary