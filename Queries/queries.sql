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

--  Q8. Average Rating per phase
select 
o.crisis_phase,
round(avg(r.rating)::numeric,2) from orders o 
inner join rating r
on o.order_id = r.order_id
group by o.crisis_phase;

-- Q9. Restaurants with most 1-star reviews in crisis
select
r.restaurant_name,
count(*) as one_star
from restaurants r
inner join rating ra
on r.restaurant_id = ra.restaurant_id
inner join orders o
on o.order_id = ra.order_id
where ra.rating = 1 
and o.crisis_phase = 'Crisis'
group by restaurant_name;

-- Q10. Restaurants with high revenue but low ratings
select 
r.restaurant_name,
round(sum(total_amount)::numeric,2) as revenue,
round(avg(ra.rating)::numeric,2) as average_rating
from restaurants r
inner join orders o
on r.restaurant_id = o.restaurant_id
inner join rating ra
on o.order_id = ra.order_id
group by r.restaurant_name
having avg(ra.rating) < 3
order by revenue desc;

-- Q11. Restaurants with highest order growth in recovery
select 
r.restaurant_name,
sum(case when o.crisis_phase = 'Crisis' then 1 else 0 end) as crisis_orders,
sum(case when o.crisis_phase = 'Recovery' then 1 else 0 end) as recovery_orders,
sum(case when o.crisis_phase = 'Recovery' then 1 else 0 end)
-
sum(case when o.crisis_phase = 'Crisis' then 1 else 0 end) as order_growth
from orders o
inner join restaurants r
on o.restaurant_id = r.restaurant_id
group by r.restaurant_name
order by order_growth desc
limit 10;

-- Q12: Which partner type performs better?
select 
r.partner_type,
count(distinct r.restaurant_id) as total_restaurants,
count(o.order_id) as total_orders,
round(sum(total_amount)::numeric,2) as total_amount
from orders o
inner join restaurants r
on o.restaurant_id = r.restaurant_id
group by r.partner_type
order by total_amount desc;

-- Q13. Which city is recovering fast?
select 
r.city,
sum(case when o.crisis_phase = 'Crisis' then 1 else 0 end) as crisis_orders,
sum(case when o.crisis_phase = 'Recovery' then 1 else 0 end) as recovery_orders,
-- Order growth
sum(case when o.crisis_phase = 'Recovery' then 1 else 0 end)
-
sum(case when o.crisis_phase = 'Crisis' then 1 else 0 end) as order_growth,
-- Recovery Percentage
round(
100.00 * (
sum(case when o.crisis_phase = 'Recovery' then 1 else 0 end) 
-
sum(case when o.crisis_phase = 'Crisis' then 1 else 0 end)
)
/ sum(case when o.crisis_phase = 'Crisis' then 1 else 0 end)
,2)  as recovery_percentage
from restaurants r
inner join orders o 
on r.restaurant_id = o.restaurant_id
group by r.city
order by recovery_percentage desc;

-- Q14. Which acquisition channel brings better returning users?
select 
c.acquisition_channel,
count(distinct c.customer_id) as total_customers,
count(distinct case when orders.total_orders > 1 then c.customer_id end) as returning_customers,
round(
100.0 * count(distinct case when orders.total_orders > 1 then c.customer_id end)
/ count(distinct c.customer_id),2
) as returning_percentage
from customers c
inner join (
select customer_id, count(order_id) as total_orders from orders group by customer_id
) as orders 
on c.customer_id = orders.customer_id
group by acquisition_channel
order by returning_percentage desc;