-- GROUP BY With Window Function

/* TASK 12: 
   Rank customers by their total sales 
*/

SELECT
    CustomerID,
    SUM(Sales) AS Total_Sales,
	RANK() OVER(ORDER BY SUM(Sales) DESC) AS Customer_Rank
FROM Sales.Orders
GROUP BY CustomerID;
