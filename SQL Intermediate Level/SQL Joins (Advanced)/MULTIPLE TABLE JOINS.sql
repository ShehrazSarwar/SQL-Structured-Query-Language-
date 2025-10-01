-- MULTIPLE TABLE JOINS (4 Tables)

/* Task: Using SalesDB, Retrieve a list of all orders, along with the related customer, product, 
   and employee details. For each order, display:
   - Order ID
   - Customer's name
   - Product name
   - Sales amount
   - Product price
   - Salesperson's name */

USE SalesDB

SELECT 
	A.OrderID,
	B.FirstName AS CustomerFirstName,
	B.LastName AS CustomerLastName, 
	C.Product AS ProductName,
	A.Sales AS SalesAmount,
	C.Price AS ProductPrice,
	D.FirstName AS  EmployeeFirstName,
	D.LastName AS  EmployeeLastName
FROM sales.Orders AS A
LEFT JOIN sales.Customers AS B
ON A.CustomerID = B.CustomerID
LEFT JOIN Sales.Products AS C
ON A.ProductID = C.ProductID
LEFT JOIN sales.Employees AS D
ON A.SalesPersonID = D.EmployeeID