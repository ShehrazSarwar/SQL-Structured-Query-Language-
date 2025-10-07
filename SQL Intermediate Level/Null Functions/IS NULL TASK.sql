-- IS NULL
-- TASK: Find Customers who didn't place any orders

SELECT
	C.*,
	O.OrderID
FROM Sales.Customers AS C
LEFT JOIN Sales.Orders AS O
ON C.CustomerID = O.CustomerID
WHERE O.CustomerID IS NULL