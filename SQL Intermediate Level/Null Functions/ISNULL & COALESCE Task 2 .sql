/* TASK 3: 
   Sort the customers from lowest to highest scores,
   with NULL values appearing last.
*/

SELECT
    CustomerID,
    Score
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END, Score