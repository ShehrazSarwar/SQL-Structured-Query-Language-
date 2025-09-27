-- Change the score of the customer with ID 6 to 0

UPDATE customers
SET score = 0
WHERE id = 6
-- Without WHERE all rows will be updated

SELECT *
FROM customers