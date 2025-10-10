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

/* TASK 10:
   Find the Lowest Sales across all orders and by Product
*/

SELECT 
    OrderID,
    ProductID,
    OrderDate,
    Sales,
    MIN(Sales) OVER () AS LowestSales,
    MIN(Sales) OVER (PARTITION BY ProductID) AS LowestSalesByProduct
FROM Sales.Orders

/* TASK 11:
   Show the employees who have the highest salaries
*/

