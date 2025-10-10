/* ============================================================
   SQL WINDOW AGGREGATION | COUNT
   ============================================================ */

/* TASK 1:
   Find the Total Number of Orders and the Total Number of Orders for Each Customer
*/

SELECT
	OrderID,
    OrderDate,
    CustomerID,
	COUNT(*) OVER() AS Total_Orders,
	COUNT(*) OVER(PARTITION BY CustomerID) AS Total_Customer_Orders
FROM Sales.Orders

/* TASK 2:
   - Find the Total Number of Customers
   - Find the Total Number of Scores for Customers
   - Find the Total Number of Countries
*/

SELECT
    *,
    COUNT(*) OVER () AS TotalCustomersStar,
    COUNT(1) OVER () AS TotalCustomersOne,
    COUNT(Score) OVER() AS TotalScores,
    COUNT(Country) OVER() AS TotalCountries
FROM Sales.Customers

/* TASK 3:
   Check whether the table 'OrdersArchive' contains any duplicate rows
*/

SELECT *
FROM
(SELECT
	OrderID,
	COUNT(OrderID) OVER(PARTITION BY OrderID) AS Total_Rows
FROM Sales.OrdersArchive) t
WHERE Total_Rows > 1