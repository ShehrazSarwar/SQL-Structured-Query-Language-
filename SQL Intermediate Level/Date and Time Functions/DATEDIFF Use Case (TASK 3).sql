-- Time Gap Analysis
-- TASK: Find the number of days between each order and previous order.

SELECT
	OrderID,
	OrderDate AS CurrentOrderDate,
	LAG(OrderDate) OVER(ORDER BY OrderDate) AS PreviousOrderDate,
	DATEDIFF(
	day,
	LAG(OrderDate) OVER(ORDER BY OrderDate),
	OrderDate
	) AS NoOfDays
FROM Sales.Orders

/* -- Without Window Function, Using Subquery and Join to Find previous date
SELECT 
	o1.OrderID, 
	o1.OrderDate,
	o2.OrderDate AS PrevOrderDate
FROM Sales.Orders AS o1
LEFT JOIN Sales.Orders AS o2
   ON o2.OrderDate = (
       SELECT MAX(OrderDate) 
       FROM Sales.Orders
       WHERE OrderDate < o1.OrderDate
   );
*/