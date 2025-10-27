-- SQL Common Table Expressions (CTEs)

-- NON-RECURSIVE CTE --

-- Step1: Find the total Sales Per Customer (Standalone CTE)
WITH CTE_Total_Sales AS (
SELECT 
	CustomerID, 
	SUM(Sales) AS Total_Sales
FROM Sales.Orders
GROUP BY CustomerID 
)
-- Step2: Find the last order date for each customer (Standalone CTE)
, CTE_Last_Order AS (
SELECT 
	CustomerID,
	MAX(OrderDate) AS Last_Order
FROM Sales.Orders
GROUP BY CustomerID 
)
-- Step3: Rank Customers based on Total Sales Per Customer (Nested CTE)
, CTE_Rank AS (
SELECT 
	CustomerID,
	Total_Sales,
	RANK() OVER(ORDER BY Total_Sales DESC) AS Customer_Rank
FROM CTE_Total_Sales
)
-- Step4: segment customers based on their total sales (Nested CTE)
, CTE_Segment AS (
SELECT 
	CustomerID,
	Total_Sales,
	CASE
		WHEN Total_Sales > 100 THEN 'High'
		WHEN Total_Sales > 80 THEN 'Medium'
		ELSE 'Low'
	END AS CustomerSegments
FROM CTE_Total_Sales
)

SELECT 
	C.CustomerID,
	C.FirstName,
	C.LastName,
	CTE_Total_Sales.Total_Sales,
	CTE_Last_Order.Last_Order,
	CTE_Rank.Customer_Rank,
	CTE_Segment.CustomerSegments
FROM Sales.Customers AS C
LEFT JOIN CTE_Total_Sales
ON C.CustomerID = CTE_Total_Sales.CustomerID
LEFT JOIN CTE_Last_Order
ON C.CustomerID = CTE_Last_Order.CustomerID
LEFT JOIN CTE_Rank
ON C.CustomerID = CTE_Rank.CustomerID
LEFT JOIN CTE_Segment
ON C.CustomerID = CTE_Segment.CustomerID