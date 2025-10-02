-- CHARINDEX('search_string',Col or Val) -> return index position

-- Find First a Index Position
SELECT
	FirstName,
	CHARINDEX('a',FirstName) AS a_position
FROM sales.Customers

-- Practical Example Extract First Name From Full Name
SELECT
	CONCAT(FirstName,' ',LastName) AS FullName,
	CHARINDEX(' ', CONCAT(FirstName,' ',LastName)) AS space_position,
	CHARINDEX(' ', CONCAT(FirstName,' ',LastName)) -1 AS first_name_len,
	LEFT(CONCAT(FirstName,' ',LastName), CHARINDEX(' ', CONCAT(FirstName,' ',LastName)) -1) AS First_name
FROM sales.Customers
