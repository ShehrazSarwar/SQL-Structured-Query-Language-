-- Data Analytics Use Case:
-- Combine order data from Orders and OrdersArchive into one report without duplicates.
-- Best Practice is to select all columns without * and Also Add source table info

SELECT
'Orders' AS SourceTable
,[OrderID]
,[ProductID]
,[CustomerID]
,[SalesPersonID]
,[OrderDate]
,[ShipDate]
,[OrderStatus]
,[ShipAddress]
,[BillAddress]
,[Quantity]
,[Sales]
,[CreationTime]
FROM sales.Orders

UNION

SELECT
'OrdersArchive' AS SourceTable
,[OrderID]
,[ProductID]
,[CustomerID]
,[SalesPersonID]
,[OrderDate]
,[ShipDate]
,[OrderStatus]
,[ShipAddress]
,[BillAddress]
,[Quantity]
,[Sales]
,[CreationTime]
FROM sales.OrdersArchive

ORDER BY OrderID ASC