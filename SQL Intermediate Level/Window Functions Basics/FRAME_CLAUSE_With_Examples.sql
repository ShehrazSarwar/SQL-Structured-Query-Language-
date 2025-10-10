/* ==============================================================================
   SQL WINDOW FUNCTIONS | FRAME CLAUSE
===============================================================================*/

/* TASK 7: 
   Calculate Total Sales by Order Status for current and next two orders 
*/

SELECT
	OrderID,
	OrderDate,
	ProductID,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(
		PARTITION BY OrderStatus
		ORDER BY OrderDate 
		ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
		) AS Total_Sales
FROM Sales.Orders