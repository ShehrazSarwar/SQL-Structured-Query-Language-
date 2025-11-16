-- Find the date of the first and last order.
-- How many years of sales are available.
SELECT
	MIN(order_date) AS first_order_date,
	MAX(order_date) AS last_order_date,
	DATEDIFF(YEAR, MIN(order_date), MAX(order_date)) AS order_range_years
FROM gold.fact_sales

-- Find the youngest and oldest customer.
SELECT
	MAX(birthdate) AS youngest_customer_birthdate,
	MIN(birthdate) AS oldest_customer_birthdate,
	DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS youngest_customer_age,
	DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS oldest_customer_age
FROM gold.dim_customers