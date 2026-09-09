-- Net sales after discounts
SELECT
    SUM(
        (transactions.quantity * products.unit_price)
        * (1 - transactions.discount)
    ) AS net_sales
FROM transactions
JOIN products
    ON transactions.product_id = products.product_id;

-- Total cost of goods sold
SELECT
    SUM(transactions.quantity * products.cost_price) AS cogs
FROM transactions
JOIN products
    ON transactions.product_id = products.product_id;

-- Total gross profit
SELECT
    SUM(
        (transactions.quantity * products.unit_price)
        * (1 - transactions.discount)
    )
    - SUM(transactions.quantity * products.cost_price) AS gross_profit
FROM transactions
JOIN products
    ON transactions.product_id = products.product_id;

-- Overall gross margin percentage
SELECT
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
    ON transactions.product_id = products.product_id;

-- Gross profit by category
SELECT
    products.category,
    SUM(
        (transactions.quantity * products.unit_price)
        * (1 - transactions.discount)
    )
    - SUM(transactions.quantity * products.cost_price) AS gross_profit
FROM transactions
JOIN products
    ON transactions.product_id = products.product_id
GROUP BY products.category
ORDER BY gross_profit DESC;

-- Gross margin percentage by category
SELECT
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
GROUP BY products.category
ORDER BY gross_margin_percentage DESC;
