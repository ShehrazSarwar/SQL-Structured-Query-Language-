-- Temp Tables
/* ==============================================================================
   Step 1: Create Temporary Table (#Orders)
============================================================================== */
SELECT 
	*
INTO #Orders
FROM Sales.Orders;


/* ==============================================================================
   Step 2: Clean Data in Temporary Table
============================================================================== */
DELETE FROM #Orders
WHERE OrderStatus = 'Delivered';


/* ==============================================================================
   Step 3: Load Cleaned Data into Permanent Table (Sales.OrdersTest)
============================================================================== */
SELECT 
	*
INTO Sales.OrdersTest
FROM #Orders

SELECT * FROM Sales.OrdersTest