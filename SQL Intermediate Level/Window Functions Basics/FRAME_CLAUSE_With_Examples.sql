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


/* TASK 8: 
   Calculate Total Sales by Order Status for current and previous two orders 
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
		ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
		) AS Total_Sales
FROM Sales.Orders

/* TASK 9: 
   Calculate Total Sales by Order Status from previous two orders only 
*/

-- Short-Cut For Only --> PRECEDING
-- ROWS 2 PRECEDING = ROWS BETWEEN 2 PRECEDING AND CURRENT ROW

SELECT
	OrderID,
	OrderDate,
	ProductID,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(
		PARTITION BY OrderStatus
		ORDER BY OrderDate 
		ROWS 2 PRECEDING
		) AS Total_Sales
FROM Sales.Orders

/* TASK 10: 
   Calculate cumulative Total Sales by Order Status up to the current order 
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
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	) AS Total_Sales
FROM Sales.Orders

/* TASK 11: 
   Calculate cumulative Total Sales by Order Status from the start to the current row 
*/

SELECT
    OrderID,
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    SUM(Sales) OVER (
        PARTITION BY OrderStatus 
        ORDER BY OrderDate 
        ROWS UNBOUNDED PRECEDING
    ) AS Total_Sales
FROM Sales.Orders;