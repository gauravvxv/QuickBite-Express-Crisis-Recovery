-- Q1. Total Orders by phase
select 
crisis_phase,
count(order_id) as total_orders
from orders
group by crisis_phase;

-- Q2. Revenue by phase
select crisis_phase,
round(sum(total_amount)::numeric,2) as total_amount
from orders
group by crisis_phase;

-- Q3. Active customers by phase
select
crisis_phase,
count(customer_id) as total_customers
from orders  
group by crisis_phase;

-- Q4. Customers who ordered before june but not in june and Customer churn?
with pre_june as (
select distinct customer_id
from orders
where order_timestamp < '2025-06-01'
),
in_june as (
select distinct customer_id
from orders
where order_timestamp >='2025-06-01' and order_timestamp < '2025-07-01'
)

select
count(pre_june.customer_id) as total_before_june,
count(in_june.customer_id) as total_in_june,
count(pre_june.customer_id) - count(in_june.customer_id) as churned_customers,
round(
(count(pre_june.customer_id) - count(in_june.customer_id)) * 100.0 / count(pre_june.customer_id),2
) as churned_percentage
from pre_june 
left join in_june
on pre_june.customer_id = in_june.customer_id;

