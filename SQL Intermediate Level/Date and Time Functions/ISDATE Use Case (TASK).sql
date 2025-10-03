-- ISDATE: Data Cleaning Use Case
-- TASK: Validate OrderDate using ISDATE and convert valid dates.

SELECT
	-- CAST(OrderDate AS DATE) AS OrderDate,
	OrderDate,
	ISDATE(OrderDate) AS Is_Date,
	CASE WHEN ISDATE(OrderDate) = 1 THEN CAST(OrderDate AS DATE)
		 ELSE '9999-01-01' -- Dummy Value
	END AS NewOrderDate
FROM
(
	SELECT '2025-08-20' AS OrderDate UNION
	SELECT '2025-08-21' UNION
	SELECT '2025-08-23' UNION
	SELECT '2025-08'
) AS t
--WHERE ISDATE(OrderDate) = 0