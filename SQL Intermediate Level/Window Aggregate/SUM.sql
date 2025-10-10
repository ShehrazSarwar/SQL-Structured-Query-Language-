/* ============================================================
   SQL WINDOW AGGREGATION | SUM
   ============================================================ */

/* TASK 4:
   - Find the Total Sales Across All Orders 
   - Find the Total Sales for Each Product
*/

SELECT
    OrderID,
    OrderDate,
    Sales,
    ProductID,
    SUM(Sales) OVER () AS TotalSales,
    SUM(Sales) OVER (PARTITION BY ProductID) AS SalesByProduct
FROM Sales.Orders

/* TASK 5:
   Find the Percentage Contribution of Each Product's Sales to the Total Sales
*/

SELECT
    OrderID,
    OrderDate,
    Sales,
    ProductID,
    SUM(Sales) OVER () AS TotalSales,
	ROUND(CONVERT(float, Sales) / SUM(Sales) OVER () * 100, 2) AS Contribution
FROM Sales.Orders

-- Below Code Is For Contribution By Product Sales Not By Single Order
SELECT
    OrderID,
    OrderDate,
    Sales,
    ProductID,
    SUM(Sales) OVER () AS TotalSales,
	SUM(Sales) OVER (PARTITION BY ProductID) AS SalesByProduct,
	ROUND(CONVERT(float, SUM(Sales) OVER (PARTITION BY ProductID)) / SUM(Sales) OVER () * 100, 2) AS Contribution
FROM Sales.Orders