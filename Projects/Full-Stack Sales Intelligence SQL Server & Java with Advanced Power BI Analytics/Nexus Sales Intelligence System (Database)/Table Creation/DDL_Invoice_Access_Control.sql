-- =================================================================================
-- 3. SECURITY & ACCESS CONTROL
-- =================================================================================
/* DESCRIPTION:
   This table satisfies the 'Security' and 'Authorization' requirements of the CCP.
   It stores user credentials and roles to ensure that only authorized personnel 
   can perform sensitive operations like 'Remove Records' or 'Edit Products'.
*/

IF OBJECT_ID('sales.dim_users', 'U') IS NOT NULL DROP TABLE sales.dim_users;
GO

CREATE TABLE sales.dim_users (
    user_id       INT PRIMARY KEY IDENTITY(1,1),
    username      NVARCHAR(50) UNIQUE NOT NULL,
    password_hash NVARCHAR(255),          -- Stores encrypted passwords for security
    user_role     NVARCHAR(20) NOT NULL,  -- Defines access levels: e.g., 'Admin', 'Staff'
    is_authorized BIT DEFAULT 1          -- Kill-switch to revoke access immediately
);
GO

-- =================================================================================
-- 4. DEPARTMENTAL REPORTING (INVOICE DEPARTMENT)
-- =================================================================================
/* DESCRIPTION:
   This view satisfies the 'Invoice Department' and 'Generate Reports' requirements.
   
   DESIGN LOGIC:
   1. Simplification: Combines Sales, Customer, and Product data into one flat view.
   2. Data Integrity: Uses 'is_active' filter to ensure deleted products aren't billed.
   3. Calculation: Utilizes the 'sales_amount' computed column for accurate invoicing.
*/

IF OBJECT_ID('sales.view_invoice_report', 'V') IS NOT NULL DROP VIEW sales.view_invoice_report;
GO

CREATE VIEW sales.view_invoice_report AS
SELECT 
    s.order_number,
    s.order_date,
    c.first_name + ' ' + c.last_name AS customer_name,
    p.product_name,
    s.quantity,
    s.price,
    s.sales_amount 
FROM sales.fact_sales s
INNER JOIN sales.dim_customers c ON s.customer_key = c.customer_key
INNER JOIN sales.dim_products p ON s.product_key = p.product_key
WHERE p.is_active = 1; -- Ensures only current, non-deleted products are reported
GO