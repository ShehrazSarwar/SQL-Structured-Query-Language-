/* 
   EOMONTH()

TASK 4:
   Display OrderID, CreationTime, and the end-of-month date for CreationTime.
*/

SELECT
	OrderID,
	CreationTime,
	EOMONTH(CreationTime) AS EndOfMonth,
	CAST(DATETRUNC(month, CreationTime) AS DATE) AS StartOfMonth
FROM Sales.Orders