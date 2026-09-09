-- Show quantity and unit price for each transaction
SELECT
    transactions.quantity,
    products.unit_price
FROM transactions
JOIN products
    ON transactions.product_id = products.product_id;

-- Calculate sales for each transaction
SELECT
    transactions.quantity * products.unit_price AS sales
FROM transactions
JOIN products
    ON transactions.product_id = products.product_id;

-- Calculate total sales before discounts
SELECT
    SUM(transactions.quantity * products.unit_price) AS total_sales
FROM transactions
JOIN products
    ON transactions.product_id = products.product_id;

-- Total sales by category
SELECT
    products.category,
    SUM(transactions.quantity * products.unit_price) AS total_revenue
FROM transactions
JOIN products
    ON transactions.product_id = products.product_id
GROUP BY products.category
ORDER BY total_revenue DESC;

-- Top 10 products by sales
SELECT
    products.product_name,
    SUM(transactions.quantity * products.unit_price) AS total_revenue
FROM transactions
JOIN products
    ON transactions.product_id = products.product_id
GROUP BY products.product_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Show the discount levels in the dataset
SELECT DISTINCT discount
FROM transactions;
