-- Question 1
-- Who has the highest number of completed orders?

SELECT
  user_id,
  COUNT(DISTINCT order_id) AS total_orders
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE status = "Complete"
GROUP BY user_id
ORDER BY total_orders DESC
LIMIT 10;


-- Question 2
-- Who spends the most?

SELECT
  user_id,
  ROUND(SUM(sale_price),2) AS total_spending
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE status = "Complete"
GROUP BY user_id
ORDER BY total_spending DESC
LIMIT 10;


-- Question 3
-- What is the average number of orders per customer?

WITH total_order AS (
  SELECT
    user_id,
    COUNT(DISTINCT order_id) AS total_orders
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  WHERE status = "Complete"
  GROUP BY user_id
)

SELECT
  ROUND(AVG(total_orders),2) AS average_orders
FROM total_order;


-- Question 4
-- Average Spending per Customer?

WITH customer_spending AS (
  SELECT
    user_id,
    SUM(sale_price) AS total_spending
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  WHERE status = 'Complete'
  GROUP BY user_id
)

SELECT
  ROUND(AVG(total_spending), 2) AS average_spending_per_customer
FROM customer_spending;

-- Question 5
-- Top 10 States by Actives Customer?

SELECT
  u.state,
  COUNT(DISTINCT o.user_id) AS total_customer
FROM `bigquery-public-data.thelook_ecommerce.users` u
JOIN `bigquery-public-data.thelook_ecommerce.order_items` o
  ON o.user_id = u.id
GROUP BY u.state
ORDER BY total_customer DESC
LIMIT 10;


-- Question 6
-- Spending comparison by gender

SELECT
  u.gender AS gender,
  ROUND(SUM(o.sale_price),2) AS total_spending
FROM `bigquery-public-data.thelook_ecommerce.users` u
JOIN `bigquery-public-data.thelook_ecommerce.order_items` o
  ON o.user_id = u.id
WHERE o.status = "Complete"
GROUP BY u.gender
ORDER BY total_spending DESC;


-- Question 7
-- Which month generated the highest revenue?

SELECT
  FORMAT_TIMESTAMP('%Y-%m', created_at) AS year_month,
  ROUND(SUM(sale_price),2) AS revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE status = "Complete"
GROUP BY year_month
ORDER BY revenue DESC
LIMIT 1;
