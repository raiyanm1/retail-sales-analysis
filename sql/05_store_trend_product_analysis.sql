-- Net sales by store
SELECT
    transactions.store_id,
    stores.store_name,
    SUM(
        (transactions.quantity * products.unit_price)
        * (1 - transactions.discount)
    ) AS net_sales
FROM transactions
JOIN stores
    ON transactions.store_id = stores.store_id
JOIN products
    ON transactions.product_id = products.product_id
GROUP BY
    transactions.store_id,
    stores.store_name
ORDER BY net_sales DESC;

-- Gross profit by store
SELECT
    transactions.store_id,
    stores.store_name,
    SUM(
        (transactions.quantity * products.unit_price)
        * (1 - transactions.discount)
        - (transactions.quantity * products.cost_price)
    ) AS gross_profit
FROM transactions
JOIN stores
    ON transactions.store_id = stores.store_id
JOIN products
    ON transactions.product_id = products.product_id
GROUP BY
    transactions.store_id,
    stores.store_name
ORDER BY gross_profit DESC;

-- Check the date range of the transactions
SELECT
    MIN(transaction_date) AS first_transaction,
    MAX(transaction_date) AS last_transaction
FROM transactions;

-- Net sales by month
SELECT
    DATE_TRUNC('month', transactions.transaction_date) AS month,
    SUM(
        (transactions.quantity * products.unit_price)
        * (1 - transactions.discount)
    ) AS net_sales
FROM transactions
JOIN products
    ON transactions.product_id = products.product_id
GROUP BY DATE_TRUNC('month', transactions.transaction_date)
ORDER BY month;

-- Gross profit by month
SELECT
    DATE_TRUNC('month', transactions.transaction_date) AS month,
    SUM(
        (transactions.quantity * products.unit_price)
        * (1 - transactions.discount)
        - (transactions.quantity * products.cost_price)
    ) AS gross_profit
FROM transactions
JOIN products
    ON transactions.product_id = products.product_id
GROUP BY DATE_TRUNC('month', transactions.transaction_date)
ORDER BY month;

-- Number of transactions by month
SELECT
    DATE_TRUNC('month', transaction_date) AS month,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY DATE_TRUNC('month', transaction_date)
ORDER BY month;

-- Top 10 products by units sold
SELECT
    products.product_name,
    products.category,
    SUM(transactions.quantity) AS units_sold
FROM transactions
JOIN products
    ON transactions.product_id = products.product_id
GROUP BY
    products.product_id,
    products.product_name,
    products.category
ORDER BY units_sold DESC
LIMIT 10;

-- Top 10 products by gross profit
SELECT
    products.product_name,
    products.category,
    SUM(
        (transactions.quantity * products.unit_price)
        * (1 - transactions.discount)
        - (transactions.quantity * products.cost_price)
    ) AS gross_profit
FROM transactions
JOIN products
    ON transactions.product_id = products.product_id
GROUP BY
    products.product_id,
    products.product_name,
    products.category
ORDER BY gross_profit DESC
LIMIT 10;

-- Top 10 products by gross margin percentage
SELECT
    products.product_name,
    products.category,
    (
        SUM(
            (transactions.quantity * products.unit_price)
            * (1 - transactions.discount)
        )
        - SUM(transactions.quantity * products.cost_price)
    )
    /
    SUM(
        (transactions.quantity * products.unit_price)
        * (1 - transactions.discount)
    )
    * 100 AS gross_margin_percentage
FROM transactions
JOIN products
    ON transactions.product_id = products.product_id
GROUP BY
    products.product_id,
    products.product_name,
    products.category
ORDER BY gross_margin_percentage DESC
LIMIT 10;

-- Compare the different discount levels
SELECT
    transactions.discount,
    COUNT(*) AS transaction_count,
    SUM(transactions.quantity) AS units_sold,
    SUM(
        (transactions.quantity * products.unit_price)
        * (1 - transactions.discount)
    ) AS net_sales
FROM transactions
JOIN products
    ON transactions.product_id = products.product_id
GROUP BY transactions.discount
ORDER BY transactions.discount;
