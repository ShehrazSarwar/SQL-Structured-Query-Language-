/* ================================================================================
	Project Name: Nexus Sales Intelligence System
	Description:  A Star Schema Data Mart designed for Sales Analytics, 
				  Invoicing, and Operational Record Keeping.
	Requirements: CCP - Authorization, Reporting, CRUD Operations, and Scalability.
  ================================================================================= */

-- Create the Database
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Nexus_Sales_Intelligence')
BEGIN
    CREATE DATABASE Nexus_Sales_Intelligence;
END
GO

USE Nexus_Sales_Intelligence;
GO

-- BEST PRACTICE: Using a Schema
-- This helps with Security/Authorization by grouping related tables.
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'sales')
BEGIN
    EXEC('CREATE SCHEMA sales');
END
GO

-- =============================================
-- 1. DIMENSION TABLES
-- =============================================

-- Create Customers Dimension
IF OBJECT_ID('sales.dim_customers', 'U') IS NOT NULL DROP TABLE sales.dim_customers;
GO
CREATE TABLE sales.dim_customers (
    customer_key   INT PRIMARY KEY IDENTITY(1,1),
    customer_id    INT NOT NULL,
    customer_number NVARCHAR(50),
    first_name     NVARCHAR(100),
    last_name      NVARCHAR(100),
    country        NVARCHAR(100),
    marital_status NVARCHAR(20), 
    gender         NVARCHAR(10),
    birthdate      DATE,
    create_date    DATETIME DEFAULT GETDATE(),
    is_active      BIT DEFAULT 1 -- BEST PRACTICE: Soft Delete flag
);

-- Create Products Dimension
IF OBJECT_ID('sales.dim_products', 'U') IS NOT NULL DROP TABLE sales.dim_products;
GO
CREATE TABLE sales.dim_products (
    product_key    INT PRIMARY KEY IDENTITY(1,1),
    product_id     INT NOT NULL,
    product_number NVARCHAR(50),
    product_name   NVARCHAR(200),
    category_id    INT,
    category       NVARCHAR(100),
    subcategory    NVARCHAR(100),
    maintenance    NVARCHAR(3), 
    cost           DECIMAL(18, 2),
    product_line   NVARCHAR(50),
    start_date     DATE,
    is_active      BIT DEFAULT 1 -- BEST PRACTICE: Soft Delete flag
);

-- =============================================
-- 2. FACT TABLES
-- =============================================

-- Create Sales Fact Table
IF OBJECT_ID('sales.fact_sales', 'U') IS NOT NULL DROP TABLE sales.fact_sales;
GO
CREATE TABLE sales.fact_sales (
    order_number   NVARCHAR(50),
    product_key    INT,
    customer_key   INT,
    order_date     DATE DEFAULT GETDATE(),
    shipping_date  DATE,
    due_date       DATE,
    quantity       INT NOT NULL CHECK (quantity > 0), -- BEST PRACTICE: Validation constraint
    price          DECIMAL(18, 2) NOT NULL,
    sales_amount   AS (quantity * price),
    
    -- Constraints
    CONSTRAINT FK_Product FOREIGN KEY (product_key) REFERENCES sales.dim_products(product_key),
    CONSTRAINT FK_Customer FOREIGN KEY (customer_key) REFERENCES sales.dim_customers(customer_key)
);