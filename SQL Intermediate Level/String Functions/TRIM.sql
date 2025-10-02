-- TRIM() - Remove White Spaces

-- Find customers whose first name contains leading or trailing spaces
SELECT
first_name,
LEN(first_name) AS len_name,
LEN(TRIM(first_name)) AS len_trim_name,
LEN(first_name) - LEN(TRIM(first_name)) AS flags
FROM customers
--WHERE LEN(first_name) != LEN(TRIM(first_name))
WHERE first_name != TRIM(first_name)