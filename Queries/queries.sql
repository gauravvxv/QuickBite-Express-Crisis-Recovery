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

-- Q5. Average Delivery time by phase
select orders.crisis_phase,round(Avg(actual_delivery_time_mins),2) as average_delivery_time_mins from orders
inner join delivery
on orders.order_id = delivery.order_id
where orders.is_cancelled = 'N'
group by orders.crisis_phase;

-- Q6. % of orders that were late
select 
round(
100.0 *
sum(
case
 when d.actual_delivery_time_mins > d.expected_delivery_time_mins
 then 1 else 0
 end
) / count(*)
,2) as late_order_percentage
from orders o
inner join delivery d
on o.order_id = d.order_id
where o.is_cancelled = 'N';

-- Q7. Did late deliveries increase cancellations?

select 
case
 when d.actual_delivery_time_mins > expected_delivery_time_mins 
 then 'Late'
 else 'On-Time'
 end as delivery_status,
count(*) as total_orders,
sum(case when o.is_cancelled = 'Y' then 1 else 0 end) as cancelled_orders,
round( 100.0 * sum(case when o.is_cancelled = 'Y' then 1 else 0 end) / count(*),2) as cancellation_rate
from orders o
inner join delivery d
on o.order_id = d.order_id
 group by delivery_status;


