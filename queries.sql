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
  SUM(sale_price) AS total_spending
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
  AVG(total_orders) AS average_orders
FROM total_order;


-- Question 4
-- Which state has the highest number of customers?

SELECT
  u.state,
  COUNT(DISTINCT o.user_id) AS total_customer
FROM `bigquery-public-data.thelook_ecommerce.users` u
JOIN `bigquery-public-data.thelook_ecommerce.order_items` o
  ON o.user_id = u.id
GROUP BY u.state
ORDER BY total_customer DESC;


-- Question 5
-- What is the average customer age?

SELECT
  AVG(age) AS average_age
FROM `bigquery-public-data.thelook_ecommerce.users`;


-- Question 6
-- Spending comparison by gender

SELECT
  u.gender AS gender,
  SUM(o.sale_price) AS total_spending
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
  SUM(sale_price) AS revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE status = "Complete"
GROUP BY year_month
ORDER BY revenue DESC
LIMIT 1;
