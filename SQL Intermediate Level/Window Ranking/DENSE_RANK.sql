-- ROW_NUMBER() VS RANK() VS DENSE_RANK()
-- Rank the orders based on their sales from highest to lowest

SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) AS SalesRank_Row,
	RANK() OVER(ORDER BY Sales DESC) AS SalesRank_Rank,
	DENSE_RANK() OVER(ORDER BY Sales DESC) AS SalesRank_Dense
 FROM Sales.Orders