/* ==============================================================================
   SUBQUERY | RESULT TYPES
===============================================================================*/

-- Scalar Query
SELECT
    AVG(Sales)
FROM Sales.Orders;

-- Row Query
SELECT
    CustomerID
FROM Sales.Orders;

-- Table Query
SELECT
    OrderID,
    OrderDate
FROM Sales.Orders;