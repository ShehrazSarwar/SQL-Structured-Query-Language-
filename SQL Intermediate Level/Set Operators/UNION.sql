-- UNION
/* Combine the data from employees and customers into one Table */

SELECT 
FirstName,
LastName
FROM sales.Customers

UNION -- All Rows except duplicates

SELECT 
FirstName,
LastName
FROM sales.Employees