-- ISNULL() OR COALESCE()
/* TASK 1: 
   Find the average scores of the customers.
   Uses COALESCE to replace NULL Score with 0.
*/

SELECT
    CustomerID,
    Score,
    COALESCE(Score, 0) AS Score2,
    AVG(Score) OVER() AS AvgScore,
    AVG(COALESCE(Score, 0)) OVER() AS AvgScore2
FROM Sales.Customers;