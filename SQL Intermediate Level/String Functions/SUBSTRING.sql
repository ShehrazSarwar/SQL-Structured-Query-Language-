-- SUBSTRING(Col or Val, Start, Length) - Extracting Substrings

-- Retrieve a list of customers' first names after removing the first character
SELECT
	first_name,
	SUBSTRING(TRIM(first_name),2,LEN(first_name)) AS sub_name
FROM customers