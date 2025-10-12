/* ==============================================================================
   SUBQUERY | COMPARISON OPERATORS
===============================================================================*/

/* TASK 6:
   Find the products that have a price higher than the average price of all products.
*/

SELECT
	ProductID,
	Price,
	(SELECT AVG(Price) FROM Sales.Products) AS AvgPrice
FROM Sales.Products
WHERE Price > (SELECT AVG(Price) FROM Sales.Products)