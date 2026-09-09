-- Top 10 customers by net sales
SELECT
    customers.first_name,
    customers.last_name,
    SUM(
        (transactions.quantity * products.unit_price)
        * (1 - transactions.discount)
    ) AS net_sales
FROM transactions
JOIN customers
    ON transactions.customer_id = customers.customer_id
JOIN products
    ON transactions.product_id = products.product_id
GROUP BY
    customers.customer_id,
    customers.first_name,
    customers.last_name
ORDER BY net_sales DESC
LIMIT 10;

-- Top 10 customers by number of transactions
SELECT
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    COUNT(*) AS transaction_count
FROM transactions
JOIN customers
    ON customers.customer_id = transactions.customer_id
GROUP BY
    customers.customer_id,
    customers.first_name,
    customers.last_name
ORDER BY transaction_count DESC
LIMIT 10;

-- Top 10 customers by average order value
SELECT
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    SUM(
        (transactions.quantity * products.unit_price)
        * (1 - transactions.discount)
    ) / COUNT(*) AS avg_order_value
FROM customers
JOIN transactions
    ON customers.customer_id = transactions.customer_id
JOIN products
    ON transactions.product_id = products.product_id
GROUP BY
    customers.customer_id,
    customers.first_name,
    customers.last_name
ORDER BY avg_order_value DESC
LIMIT 10;
