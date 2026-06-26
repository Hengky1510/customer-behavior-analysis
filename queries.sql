select
  user_id,
  count(distinct(order_id)) as total_orders
from
  `bigquery-public-data.thelook_ecommerce.order_items`
where
  status = "Complete"
group by user_id
order by total_orders desc
limit 10;

select
  user_id,
  sum(sale_price) as total_spending
from `bigquery-public-data.thelook_ecommerce.order_items`
where status = "Complete"
group by user_id
order by total_spending desc
limit 10;

with total_order as (
  select
    user_id,
    count(distinct(order_id)) as total_orders
  from `bigquery-public-data.thelook_ecommerce.order_items`
  where status = "Complete"
  group by user_id
)

select
  avg(total_orders) as average_orders
from total_order;

select 
  u.state,
  count(distinct(o.user_id)) as total_customer
from `bigquery-public-data.thelook_ecommerce.users` u
join bigquery-public-data.thelook_ecommerce.order_items o on o.user_id = u.id
group by u.state
order by total_customer desc;

select
  avg(age) as average_age
from `bigquery-public-data.thelook_ecommerce.users`;

select 
  u.gender as gender,
  sum(o.sale_price) as total_spending
from `bigquery-public-data.thelook_ecommerce.users` u
join bigquery-public-data.thelook_ecommerce.order_items o ON o.user_id = u.id
where o.status = "Complete"
group by gender
order by total_spending desc;

select
  FORMAT_TIMESTAMP('%Y-%m', created_at) as year_month,
  sum(sale_price) as revenue
from
  `bigquery-public-data.thelook_ecommerce.order_items`
where status = "Complete"
group by year_month
order by revenue DESC Limit 1;