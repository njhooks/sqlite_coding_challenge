--TASK 1: Top 5 Customers by Total Spend
SELECT
    c.first_name,
    c.last_name,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_spend
FROM customers AS c
JOIN orders AS o
    ON o.customer_id = c.id
JOIN order_items AS oi
    ON oi.order_id = o.id
GROUP BY
    c.id,
    c.first_name,
    c.last_name
ORDER BY
    total_spend DESC
LIMIT 5;

-- TASK 2: Total Revenue by Product Category

SELECT
    p.category,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM products AS p
JOIN order_items AS oi
    ON oi.product_id = p.id
JOIN orders AS o
    ON oi.order_id = o.id
GROUP BY
    p.category
ORDER BY
    total_revenue DESC,
    p.category ASC;

--TASK 3 Employees Earning Above Their Department Avg
SELECT
    e.first_name,
    e.last_name,
    d.name AS department_name,
    e.salary,
    ROUND(dept_avg.avg_salary, 2) AS department_avg_salary
FROM employees AS e
JOIN departments AS d
    ON e.department_id = d.id
JOIN (
    SELECT
        department_id,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_avg
    ON e.department_id = dept_avg.department_id
WHERE e.salary > dept_avg.avg_salary
ORDER BY
    department_name,
    e.salary DESC;

-- TASK 4: Cities with the Most Loyal Customers

SELECT
    c.city,
    COUNT(*) AS gold_customer_count
FROM customers AS c
WHERE c.loyalty_level = 'Gold'
GROUP BY
    c.city
ORDER BY
    gold_customer_count DESC,
    c.city ASC;
