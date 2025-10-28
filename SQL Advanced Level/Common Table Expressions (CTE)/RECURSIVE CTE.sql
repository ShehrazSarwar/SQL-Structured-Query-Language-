-- SQL Common Table Expressions (CTEs)

-- RECURSIVE CTE --

-- Generate a Sequence of Numbers from 1 to 20

WITH CTE_Numbers AS (
	SELECT 1 AS N
	UNION ALL
	SELECT N + 1
	FROM CTE_Numbers
	WHERE N < 20
)
SELECT * FROM CTE_Numbers
OPTION(MAXRECURSION 20)
-- Default is 100, But with OPTION(MAXRECURSION 1000) We can control this limit