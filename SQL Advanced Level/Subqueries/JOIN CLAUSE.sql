/* ==============================================================================
   SUBQUERY | JOIN CLAUSE
===============================================================================*/

/* TASK 4:
   Show customer details along with their total sales.
*/

SELECT
	C.*,
	S.TotalSales
FROM Sales.Customers AS C
LEFT JOIN ( SELECT
	CustomerID,
	SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID
) AS S
ON C.CustomerID = S.CustomerID;

/* TASK 5:
   Show all customer details and the total orders of each customer.
*/

SELECT
    c.*,
    o.TotalOrders
FROM Sales.Customers AS c
LEFT JOIN (
    SELECT
        CustomerID,
        COUNT(*) AS TotalOrders
    FROM Sales.Orders
    GROUP BY CustomerID
) AS o
ON c.CustomerID = o.CustomerID;