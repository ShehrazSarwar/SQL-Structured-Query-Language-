/* Analyze the yearly performance of products by comparing their sales 
to both the average sales performance of the product and the previous year's sales */

WITH yearly_product_sales AS (
SELECT
	YEAR(order_date) AS order_year,
	product_name,
	SUM(sales_amount) AS total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), product_name 
)

SELECT
	order_year,
	product_name,
	total_sales,
	AVG(total_sales) OVER w AS avg_sales,
	total_sales - AVG(total_sales) OVER w AS avg_diff,
	LAG(total_sales) OVER w2 AS prev_year_sale,
	total_sales - LAG(total_sales) OVER w2 AS prev_sales_diff,
	CASE 
		WHEN total_sales - AVG(total_sales) OVER w > 0 THEN 'Above Average'
		WHEN total_sales - AVG(total_sales) OVER w < 0 THEN 'Below Average'
		ELSE 'Average'
	END AS ChangeWithAvg,
	CASE 
		WHEN LAG(total_sales) OVER w2 IS NULL THEN 'No Prev Year'
		WHEN total_sales - LAG(total_sales) OVER w2 > 0 THEN 'Increase'
		WHEN total_sales - LAG(total_sales) OVER w2 < 0 THEN 'Decrease'
		ELSE 'No Change'
	END AS ChangeWithPrevSale
FROM yearly_product_sales
WINDOW w AS (PARTITION BY product_name),
	   w2 AS (PARTITION BY product_name ORDER BY order_year)
ORDER BY product_name, order_year