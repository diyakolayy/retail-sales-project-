-- ============================================
-- 1. VIEW DATA (BASIC)
-- ============================================

-- View all data (for initial understanding)
SELECT * 
FROM superstore;


-- ============================================
-- 2. SELECT SPECIFIC COLUMNS
-- ============================================

-- Select only required columns (faster & cleaner)
SELECT "Order Date", "Sales", "Profit"
FROM superstore;


-- ============================================
-- 3. FILTER LOSS-MAKING ORDERS
-- ============================================

-- Find all orders where profit is negative
SELECT *
FROM superstore
WHERE "Profit" < 0;

-- WHY:
-- Helps identify loss-making transactions quickly


-- ============================================
-- 4. SORT DATA (TOP / BOTTOM)
-- ============================================

-- Top profitable products
SELECT "Product Name", "Profit"
FROM superstore
ORDER BY "Profit" DESC;

-- WHY:
-- Helps rank best-performing products


-- ============================================
-- 5. LIMIT RESULTS (TOP N)
-- ============================================

-- Top 5 most profitable products
SELECT "Product Name", "Profit"
FROM superstore
ORDER BY "Profit" DESC
LIMIT 5;

-- WHY:
-- Used in dashboards for quick insights


-- ============================================
-- 6. GROUP BY (CORE ANALYSIS)
-- ============================================

-- Total sales by category
SELECT "Category", SUM("Sales") AS total_sales
FROM superstore
GROUP BY "Category";

-- WHY:
-- Aggregates raw data into meaningful insights


-- ============================================
-- 7. MONTH-WISE SALES (TIME ANALYSIS)
-- ============================================

-- Extract month-year and calculate sales
SELECT 
    TO_CHAR("Order Date", 'YYYY-MM') AS month,
    SUM("Sales") AS monthly_sales
FROM superstore
GROUP BY month
ORDER BY month;

-- WHY:
-- Helps identify trends and seasonality


-- ============================================
-- 8. LOSS-MAKING PRODUCTS (HAVING)
-- ============================================

-- Products with negative total profit
SELECT "Product Name", SUM("Profit") AS total_profit
FROM superstore
GROUP BY "Product Name"
HAVING SUM("Profit") < 0
ORDER BY total_profit;

-- WHY:
-- Detects products hurting business profitability


-- ============================================
-- 9. SEGMENT-WISE PROFIT
-- ============================================

-- Profit contribution by customer segment
SELECT "Segment", SUM("Profit") AS total_profit
FROM superstore
GROUP BY "Segment"
ORDER BY total_profit DESC;

-- WHY:
-- Identifies most valuable customer group


-- ============================================
-- 10. DISCOUNT IMPACT ANALYSIS
-- ============================================

-- Average discount vs profit by category
SELECT 
    "Category",
    AVG("Discount") AS avg_discount,
    AVG("Profit") AS avg_profit
FROM superstore
GROUP BY "Category";

-- WHY:
-- Shows how discounts affect profitability


-- ============================================
-- 11. PROFIT MARGIN (ADVANCED KPI)
-- ============================================

-- Calculate profit margin per category
SELECT 
    "Category",
    SUM("Profit") / SUM("Sales") AS profit_margin
FROM superstore
GROUP BY "Category";

-- WHY:
-- Measures efficiency, not just revenue


-- ============================================
-- 12. TOP 5 PRODUCTS USING SUBQUERY
-- ============================================

SELECT *
FROM (
    SELECT "Product Name", SUM("Profit") AS total_profit
    FROM superstore
    GROUP BY "Product Name"
) AS sub
ORDER BY total_profit DESC
LIMIT 5;

-- WHY:
-- Structured ranking using subqueries


-- ============================================
-- 13. REPEAT CUSTOMERS ANALYSIS
-- ============================================

-- Customers with more than 1 order
SELECT "Customer ID", COUNT(DISTINCT "Order ID") AS order_count
FROM superstore
GROUP BY "Customer ID"
HAVING COUNT(DISTINCT "Order ID") > 1;

-- WHY:
-- Identifies loyal customers


-- ============================================
-- 14. REGION-WISE PROFIT
-- ============================================

-- Total profit by region
SELECT "Region", SUM("Profit") AS total_profit
FROM superstore
GROUP BY "Region"
ORDER BY total_profit;

-- WHY:
-- Detects weak and strong regions


-- ============================================
-- 15. HIGH SALES BUT LOW PROFIT (CRITICAL)
-- ============================================

SELECT 
    "Product Name",
    SUM("Sales") AS total_sales,
    SUM("Profit") AS total_profit
FROM superstore
GROUP BY "Product Name"
HAVING SUM("Sales") > 10000 AND SUM("Profit") < 0;

-- WHY:
-- Finds hidden business issues:
-- High revenue but loss-making products


-- 
-- 16. SHIPPING TIME ANALYSIS
-- 

-- Calculate average shipping days
SELECT 
    "Ship Mode",
    AVG("Ship Date" - "Order Date") AS avg_shipping_days
FROM superstore
GROUP BY "Ship Mode";




--
-- 17. STATE-WISE LOSS ANALYSIS
--

SELECT "State", SUM("Profit") AS total_profit
FROM superstore
GROUP BY "State"
ORDER BY total_profit;

-- WHY:
-- Identifies loss-making locations


--
-- 18. CATEGORY + DISCOUNT DEEP ANALYSIS
-- 

SELECT 
    "Category",
    CASE 
        WHEN "Discount" = 0 THEN 'No Discount'
        WHEN "Discount" <= 0.2 THEN 'Low'
        WHEN "Discount" <= 0.5 THEN 'Medium'
        ELSE 'High'
    END AS discount_range,
    AVG("Profit") AS avg_profit
FROM superstore
GROUP BY "Category", discount_range
ORDER BY "Category";

