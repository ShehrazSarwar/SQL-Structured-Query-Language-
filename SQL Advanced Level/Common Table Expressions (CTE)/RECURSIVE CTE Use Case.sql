-- SQL Common Table Expressions (CTEs)

-- RECURSIVE CTE --

-- Show the employee hierarchy by displaying each employee's level within the organization.

WITH CTE_hierarchy AS (
	SELECT 
		EmployeeID,
		FirstName,
		ManagerID,
		1 AS Level 
	FROM Sales.Employees
	WHERE ManagerID IS NULL

	UNION ALL

	SELECT 
		E.EmployeeID,
		E.FirstName,
		E.ManagerID,
		Level + 1
	FROM Sales.Employees AS E
	INNER JOIN CTE_hierarchy AS Ch
	ON E.ManagerID = Ch.EmployeeID
)
SELECT * FROM CTE_hierarchy