/* ====================================================================================================
PROJECT: Nexus Sales Intelligence - Advanced Business Analytics & Reporting
PURPOSE: This script generates key performance indicators (KPIs) and analytical insights 
         to support decision-making for Sales, Invoicing, and Executive management.
====================================================================================================
*/

-- 1. PRODUCT PERFORMANCE: Rank products by the total volume sold
-- Identifies high-demand items using DENSE_RANK to handle ties without skipping ranks.
SELECT
	customer_name,
	product_name,
	quantity,
	DENSE_RANK() OVER(ORDER BY quantity DESC) AS most_selling_rank
FROM sales.view_invoice_report;


-- 2. CUSTOMER VALUE: Rank individual transactions based on total sales amount
-- Used by the Sales Dept to identify high-value orders and key contributors to revenue.
SELECT
	customer_name,
	product_name,
	quantity,
	DENSE_RANK() OVER(ORDER BY sales_amount DESC) AS cust_rank
FROM sales.view_invoice_report;


-- 3. DEPARTMENTAL ACTIVITY: Rank categories by the total number of orders processed
-- Helps the Invoicing Dept understand transaction volume across different product lines.
SELECT 
	category,
	DENSE_RANK() OVER(ORDER BY no_of_orders DESC) AS category_rank
FROM
(SELECT 
	p.category,
	COUNT(*) AS no_of_orders
FROM sales.dim_products p
INNER JOIN sales.fact_sales s ON p.product_key = s.product_key
-- Filters for active products to ensure reporting accuracy for current inventory
WHERE p.is_active = 1
GROUP BY p.category
) t;


-- 4. REVENUE TRENDS: Calculate a cumulative running total of sales
-- Essential for visualizing revenue growth over time and tracking daily business progress.
SELECT
	customer_name,
	product_name,
	quantity,
	sales_amount,
	SUM(sales_amount) OVER(ORDER BY order_date) AS running_total
FROM sales.view_invoice_report;


-- 5. FINANCIAL OVERVIEW: Grand Total of all sales revenue
-- Provides a single Key Performance Indicator (KPI) for the company's total gross income.
SELECT
	SUM(sales_amount) AS total_sales
FROM sales.fact_sales;


-- 6. EXECUTIVE SUMMARY: Category Revenue Analysis & Market Share %
-- Ranks categories by revenue and calculates their percentage contribution to total sales.
SELECT 
    Category,
    Total_Revenue,
    -- Rank categories based on their revenue performance
    DENSE_RANK() OVER (ORDER BY Total_Revenue DESC) AS Revenue_Rank,
    -- Calculate the percentage of total sales this category represents for market share analysis
    CAST((Total_Revenue * 100.0 / SUM(Total_Revenue) OVER()) AS DECIMAL(10,2)) AS Sales_Contribution_Pct
FROM (
    SELECT 
        p.category AS Category,
        SUM(s.sales_amount) AS Total_Revenue
    FROM sales.fact_sales s
    INNER JOIN sales.dim_products p ON s.product_key = p.product_key
    -- Ensures deleted/inactive records do not skew current performance metrics
    WHERE p.is_active = 1
    GROUP BY p.category
) AS CategorySummaries
ORDER BY Revenue_Rank;