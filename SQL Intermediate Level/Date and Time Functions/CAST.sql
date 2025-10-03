-- CAST(Value AS data_type) 
-- Convert data types using CAST.

SELECT
	CAST('123' AS INT) AS [String To Int],
	CAST(123 AS VARCHAR) AS [Int To String],
	CAST('2025-10-03' AS DATE) AS [String To Date],
	CAST('2025-10-03' AS DATETIME2) AS [String To Datetime],
	CAST(GETDATE() AS VARCHAR) AS [Datetime To String],
	CreationTime,
	CAST(CreationTime AS DATE) AS [Datetime To Date]
FROM Sales.Orders