/* ==============================================================================
   Unique Indexes
============================================================================== */

-- Attempt to create a Unique Index on the Category column in Sales.Products.
-- Note: This may fail if duplicate values exist.

CREATE UNIQUE INDEX idx_Products_Category
ON Sales.Products (Category);
  
-- Create a Unique Index on the Product column in Sales.Products
CREATE UNIQUE INDEX idx_Products_Product
ON Sales.Products (Product);
  
-- Test Insert: Attempt to insert a duplicate value (should fail if the constraint is enforced)
INSERT INTO Sales.Products (ProductID, Product)
VALUES (106, 'Caps');