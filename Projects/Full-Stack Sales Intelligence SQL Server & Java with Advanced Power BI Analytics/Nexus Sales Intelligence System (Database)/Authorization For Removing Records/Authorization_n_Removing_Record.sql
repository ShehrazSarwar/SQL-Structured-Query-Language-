-- =================================================================================
-- 5. SECURITY AND AUTHORIZED OPERATIONS
-- =================================================================================

/* REQUIREMENT CHECK: 
   - Authorization: Handled via Database Roles.
   - Removing Records: Handled via sp_DeleteProduct_Safe with Admin check.
   - Security: Prevents unauthorized deletions.
*/

-- ---------------------------------------------------------
-- Authorized Stored Procedure: Safe Delete
-- ---------------------------------------------------------
/* Logic: This procedure acts as a second layer of security.
   Even if a user has SQL-level permissions, they must pass 
   the 'Admin' check in the users table to soft-delete a product.
*/
CREATE OR ALTER PROCEDURE sales.sp_DeleteProduct_Safe
    @ProductID INT,
    @UserID INT
AS
BEGIN
    -- 1. Check if the user is authorized (Requirement: Security)
    IF EXISTS (
        SELECT 1 
        FROM sales.dim_users 
        WHERE user_id = @UserID 
          AND user_role = 'Admin' 
          AND is_authorized = 1
    )
    BEGIN
        -- 2. Soft Delete (Update is_active instead of actual DELETE)
        -- This preserves Referential Integrity for old Sales records.
        UPDATE sales.dim_products 
        SET is_active = 0 
        WHERE product_key = @ProductID; -- Using surrogate key
        
        PRINT 'Product marked as inactive. Foreign Key integrity maintained.';
    END
    ELSE
    BEGIN
        -- 3. Error handling for unauthorized access
        RAISERROR('Access Denied: You do not have "Admin" privileges to remove records.', 16, 1);
    END
END;
GO

-- ---------------------------------------------------------
-- Authorized Stored Procedure: Safe Customer Delete
-- ---------------------------------------------------------
/* Logic: 
   Fulfills the 'Security' and 'Record Keeping' requirements.
   Ensures that if a customer is removed, their past orders 
   remain visible in the fact_sales table for the Invoice Dept.
*/
CREATE OR ALTER PROCEDURE sales.sp_DeleteCustomer_Safe
    @CustomerKey INT,
    @UserID INT
AS
BEGIN

    -- 1. Authorization Check (Table-based security)
    IF EXISTS (
        SELECT 1 
        FROM sales.dim_users 
        WHERE user_id = @UserID 
          AND user_role = 'Admin' 
          AND is_authorized = 1
    )
    BEGIN
        -- 2. Soft Delete
        -- Updates the is_active flag to 0 instead of deleting the row.
        UPDATE sales.dim_customers 
        SET is_active = 0 
        WHERE customer_key = @CustomerKey;
        
        PRINT 'Customer marked as inactive. Historical records preserved.';
    END
    ELSE
    BEGIN
        -- 3. Security Error Handling
        RAISERROR('Access Denied: Only Admin users can deactivate customer accounts.', 16, 1);
    END
END;
GO