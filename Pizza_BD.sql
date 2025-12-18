# 1.How many pizzas were ordered?
select count(order_id) as total_orders from customer_orders;

# 2.How many unique customer orders were made?
select count(distinct order_id) from customer_orders;

# 3.How many successful orders were delivered by each runner?
