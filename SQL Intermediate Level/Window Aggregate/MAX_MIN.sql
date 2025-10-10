/* ============================================================
   SQL WINDOW AGGREGATION | MAX / MIN
   ============================================================ */

/* TASK 9:
   Find the Highest and Lowest Sales across all orders
*/

SELECT
    OrderID,
    OrderDate,
    Sales,
    ProductID,
    MAX(Sales) OVER () AS Highest_Sales,
    MIN(Sales) OVER () AS Lowest_Sales
FROM Sales.Orders