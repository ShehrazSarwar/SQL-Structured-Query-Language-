/* ============================================================
   SQL WINDOW AGGREGATION | AVG
   ============================================================ */

/* TASK 6:
   - Find the Average Sales Across All Orders 
   - Find the Average Sales for Each Product
*/

SELECT
    OrderID,
    OrderDate,
    Sales,
    ProductID,
    AVG(Sales) OVER () AS AvgSales,
    AVG(Sales) OVER (PARTITION BY ProductID) AS AvgSalesByProduct
FROM Sales.Orders

/* TASK 7:
   Find the Average Scores of Customers
*/

SELECT
    CustomerID,
	FirstName,
    LastName,
    Score,
    COALESCE(Score, 0) AS CustomerScore,
    AVG(Score) OVER () AS AvgScore,
    AVG(COALESCE(Score, 0)) OVER () AS AvgScoreWithoutNull
FROM Sales.Customers

/* TASK 8:
   Find all orders where Sales exceed the average Sales across all orders
*/

SELECT *
FROM ( 
	SELECT
		OrderID,
		ProductID,
		Sales,
		AVG(Sales) OVER () AS AvgSales
	FROM Sales.Orders 
) t
WHERE Sales > AvgSales