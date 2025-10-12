/* ==============================================================================
   SUBQUERY | COMPARISON OPERATORS
===============================================================================*/

/* TASK 6:
   Find the products that have a price higher than the average price of all products.
*/

SELECT
	ProductID,
	Price,
	(SELECT AVG(Price) FROM Sales.Products) AS AvgPrice
FROM Sales.Products
WHERE Price > (SELECT AVG(Price) FROM Sales.Products)


/* ==============================================================================
   SUBQUERY | IN OPERATOR
===============================================================================*/

/* TASK 7:
   Show the details of orders made by customers in Germany.
*/


SELECT
    *
FROM Sales.Orders
WHERE CustomerID IN (
    SELECT
        CustomerID
    FROM Sales.Customers
    WHERE Country = 'Germany'
);

/* TASK 8:
   Show the details of orders made by customers not in Germany.
*/

SELECT
    *
FROM Sales.Orders
WHERE CustomerID NOT IN (
    SELECT
        CustomerID
    FROM Sales.Customers
    WHERE Country = 'Germany'
);


/* ==============================================================================
   SUBQUERY | ANY OR ALL OPERATOR
===============================================================================*/

/* TASK 9:
   Find female employees whose salaries are greater than the salaries of any male employees.
*/

SELECT
    EmployeeID, 
    FirstName,
    Salary
FROM Sales.Employees
WHERE Gender = 'F' AND Salary > ANY(SELECT Salary FROM Sales.Employees WHERE Gender = 'M')


/* ==============================================================================
   SUBQUERY | EXISTS OPERATOR
===============================================================================*/

/* TASK 11:
   Show the details of orders made by customers in Germany.
*/

