/* TASK 2: 
   Calculate the Total Sales for Each Product 
*/

SELECT
	ProductID,
	SUM(Sales) AS Total_Sales
FROM Sales.Orders
GROUP BY ProductID