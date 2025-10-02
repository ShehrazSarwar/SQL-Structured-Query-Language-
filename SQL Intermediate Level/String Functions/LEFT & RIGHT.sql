-- LEFT(Col or Val, length) & RIGHT() - Substring Extraction

-- Retrieve the first two characters of each first name
SELECT 
	first_name,
	LEFT(TRIM(first_name),2) AS first_2_char
FROM customers

-- Retrieve the last two characters of each first name
SELECT
	first_name,
	RIGHT(first_name,2) AS last_2_char
FROM customers