-- UNION ALL (FASTER THAN UNION)
/* Combine the data from employees and customers into one Table, including duplicates*/

SELECT 
FirstName,
LastName
FROM sales.Customers

UNION ALL -- All Rows including duplicates

SELECT 
FirstName,
LastName
FROM sales.Employees