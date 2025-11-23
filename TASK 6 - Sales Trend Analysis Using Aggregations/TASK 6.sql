Create database sales_data;
use sales_data;
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    product_id INT NOT NULL
);

-- 2. Insert sample data for testing
INSERT INTO orders (order_id, order_date, amount, product_id) VALUES
(1, '2024-01-15', 150.00, 101),
(2, '2024-01-20', 200.50, 102),
(3, '2024-01-25', 175.75, 103),
(4, '2024-02-05', 300.00, 101),
(5, '2024-02-10', 250.25, 104),
(6, '2024-02-15', 180.00, 102),
(7, '2024-02-20', 220.50, 105),
(8, '2024-03-01', 190.00, 103),
(9, '2024-03-10', 275.75, 101),
(10, '2024-03-15', 310.00, 104),
(11, '2024-03-20', 195.50, 102),
(12, '2024-03-25', 240.25, 105),
(13, '2024-04-05', 280.00, 103),
(14, '2024-04-12', 315.50, 101),
(15, '2024-04-18', 265.75, 104);

-- ============================================
-- MAIN ANALYSIS QUERIES
-- ============================================

-- Query 1: Monthly Revenue and Order Volume Analysis
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(DISTINCT order_id) AS order_volume,
    SUM(amount) AS total_revenue,
    ROUND(AVG(amount), 2) AS avg_order_value,
    MIN(amount) AS min_order_value,
    MAX(amount) AS max_order_value
FROM orders
GROUP BY 
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY year DESC, month DESC;

-- Query 2: Monthly Revenue Trend with Month Names
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    monthname(order_date) AS month_name,
    COUNT(DISTINCT order_id) AS order_volume,
    SUM(amount) AS total_revenue,
    ROUND(AVG(amount), 2) AS avg_order_value
FROM orders
GROUP BY 
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date),
    monthname(order_date)
ORDER BY year DESC, month DESC;

-- Query 3: Top 3 Months by Sales Revenue
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(DISTINCT order_id) AS order_volume,
    SUM(amount) AS total_revenue
FROM orders
GROUP BY 
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY total_revenue DESC
LIMIT 3;

-- Query 4: Year-over-Year Comparison
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(amount) AS total_revenue,
    ROUND(AVG(amount), 2) AS avg_order_value
FROM orders
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY year DESC;

-- Query 5: Quarterly Analysis
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(QUARTER FROM order_date) AS quarter,
    COUNT(DISTINCT order_id) AS order_volume,
    SUM(amount) AS total_revenue,
    ROUND(AVG(amount), 2) AS avg_order_value
FROM orders
GROUP BY 
    EXTRACT(YEAR FROM order_date),
    EXTRACT(QUARTER FROM order_date)
ORDER BY year DESC, quarter DESC;

-- Query 6: Specific Time Period Analysis (e.g., Q1 2024)
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(DISTINCT order_id) AS order_volume,
    SUM(amount) AS total_revenue
FROM orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY 
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY month;

-- Query 7: Product Performance by Month
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    product_id,
    COUNT(DISTINCT order_id) AS order_count,
    SUM(amount) AS product_revenue
FROM orders
GROUP BY 
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date),
    product_id
ORDER BY year DESC, month DESC, product_revenue DESC;

-- Query 8: Handle NULL values in aggregates
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS distinct_orders,
    COUNT(amount) AS non_null_amounts,
    COALESCE(SUM(amount), 0) AS total_revenue
FROM orders
GROUP BY 
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY year DESC, month DESC;