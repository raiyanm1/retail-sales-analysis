-- Count the total customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- Count the total products
SELECT COUNT(*) AS total_products
FROM products;

-- Count the total stores
SELECT COUNT(*) AS total_stores
FROM stores;

-- Count the total transactions
SELECT COUNT(*) AS total_transactions
FROM transactions;

-- Show the different product categories
SELECT DISTINCT category
FROM products;

-- Count products in each category
SELECT
    category,
    COUNT(*) AS product_count
FROM products
GROUP BY category;

-- Find the total units sold
SELECT SUM(quantity) AS total_units_sold
FROM transactions;

-- Look at transactions with product information
SELECT *
FROM transactions
JOIN products
    ON transactions.product_id = products.product_id
LIMIT 10;

-- Show transaction and product details
SELECT
    transactions.transaction_id,
    transactions.quantity,
    products.product_id,
    products.unit_price
FROM transactions
JOIN products
    ON transactions.product_id = products.product_id
LIMIT 10;

-- Match customers with their transaction dates
SELECT
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    transactions.transaction_date
FROM customers
JOIN transactions
    ON transactions.customer_id = customers.customer_id
LIMIT 10;
