-- LOWER() & UPPER() - Case Transformation

-- Convert the first name to lowercase
SELECT 
LOWER(first_name) AS lowCase_name
FROM customers

-- Convert the first name to uppercase
SELECT
UPPER(first_name) AS upCase_name
FROM customers