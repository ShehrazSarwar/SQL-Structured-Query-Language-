-- Insert New Data Into Customers Table

INSERT INTO customers (id,first_name)
VALUES 
	(10, 'Sahra') 
	-- All others will be set to NULL if there are not NOT NULL & DEFAULT etc Constraints

SELECT *
FROM customers