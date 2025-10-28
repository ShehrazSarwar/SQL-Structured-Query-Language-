--  USE CASE - DATA SECURITY
/* TASK:
   Create a view for the EU Sales Team that combines details from all tables,
   but excludes data related to the USA.
*/
CREATE VIEW Sales.V_Order_Details_EU AS 
(
	SELECT 
        o.OrderID,
        o.OrderDate,
        p.Product,
        p.Category,
        COALESCE(c.FirstName, '') + ' ' + COALESCE(c.LastName, '') AS CustomerName,
        c.Country AS CustomerCountry,
        COALESCE(e.FirstName, '') + ' ' + COALESCE(e.LastName, '') AS SalesName,
        e.Department,
        o.Sales,
        o.Quantity
    FROM Sales.Orders AS o
    LEFT JOIN Sales.Products AS p 
	ON p.ProductID = o.ProductID
    LEFT JOIN Sales.Customers AS c 
	ON c.CustomerID = o.CustomerID
    LEFT JOIN Sales.Employees AS e 
	ON e.EmployeeID = o.SalesPersonID
	WHERE c.Country != 'USA'
)