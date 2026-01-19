-- Q1. Compare total orders across pre-crisis (Jan–May 2025) vs crisis (Jun–Sep 2025). How severe is the decline?
select 
count(case when crisis_phase = 'Pre-Crisis' then 1 end) as pre_crisis_jan_may,
count(case when crisis_phase in ('Crisis','Recovery') then 1 end) as crisis_jun_sep,
count(distinct case when crisis_phase = 'Pre-Crisis' then order_month end) as pre_crisis_months,
count(distinct case when crisis_phase in ('Crisis','Recovery') then order_month end) as crisis_months
from orders;

-- Q2. Revenue by phase
select 
crisis_phase,
round(sum(total_amount)::numeric,2) as total_revenue,
count(distinct order_month) as months
from orders
group by crisis_phase 
order by total_revenue desc;


-- Q3. Active customers by phase
select
crisis_phase,
count(customer_id) as total_customers
from orders  
group by crisis_phase;

-- Q4. Customers who ordered before Crisis but not in Crisis and Customer churn?
with pre_june as (
select distinct customer_id
from orders
where order_timestamp < '2025-06-01'
),
in_crisis as (
select distinct customer_id
from orders
where order_timestamp >='2025-06-01' and order_timestamp <= '2025-09-30'
)

select
count(pre_june.customer_id) as total_before_june,
count(in_crisis.customer_id) as total_in_crisis,
count(pre_june.customer_id) - count(in_crisis.customer_id) as churned_customers,
round(
(count(pre_june.customer_id) - count(in_crisis.customer_id)) * 100.0 / count(pre_june.customer_id),2
) as churned_percentage
from pre_june 
left join in_crisis
on pre_june.customer_id = in_crisis.customer_id

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

-- Q13. Which city experienced the highest percentage decline in orders during the crisis period compared to the pre-crisis period? 
select 
r.city,
round(sum(case when o.crisis_phase = 'Pre-Crisis' then 1 end) / 5.0,2) as avg_pre_crisis,
sum(case when o.crisis_phase = 'Crisis' then 1 end) as crisis_orders,
-- Decline Percentage
round(
100.0 *
(
(count(case when o.crisis_phase = 'Pre-Crisis' then 1 end) / 5.0)
- count(case when o.crisis_phase = 'Crisis' then 1 end)
)
/ (count(case when o.crisis_phase = 'Pre-Crisis' then 1 end)/5.0),2
) as decline_percentage
from
restaurants r
inner join orders o
on r.restaurant_id = o.restaurant_id
group by r.city
order by decline_percentage desc;

-- Q14. Which city is recovering fast?
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

-- Q15. Which acquisition channel brings better returning users?
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

-- Q16.  What is the cancellation rate trend pre-crisis vs crisis, and which cities are most affected?
select
r.city,
o.crisis_phase,
count(*) as total_orders,
count(case when  o.is_cancelled = 'Y' then 1 end) as cancelled_orders,
round(
100.0 * count(case when o.is_cancelled = 'Y' then 1 end) / count(*),2
) as cancellation_rate
from orders o
inner join restaurants r
on o.restaurant_id = r.restaurant_id
group by o.crisis_phase,r.city
order by r.city;

-- Q17.track average customer rating month-by-month. Which months saw the sharpest drop?
select
o.order_month,
round(avg(r.rating)::numeric,2) as average_rating
from 
orders o
inner join rating r
on o.order_id = r.order_id
group by o.order_month;
