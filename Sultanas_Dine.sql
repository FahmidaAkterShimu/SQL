# 1. What is the total amount each customer spent at the restaurant?

select s.customer_id, sum(m.price)
from sales as s
         left join menu as m
                   on s.product_id = m.product_id
group by s.customer_id;


# 2. How many days has each customer visited the restaurant?

select customer_id, count(*) as Total_Days
from (select distinct customer_id, order_date from sales) s
group by customer_id;


# 3. What was the first item from the menu purchased by each customer?

select distinct customer_id, product_name
from (select s.customer_id,
             m.product_id,
             m.product_name,
             s.order_date,
             dense_rank() over (partition by customer_id order by order_date, m.product_id) as rnk
      from sales s
               left join menu m on s.product_id = m.product_id) as t
where rnk = 1;


# 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

select product_name, count(product_name) cnt
from menu m
         left join sales s on m.product_id = s.product_id
group by product_name
order by cnt desc
limit 1;


# 5. Which item was the most popular for each customer?

select customer_id, product_name
from (select *, rank() over (partition by customer_id order by times desc) rnk
      from (select customer_id, product_name, count(*) times
            from sales s
                     left join menu m on s.product_id = m.product_id
            group by customer_id, product_name) as t) as t2
where rnk = 1;


# 6. Which item was purchased first by the customer after they became a member?

select customer_id, product_name from
    (select s.customer_id, n.product_name,
           dense_rank() over (partition by s.customer_id order by s.order_date) as r
    from sales s
    left join members m on s.customer_id = m.customer_id
    left join menu n on n.product_id= s.product_id
    where s.order_date > m.join_date
    ) as t
where r=1;


# 7. Which item was purchased just before the customer became a member?

select customer_id, product_name from
    (select s.customer_id, n.product_name,
           dense_rank() over (partition by s.customer_id order by s.order_date desc ) as r
    from sales s
    left join members m on s.customer_id = m.customer_id
    left join menu n on n.product_id= s.product_id
    where s.order_date < m.join_date
    ) as t
where r=1;


# 8. What is the total items and amount spent for each member before they became a member?

select customer_id, count(product_name), sum(price) from
    (select s.customer_id, n.product_id, n.product_name, price,
           dense_rank() over (partition by s.customer_id order by s.order_date desc ) as r
    from sales s
    left join members m on s.customer_id = m.customer_id
    left join menu n on n.product_id= s.product_id
    where s.order_date < m.join_date
    ) as t
group by customer_id;


# 9. If each 1 Taka spent equales to 10 points and kacchi has a 2x points multiplier - how many points would each customer have?

select s.customer_id,
       sum(
           case
               when m.product_name = 'kacchi' then m.price * 10 * 2
               else m.price * 10
           end
       ) as total_points
from sales s
inner join menu m on s.product_id = m.product_id
group by s.customer_id;


# 10. In the 3 days after a customer joins the program( (including their join date)
#     1. they earn 2x points on all items, not just Kacchi(Only for first 3 days)
#     2. After 3 days - If each 1 Taka spent equates to 10 points and kacchi has a 2x points multiplier
#     how many points do customer A and B have at the end of January, 2021?

select customer_id,
       sum(
       case
           when r <= 3 then price * 10 * 2
           else price * 10
       end
       ) as total_points
from
(select s.customer_id, n.product_name, s.order_date, price,
           dense_rank() over (partition by s.customer_id order by s.order_date) as r
    from sales s
    left join members m on s.customer_id = m.customer_id
    left join menu n on n.product_id= s.product_id
    where s.order_date >= m.join_date
    and order_date like '2021-01%'
    ) as t
group by customer_id