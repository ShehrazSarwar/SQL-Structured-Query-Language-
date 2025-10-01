-- EXCEPT (MINUS)
-- Find employees who are not customers at the same time.

SELECT 
FirstName,
LastName
FROM sales.Employees

EXCEPT

SELECT 
FirstName,
LastName
FROM sales.Customers