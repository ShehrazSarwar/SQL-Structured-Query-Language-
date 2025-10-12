/* ==============================================================================
   CORRELATED SUBQUERY
===============================================================================*/

/* TASK 10:
   Show all customer details and the total orders for each customer using a correlated subquery.
*/

SELECT
	*,
	(SELECT COUNT(*) 
	 FROM Sales.Orders AS O
	 WHERE O.CustomerID = C.CustomerID) AS TotalOrders
FROM Sales.Customers AS C