--   SQL WINDOW FUNCTIONS | PARTITION CLAUSE

/* TASK 4: 
   Find the total sales across all orders and for each product,
   additionally providing details such as OrderID and OrderDate 
*/

SELECT
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	SUM(Sales) OVER (PARTITION BY ProductID) AS Sales_By_Product,
	SUM(Sales) OVER () AS Total_Sales
FROM Sales.Orders