-- CONCAT(Col or val, Col or Val) -> Combine Multiple Strings Into One

-- Concatenate first name and last name into one column FullName
USE SalesDB
SELECT
CONCAT(FirstName,' ',LastName) AS FullName
FROM sales.Customers


-- Concatenate first name and country into one column
USE MyDatabase
SELECT
CONCAT(first_name,'-',country) AS full_info
FROM customers