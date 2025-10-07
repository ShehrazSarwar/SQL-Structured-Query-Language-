-- GROUPED AGGREGATIONS - GROUP BY
-- Find the number of orders, total sales, average sales, highest sales, and lowest sales per customer

SELECT
    CustomerID,
    COUNT(*) AS total_orders,
    SUM(Sales) AS total_sales,
    AVG(Sales) AS avg_sales,
    MAX(Sales) AS highest_sales,
    MIN(Sales) AS lowest_sales
FROM Sales.Orders
GROUP BY CustomerID