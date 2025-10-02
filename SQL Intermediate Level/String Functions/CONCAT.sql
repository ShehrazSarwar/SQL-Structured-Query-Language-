-- CONCAT(Col or val, Col or Val)

USE SalesDB
SELECT
CONCAT(FirstName,' ',LastName) AS FullName
FROM sales.Customers

USE MyDatabase
SELECT
CONCAT(first_name,'-',country) AS full_info
FROM customers