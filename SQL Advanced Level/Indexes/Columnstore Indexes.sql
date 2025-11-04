/* ==============================================================================
   Columnstore Indexes
============================================================================== */

-- Create a Clustered Columnstore Index on Sales.DBCustomers
CREATE CLUSTERED COLUMNSTORE INDEX idx_DBCustomers_CS
ON Sales.DBCustomers;

-- Create a Non-Clustered Columnstore Index on the FirstName column
CREATE NONCLUSTERED COLUMNSTORE INDEX idx_DBCustomers_CS_FirstName
ON Sales.DBCustomers (FirstName);

-- Switch context to AdventureWorksDW2022 for FactInternetSales examples */
USE AdventureWorksDW2022;

-- Create a Heap Table from FactInternetSales
SELECT *
INTO FactInternetSales_HP
FROM FactInternetSales;

SELECT *
FROM FactInternetSales_HP

-- Create a RowStore Table from FactInternetSales
SELECT *
INTO FactInternetSales_RS
FROM FactInternetSales;

-- Create a Clustered Index (RowStore) on FactInternetSales_RS
CREATE CLUSTERED INDEX idx_FactInternetSales_RS_PK
ON FactInternetSales_RS (SalesOrderNumber, SalesOrderLineNumber);

-- Create a Columnstore Table from FactInternetSales
SELECT *
INTO FactInternetSales_CS
FROM FactInternetSales;

-- Create a Clustered Columnstore Index on FactInternetSales_CS
CREATE CLUSTERED COLUMNSTORE INDEX idx_FactInternetSales_CS_PK
ON FactInternetSales_CS;
