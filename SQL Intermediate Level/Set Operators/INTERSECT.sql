-- INTERSECT
-- Find Employees, who are also customers.

SELECT 
FirstName,
LastName
FROM sales.Customers

INTERSECT

SELECT 
FirstName,
LastName
FROM sales.Employees