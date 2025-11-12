CREATE database  sultanas_dine;

CREATE TABLE sales (
  customer_id varchar(10),
  order_date date,
  product_id int
);

INSERT INTO sales
  (customer_id, order_date, product_id)
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-01-16', '1'),
  ('B', '2021-01-16', '1'),
  ('B', '2021-01-17', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3'),
  ('A','2021-05-01','3');



CREATE TABLE menu (
  product_id INTEGER,
  product_name VARCHAR(50),
  price INTEGER
);

INSERT INTO menu
  (product_id, product_name, price)
VALUES
  ('1', 'kacchi', '250'),
  ('2', 'roast', '120'),
  ('3', 'beef', '200');


CREATE TABLE members (
  customer_id VARCHAR(100),
  join_date DATE
);

INSERT INTO members
  (customer_id, join_date)
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');
