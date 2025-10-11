-- NTILE()
-- Divide Orders into Groups Based on Sales

SELECT 
    OrderID,
    Sales,
	ProductID,
    NTILE(1) OVER (ORDER BY Sales) AS OneBucket,
    NTILE(2) OVER (ORDER BY Sales) AS TwoBuckets,
    NTILE(3) OVER (ORDER BY Sales) AS ThreeBuckets,
    NTILE(4) OVER (ORDER BY Sales) AS FourBuckets,
	NTILE(2) OVER (PARTITION BY ProductID ORDER BY Sales) AS TwoBucketByProducts
FROM Sales.Orders;


-- USE CASES:
-- Data Segmentation
-- 1. Segment all Orders into 3 Categories: High, Medium, and Low Sales.

SELECT
    OrderID,
    Sales,
    Buckets,
    CASE 
        WHEN Buckets = 1 THEN 'High'
        WHEN Buckets = 2 THEN 'Medium'
        WHEN Buckets = 3 THEN 'Low'
    END AS SalesSegmentations
FROM (
    SELECT
        OrderID,
        Sales,
        NTILE(3) OVER (ORDER BY Sales DESC) AS Buckets
    FROM Sales.Orders
) AS SalesBuckets;


-- Load Balancing
-- 2. Divide Orders into Groups for Processing
SELECT 
	NTILE(5) OVER(ORDER BY OrderID) AS Buckets,
    *
FROM Sales.Orders;