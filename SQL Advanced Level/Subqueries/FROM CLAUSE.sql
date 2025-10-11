/* ==============================================================================
   SUBQUERY | FROM CLAUSE
===============================================================================*/

/* TASK 1:
   Find the products that have a price higher than the average price of all products.
*/

SELECT *
FROM (
	SELECT
		ProductID,
		Product,
		Price,
		AVG(Price) OVER() AS AvgPrice
	FROM Sales.Products
) t
WHERE Price > AvgPrice


/* TASK 2:
   Rank Customers based on their total amount of sales.
*/

SELECT 
	*,
	RANK() OVER(ORDER BY TotalSales DESC) AS CustomerRank
FROM (
	SELECT
		CustomerID,
		SUM(Sales) AS TotalSales
	FROM Sales.Orders
	GROUP BY CustomerID
) t