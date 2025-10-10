/* TASK 5: 
   Find the total sales across all orders, for each product,
   and for each combination of product and order status,
   additionally providing details such as OrderID and OrderDate 
*/

SELECT
	OrderID,
	OrderDate,
	ProductID,
	OrderStatus,
	Sales,
	SUM(Sales) OVER () AS Total_Sales,
	SUM(Sales) OVER(PARTITION BY ProductID) AS Sales_By_Product,
	SUM(Sales) OVER(PARTITION BY ProductID, OrderStatus) AS Sales_By_Product_Status
FROM Sales.Orders