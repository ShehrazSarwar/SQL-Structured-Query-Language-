-- ROW_NUMBER() VS RANK()
-- Rank the orders based on their sales from highest to lowest

SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) AS SalesRank_Row,
	RANK() OVER(ORDER BY Sales DESC) AS SalesRank_Rank
 FROM Sales.Orders