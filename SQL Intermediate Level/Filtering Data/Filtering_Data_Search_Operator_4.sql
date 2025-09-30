-- find all the customers whose name has an 'r' in the 3rd position

SELECT * 
FROM customers
WHERE first_name LIKE '__r%'