-- SQL WINDOW FUNCTIONS | ORDER CLAUSE

/* TASK 6: 
   Rank each order by Sales from highest to lowest */

SELECT
	OrderID,
	ProductID,
	Sales,
	RANK() OVER(ORDER BY Sales DESC) AS Sales_Rank
FROM Sales.Orders