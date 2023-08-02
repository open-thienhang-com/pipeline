CREATE TABLE customers
( cust_id NUMBER, cust_first_name VARCHAR2(20) CONSTRAINT customer_fname_nn NOT
NULL, cust_last_name VARCHAR2(40) CONSTRAINT customer_lname_nn NOT NULL,cust_sex
CHAR(1), cust_year_of_birth NUMBER(4), cust_marital_status VARCHAR2(20),cust_street_address
VARCHAR2(40) CONSTRAINT customer_st_addr_nn NOT NULL, cust_postal_code VARCHAR2(10)
CONSTRAINT customer_pcode_nn NOT NULL,cust_city VARCHAR2(30) CONSTRAINT
customer_city_nn NOT NULL, cust_state_district VARCHAR2(40),country_id CHAR(2)
CONSTRAINT customer_country_id_nn NOT NULL, cust_phone_number VARCHAR2(25),
cust_income_level VARCHAR2(30), cust_credit_limit NUMBER, cust_email VARCHAR2(30) )
CREATE DIMENSION products_dim
LEVEL product IS (products.prod_id)
LEVEL subcategory IS (products.prod_subcategory)
LEVEL category IS (products.prod_category)
HIERARCHY prod_rollup (
product CHILD OF
subcategory CHILD OF
category
)
ATTRIBUTE product DETERMINES products.prod_name
ATTRIBUTE product DETERMINES products.prod_desc
ATTRIBUTE subcategory DETERMINES products.prod_subcat_desc
ATTRIBUTE category DETERMINES products.prod_cat_desc;