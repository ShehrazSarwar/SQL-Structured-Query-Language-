-- CUME_DIST & PERCENT_RANK
-- Find Products that Fall Within the Highest 40% of the Prices

SELECT 
    Product,
    Price,
    DistRank,
    CONCAT(DistRank * 100, '%') AS DistRankPerc
FROM (
    SELECT
        Product,
        Price,
        CUME_DIST() OVER(ORDER BY Price) AS DistRank
    FROM Sales.Products
) AS PriceDistribution
WHERE DistRank <= 0.4

-- PERCENT_RANK() --> Use Different Formula For Ranking (exclusive ranking)