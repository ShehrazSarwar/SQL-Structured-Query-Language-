-- NTILE()
-- Divide Orders into Groups Based on Sales

SELECT 
    OrderID,
    Sales,
    NTILE(1) OVER (ORDER BY Sales) AS OneBucket,
    NTILE(2) OVER (ORDER BY Sales) AS TwoBuckets,
    NTILE(3) OVER (ORDER BY Sales) AS ThreeBuckets,
    NTILE(4) OVER (ORDER BY Sales) AS FourBuckets
FROM Sales.Orders;