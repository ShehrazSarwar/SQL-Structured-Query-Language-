-- USE CASE: CONDITIONAL AGGREGATION

/* TASK 5: 
   Count how many orders each customer made with sales greater than 30 
*/

SELECT
    CustomerID,
    SUM(
        CASE
            WHEN Sales > 30 THEN 1
            ELSE 0
        END
    ) AS TotalOrdersHighSales,
    COUNT(*) AS TotalOrders
FROM Sales.Orders
GROUP BY CustomerID