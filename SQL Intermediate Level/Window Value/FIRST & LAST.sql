/* ============================================================
   SQL WINDOW VALUE | FIRST & LAST VALUE
   ============================================================ */

/* TASK 3:
   Find the Lowest and Highest Sales for Each Product,
   and determine the difference between the current Sales and the lowest Sales for each Product.
*/

SELECT
	OrderID,
	ProductID,
	Sales,
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) AS LowestSale,
	LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS HighestSale,
	-- FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales DESC) AS HighestSale2,
	Sales - FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) AS Diff_Between_Lowest
FROM Sales.Orders