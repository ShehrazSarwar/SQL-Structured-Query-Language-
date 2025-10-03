-- DATEDIFF(part, start_date, end_date)-> Use to calculate the difference between dates
-- TASK: Calculate the age of Employees.

SELECT * FROM Sales.Employees

SELECT
	EmployeeID,
	FirstName,
	Department,
	DATEDIFF(year, BirthDate, GETDATE()) AS Age,
	Gender
FROM Sales.Employees