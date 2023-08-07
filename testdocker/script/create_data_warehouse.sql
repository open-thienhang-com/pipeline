DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Store;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Delivery;
DROP TABLE IF EXISTS DateOrder;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Campaign;
DROP TABLE IF EXISTS Strategy;
DROP TABLE IF EXISTS Discount_Type;
DROP TABLE IF EXISTS Discount_Value;

CREATE TABLE Customer (
customer_id SERIAL PRIMARY KEY NOT NULL,
customer_name VARCHAR(200) NOT NULL,
gender  VARCHAR(10)  NOT NULL,
email VARCHAR(100) NOT NULL,
phone VARCHAR(20) UNIQUE NOT NULL,
city VARCHAR(100) NOT NULL,
country VARCHAR(100) NOT NULL,
street_name VARCHAR(200) NOT NULL,
street_number VARCHAR(20) NOT NULL,
market_segment VARCHAR(20) NOT NULL
);

CREATE TABLE Product (
product_id SERIAL PRIMARY KEY NOT NULL,
name_product VARCHAR(100) NOT NULL,
description_product TEXT,
price DECIMAL(10,2) NOT NULL,
stock INT NOT NULL,
product_size VARCHAR(10) NOT NULL,
product_category VARCHAR(20) NOT NULL,
brand VARCHAR(50) NOT NULL,
inventory_status VARCHAR(50) NOT NULL,
sales_type VARCHAR(50) NOT NULL
);

CREATE TABLE Store (
store_id SERIAL PRIMARY KEY NOT NULL,
name_store VARCHAR(100) NOT NULL,
city VARCHAR(100) NOT NULL,
country VARCHAR(100) NOT NULL,
street_name VARCHAR(200) NOT NULL,
street_number VARCHAR(20) NOT NULL,
store_manager  VARCHAR(200) NOT NULL
);

CREATE TABLE Employee (
employee_id SERIAL PRIMARY KEY NOT NULL,
employee_name VARCHAR(200) NOT NULL,
city VARCHAR(100) NOT NULL,
country VARCHAR(100) NOT NULL,
street_name VARCHAR(200) NOT NULL,
street_number VARCHAR(20) NOT NULL,
gender VARCHAR(10)  NOT NULL,
age INT NOT NULL,
salary_Level VARCHAR(20) NOT NULL,
status VARCHAR(20) NOT NULL,
star_work_day TIMESTAMP,
education_level VARCHAR(20) NOT NULL,
last_rating DECIMAL(4,2) NOT NULL
);

CREATE TABLE Payment (
payment_id SERIAL PRIMARY KEY NOT NULL,
payment_method VARCHAR(50) NOT NULL
);

CREATE TABLE Delivery (
delivery_id SERIAL PRIMARY KEY NOT NULL,
delivery_method VARCHAR(50) NOT NULL,
delivery_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE DateOrder (
date_order_id SERIAL PRIMARY KEY NOT NULL,
datetime TIMESTAMP NOT NULL

);

CREATE TABLE Campaign (
campaign_id SERIAL PRIMARY KEY NOT NULL,
time_start TIMESTAMP,
time_end TIMESTAMP,
quality INT NOT NULL,
description VARCHAR(255) NOT NULL,
status VARCHAR(20) NOT NULL
);

CREATE TABLE Strategy (
strategy_id SERIAL PRIMARY KEY NOT NULL,
discount_type VARCHAR(50) NOT NULL,
time_start TIMESTAMP,
time_end TIMESTAMP,
status VARCHAR(20) NOT NULL
);

CREATE TABLE Discount_Type (
discount_type_id SERIAL PRIMARY KEY NOT NULL,
quality_discount INT NOT NULL,
description VARCHAR(255) NOT NULL
);

CREATE TABLE Discount_Value (
discount_value_id SERIAL PRIMARY KEY NOT NULL,
value_discount DECIMAL(10,2) NOT NULL,
maximum_discount_amount DECIMAL(10,2) NOT NULL
);

CREATE TABLE Orders (
order_id SERIAL PRIMARY KEY NOT NULL,
customer_id INT NOT NULL,
product_id INT NOT NULL,
store_id INT NOT NULL,
employee_id INT NOT NULL,
payment_id INT NOT NULL,
delivery_id INT NOT NULL,
date_order_id INT NOT NULL,
campaign_id INT NOT NULL,
strategy_id INT NOT NULL,
discount_type_id INT NOT NULL,
discount_value_id INT NOT NULL,
total_amount_order DECIMAL(12,2) NOT NULL,
discount_amount DECIMAL(12,2) DEFAULT 0,
CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
CONSTRAINT fk_order_product FOREIGN KEY (product_id) REFERENCES Product(product_id),
CONSTRAINT fk_order_store FOREIGN KEY (store_id) REFERENCES Store(store_id),
CONSTRAINT fk_order_employee FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
CONSTRAINT fk_order_payment FOREIGN KEY (payment_id) REFERENCES Payment(payment_id),
CONSTRAINT fk_order_delivery FOREIGN KEY (delivery_id) REFERENCES Delivery(delivery_id),
CONSTRAINT fk_order_date FOREIGN KEY (date_order_id) REFERENCES DateOrder(date_order_id),
CONSTRAINT fk_order_campaign FOREIGN KEY (campaign_id) REFERENCES Campaign(campaign_id),
CONSTRAINT fk_order_strategy FOREIGN KEY (strategy_id) REFERENCES Strategy(strategy_id),
CONSTRAINT fk_order_discount_type FOREIGN KEY (discount_type_id) REFERENCES Discount_Type(discount_type_id),
CONSTRAINT fk_order_discount_value FOREIGN KEY (discount_value_id) REFERENCES Discount_Value(discount_value_id)
);


