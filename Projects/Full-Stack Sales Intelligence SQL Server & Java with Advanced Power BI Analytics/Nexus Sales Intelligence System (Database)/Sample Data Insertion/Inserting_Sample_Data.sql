/*******************************************************************************
Project: Nexus Sales Intelligence - Final Data Population Script
Description: Clears existing data and inserts 10 realistic records per table.
*******************************************************************************/

USE Nexus_Sales_Intelligence;
GO

-- =================================================================================
-- 0. CLEANSE EXISTING DATA (Order is important due to Foreign Keys)
-- =================================================================================
PRINT 'Cleaning existing data...';
DELETE FROM sales.fact_sales;    -- Delete child table first
DELETE FROM sales.dim_customers;
DELETE FROM sales.dim_products;
DELETE FROM sales.dim_users;

-- Reset Identity Counters
DBCC CHECKIDENT ('sales.dim_customers', RESEED, 0);
DBCC CHECKIDENT ('sales.dim_products', RESEED, 0);
DBCC CHECKIDENT ('sales.dim_users', RESEED, 0);
GO

-- =================================================================================
-- 1. INSERT: USERS (Authorization & Security)
-- =================================================================================
PRINT 'Inserting 10 Users...';
INSERT INTO sales.dim_users (username, password_hash, user_role, is_authorized)
VALUES 
('admin_sarah', 'sh@256_x1', 'Admin', 1),
('sales_mike',  'sh@256_x2', 'Sales_Staff', 1),
('sales_jane',  'sh@256_x3', 'Sales_Staff', 1),
('inv_robert',  'sh@256_x4', 'Invoice_Staff', 1),
('admin_khan',  'sh@256_x5', 'Admin', 1),
('sales_ali',   'sh@256_x6', 'Sales_Staff', 1),
('inv_sana',    'sh@256_x7', 'Invoice_Staff', 1),
('sales_leo',   'sh@256_x8', 'Sales_Staff', 1),
('sales_maya',  'sh@256_x9', 'Sales_Staff', 0), 
('manager_eric','sh@256_x0', 'Admin', 1);

-- =================================================================================
-- 2. INSERT: CUSTOMERS
-- =================================================================================
PRINT 'Inserting 10 Customers...';
INSERT INTO sales.dim_customers (customer_id, customer_number, first_name, last_name, country, marital_status, gender, birthdate)
VALUES 
(101, 'C-001', 'John', 'Doe', 'USA', 'Married', 'M', '1985-05-15'),
(102, 'C-002', 'Alice', 'Smith', 'Canada', 'Single', 'F', '1992-08-22'),
(103, 'C-003', 'Mohammad', 'Ali', 'Pakistan', 'Married', 'M', '1978-12-01'),
(104, 'C-004', 'Elena', 'Rossi', 'Italy', 'Single', 'F', '1995-03-10'),
(105, 'C-005', 'Li', 'Wei', 'China', 'Married', 'M', '1988-11-30'),
(106, 'C-006', 'Sarah', 'Connor', 'USA', 'Single', 'F', '1980-07-04'),
(107, 'C-007', 'David', 'Beckham', 'UK', 'Married', 'M', '1975-05-02'),
(108, 'C-008', 'Fatima', 'Zahra', 'UAE', 'Married', 'F', '1990-01-20'),
(109, 'C-009', 'Hans', 'Muller', 'Germany', 'Single', 'M', '1983-09-14'),
(110, 'C-010', 'Sofia', 'Garcia', 'Spain', 'Married', 'F', '1994-06-25');

-- =================================================================================
-- 3. INSERT: PRODUCTS (All Requirements Included)
-- =================================================================================
PRINT 'Inserting 10 Products...';
INSERT INTO sales.dim_products 
(product_id, product_number, product_name, category_id, category, subcategory, maintenance, cost, product_line, start_date, is_active)
VALUES 
(501, 'P-LAP', 'Pro Laptop 15', 10, 'Electronics', 'Laptops', 'YES', 1200.00, 'Computers', '2024-01-15', 1),
(502, 'P-MOU', 'Wireless Mouse', 11, 'Accessories', 'Peripherals', 'NO', 25.00, 'Computers', '2024-02-10', 1),
(503, 'P-KEY', 'Mechanical Keyboard', 11, 'Accessories', 'Peripherals', 'NO', 85.00, 'Computers', '2024-03-05', 1),
(504, 'P-MON', '4K Monitor 27in', 10, 'Electronics', 'Monitors', 'YES', 350.00, 'Computers', '2024-05-20', 1),
(505, 'P-HEA', 'Noise Cancelling Headset', 12, 'Audio', 'Headphones', 'NO', 150.00, 'Peripherals', '2024-06-15', 1),
(506, 'P-TAB', 'Graphic Tablet', 10, 'Electronics', 'Design Tools', 'YES', 200.00, 'Design', '2024-08-01', 1),
(507, 'P-CAM', 'Webcam HD 1080p', 13, 'Video', 'Cameras', 'NO', 60.00, 'Peripherals', '2024-09-12', 1),
(508, 'P-MIC', 'USB Studio Mic', 12, 'Audio', 'Microphones', 'YES', 120.00, 'Peripherals', '2024-10-10', 1),
(509, 'P-CHL', 'Ergonomic Chair', 20, 'Furniture', 'Chairs', 'NO', 250.00, 'Office', '2024-11-20', 1),
(510, 'P-DSK', 'Standing Desk', 20, 'Furniture', 'Desks', 'YES', 450.00, 'Office', '2025-01-05', 1);

-- =================================================================================
-- 4. INSERT: SALES (Realistic Dates)
-- =================================================================================
PRINT 'Inserting 10 Sales Transactions...';
INSERT INTO sales.fact_sales (order_number, product_key, customer_key, order_date, shipping_date, due_date, quantity, price)
VALUES 
('ORD-2025-101', 1, 1, '2025-12-01', '2025-12-03', '2025-12-10', 1, 1499.99),
('ORD-2025-102', 2, 2, '2025-12-03', '2025-12-05', '2025-12-12', 2, 29.99),
('ORD-2025-103', 4, 3, '2025-12-05', '2025-12-08', '2025-12-14', 1, 399.00),
('ORD-2025-104', 5, 4, '2025-12-07', '2025-12-10', '2025-12-16', 1, 175.00),
('ORD-2025-105', 10, 5, '2025-12-10', '2025-12-13', '2025-12-19', 1, 499.00),
('ORD-2025-106', 3, 6, '2025-12-12', '2025-12-14', '2025-12-21', 3, 89.50),
('ORD-2025-107', 7, 7, '2025-12-14', '2025-12-16', '2025-12-23', 1, 75.00),
('ORD-2025-108', 9, 8, '2025-12-15', '2025-12-18', '2025-12-24', 1, 299.00),
('ORD-2025-109', 6, 9, '2025-12-18', '2025-12-20', '2025-12-27', 1, 250.00),
('ORD-2025-110', 8, 10, '2025-12-20', '2025-12-22', '2025-12-29', 2, 135.00);

PRINT 'SUCCESS: All data populated.';
GO