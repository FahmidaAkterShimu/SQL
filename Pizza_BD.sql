# 1.How many pizzas were ordered?
select count(order_id) as total_orders from customer_orders;

# 2.How many unique customer orders were made?
select count(distinct order_id) from customer_orders;

# 3.How many successful orders were delivered by each runner?
select runner_id, count(order_id) Succesful_Orders
from runner_orders
where pickup_time is not null
group by runner_id;

# 4.How many of each type of pizza was delivered?
select c.pizza_id, p.pizza_name, count(c.pizza_id)
from runner_orders r
         left join customer_orders c on r.order_id = c.order_id
         left join pizza_names p on p.pizza_id = c.pizza_id
where r.pickup_time is not null
group by pizza_id, pizza_name;

# 5.How many Vegetarian and Meatlovers were ordered by each customer?
select customer_id, p.pizza_name, count(c.pizza_id)
from customer_orders c
         left join pizza_names p on c.pizza_id = p.pizza_id
group by customer_id, pizza_name
order by customer_id;

# 6.What was the maximum number of pizzas delivered in a single order?
select count(c.pizza_id) max_pizzas
from customer_orders c
         left join runner_orders r on c.order_id = r.order_id
where pickup_time is not null
group by c.order_id
order by max_pizzas desc
limit 1;

# 7.For each customer, how many delivered pizzas had at least 1 change and how many had no changes?


# 8.How many pizzas were delivered that had both exclusions and extras?
# 9.What was the total volume of pizzas ordered for each hour of the day?
# 10.What was the volume of orders for each day of the week?
