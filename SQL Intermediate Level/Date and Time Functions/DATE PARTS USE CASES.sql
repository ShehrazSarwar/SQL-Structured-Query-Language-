/* ==============================================================================
   DATE PARTS | USE CASES
===============================================================================*/

/* TASK 5:
   How many orders were placed each year?
*/

SELECT
	YEAR(OrderDate) AS Year,
	COUNT(*) AS OrdersPlaced -- COUNT(*) return no of rows of each group
FROM Sales.Orders
GROUP BY YEAR(OrderDate)

/* TASK 6:
   How many orders were placed each month?
*/

SELECT 
	MONTH(OrderDate) AS Month,
	COUNT(*) AS OrdersPlaced
FROM Sales.Orders
GROUP BY MONTH(OrderDate)

/* TASK 7:
   How many orders were placed each month (using friendly month names)?
*/

SELECT
	DATENAME(Month,(OrderDate)) AS Month,
	COUNT(*) AS OrdersPlaced
FROM Sales.Orders
GROUP BY DATENAME(Month,(OrderDate))
ORDER BY MIN(MONTH(OrderDate))

/* TASK 8:
   Show all orders that were placed during the month of February.
*/

SELECT * 
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2