/* ============================================================
   SQL WINDOW VALUE | LEAD, LAG
   ============================================================ */

/* TASK 1:
   Analyze the Month-over-Month Performance by Finding the Percentage Change in Sales
   Between the Current and Previous Months
*/

SELECT
	*,
	Current_Month_Sales - Prev_Month_Sales AS MoM_Change,
	ROUND(CONVERT(float, (Current_Month_Sales - Prev_Month_Sales)) / Prev_Month_Sales * 100, 1) AS Percent_MoM_Change
FROM ( 
	SELECT
		MONTH(OrderDate) AS Order_Month,
		SUM(Sales) AS Current_Month_Sales,
		LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) AS Prev_Month_Sales
	FROM Sales.Orders
	GROUP BY MONTH(OrderDate) 
) t


/* TASK 2:
   Customer Loyalty Analysis - Rank Customers Based on the Average Days Between Their Orders
*/

SELECT
	CustomerID,
	AVG(DaysUntilNextOrder) AS AverageOrderDays,
	RANK() OVER(ORDER BY COALESCE(AVG(DaysUntilNextOrder), 9999)) AS CustomerRank
FROM (
	SELECT 
		OrderID,
		CustomerID,
		Sales,
		OrderDate AS CurrentOrderDate,
		LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS NextOrderDate,
		DATEDIFF(day, OrderDate, LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) AS DaysUntilNextOrder
	FROM Sales.Orders
) t
GROUP BY CustomerID