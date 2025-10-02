/* 
	DATETRUNC() DATA AGGREGATION

TASK 3:
   Aggregate orders by year using DATETRUNC on CreationTime.
*/

SELECT
	DATETRUNC(year, CreationTime) AS OrderYear,
	COUNT(*) AS TotalOrders
FROM Sales.Orders
GROUP BY DATETRUNC(year, CreationTime)