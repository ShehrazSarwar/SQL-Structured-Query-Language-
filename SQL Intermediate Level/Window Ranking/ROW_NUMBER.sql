-- ROW_NUMBER()
-- Rank the orders based on their sales from highest to lowest

SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) AS SalesRank_Row
FROM Sales.Orders

-- USE CASES:

-- HackerRank Question:
-- 1. Query the median of Sales From Orders

SELECT 
	AVG(CONVERT(float,Sales)) AS Median
FROM ( SELECT
			Sales,
			ROW_NUMBER() OVER(ORDER BY Sales) AS RN,
			COUNT(*) OVER() AS N
		FROM Sales.Orders
) AS X
WHERE RN IN (FLOOR((N + 1)/2.0),CEILING((N + 1)/2.0))


-- TOP N Analysis:
-- 2. Find the top highest sales for each product

SELECT *
FROM (
	SELECT
		OrderID,
		ProductID,
		Sales,
		ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) AS RankByProduct
	FROM Sales.Orders 
) t
WHERE RankByProduct = 1


-- BOTTOM N Analysis:
-- 3. Find the lowest 2 customers based on their total sales

SELECT *
FROM (
	SELECT
		CustomerID,
		SUM(Sales) AS TotalSales,
		ROW_NUMBER() OVER(ORDER BY SUM(Sales)) AS RankByTotalSales
	FROM Sales.Orders
	GROUP BY CustomerID
) t
WHERE RankByTotalSales <= 2


-- 4. Use Case | Assign Unique IDs to the Rows of the 'Order Archive'

SELECT
	ROW_NUMBER() OVER(ORDER BY OrderID) AS UniqueID,
	*
FROM Sales.OrdersArchive


-- Use Case | Identify Duplicates:
-- 5. Identify Duplicate Rows in 'Order Archive' and return a clean result without any duplicates

SELECT *
FROM (
	SELECT
		ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) AS RN,
		*
	FROM Sales.OrdersArchive
) AS UniqueOrdersArchive
WHERE RN = 1