-- Comparing SQL Techniques: Subqueries, CTEs, and Window Functions

/* QUESTION: Find stores who's sales where better than the average sales accross all stores */

-- Using Having
SELECT
	store_id,
	store_name,
	SUM(price) AS TotalSale
FROM sales
GROUP BY store_id, store_name
HAVING SUM(price) > (
SELECT
	AVG(TotalSale)
FROM
(SELECT
	store_id,
	store_name,
	SUM(price) AS TotalSale
FROM sales
GROUP BY store_id, store_name) X )

-- Using JOIN
SELECT Sales.* 
FROM (
SELECT
	store_id,
	store_name,
	SUM(price) AS TotalSales
FROM sales
GROUP BY store_id, store_name
) AS Sales JOIN
(SELECT
	AVG(TotalSale) AS AVG_Sale
FROM
(SELECT
	store_id,
	store_name,
	SUM(price) AS TotalSale
FROM sales
GROUP BY store_id, store_name) X ) AvgSale
ON Sales.TotalSales > AvgSale.AVG_Sale

-- Using CTE
WITH CTE_Sales AS (
		SELECT
			store_id,
			store_name,
			SUM(price) AS TotalSale
		FROM sales
		GROUP BY store_id, store_name)
SELECT * FROM CTE_Sales
WHERE TotalSale > (SELECT AVG(TotalSale) FROM CTE_Sales);

-- Use Multiple CTE When More Info is Required
WITH CTE_Sales AS (
		SELECT
			store_id,
			store_name,
			SUM(price) AS TotalSale
		FROM sales
		GROUP BY store_id, store_name
), 
CTE_Avg AS (
	SELECT 
		AVG(TotalSale) AS AvgSale
	FROM CTE_Sales)

SELECT *,
	TotalSale - AvgSale AS DifferInAvg
FROM CTE_Sales JOIN CTE_Avg
ON CTE_Sales.TotalSale > CTE_Avg.AvgSale;


/* Window functions are great for analytics, like showing the average next to each row. 
But if I need to filter based on that average like only showing stores above it, 
I’ll usually wrap it in a CTE or subquery, since window functions can't be used directly in the WHERE clause.
*/

WITH StoreSales AS (
	SELECT store_id, store_name, SUM(price) AS TotalSale
	FROM sales
	GROUP BY store_id, store_name
)
SELECT *,
	   AVG(TotalSale) OVER () AS AvgSale,
	   TotalSale - AVG(TotalSale) OVER () AS DiffFromAvg
FROM StoreSales