/*ACTIVITY 5: Building a Sales Model Using SQL Techniques*/

/* Same deal - this is just more exercises from the SQL book, just for me to get up to speed and comfortable
after years of just using SAS. My first commit will be my un-checked run, then a second push with annotations
and/or corrections*/

/*Before we even grade this, It looks like the book wants us to create a whole dataset.
I'm more interested in making sure my joins are right. When I grade, I'll see what they
wanted me to do in terms of making a table*/

/*GRADING: So I was way off. It's one query, which I'll type below. However, I'm gonna grade
the peicemeal bits I did.*/
SELECT
c.*,
p.*,
COALESCE(s.dealership_id, -1) AS dealership_id,
CASE WHEN p.base_msrp - s.sales_amount >500 THEN 1 ELSE 0 END AS high_savings
/*adding a line to make a new table out of this*/
INTO salesmodel
FROM SQLDA_DB.sqlda.[public].sales s
INNER JOIN SQLDA_DB.sqlda.[public].customers c ON c.customer_id = s.customer_id
INNER JOIN SQLDA_DB.sqlda.[public].products p ON p.product_id=s.product_id
LEFT JOIN SQLDA_DB.sqlda.[public].dealerships d ON s.dealership_id=d.dealership_id

SELECT * 
FROM dbo.salesmodel

/*1: We will be using Customers, Sales, products, and dealerships*/
SELECT * 
FROM SQLDA_DB.sqlda.[public].customers

SELECT *
FROM SQLDA_DB.sqlda.[public].sales

SELECT * 
FROM SQLDA_DB.sqlda.[public].products

SELECT * 
FROM SQLDA_DB.sqlda.[public].dealerships

/*2: Use INNER JOIN to join the customers table to the sales table*/
/*Graded - correct*/
SELECT *
FROM SQLDA_DB.sqlda.[public].sales a
INNER JOIN SQLDA_DB.sqlda.[public].customers b ON a.customer_id= b.customer_id

/*3: Use INNER JOIN to join the products table to the sales table*/
/*Graded - correct*/
SELECT *
FROM SQLDA_DB.sqlda.[public].sales a
INNER JOIN SQLDA_DB.sqlda.[public].products b ON a.product_id= b.product_id

/*4: Use LEFT JOIN to join the dealerships table to the sales table*/
/*Graded - correct*/
SELECT *
FROM SQLDA_DB.sqlda.[public].sales a
LEFT JOIN SQLDA_DB.sqlda.[public].dealerships b ON a.dealership_id= b.dealership_id

/*5: Now, return all columns of the customers table and the products table*/
/*This wording is very confusing. A union doesn't work, since are a different number of columns with different names.
I think the workaround is to use sales as a go-between*/
/*this is mostly correct, because this is the beginning of the bigger table. I think the idea
is that i go back in and pick out those columns from my new salesmodel table*/
SELECT c.*, p.*
FROM SQLDA_DB.sqlda.[public].sales s
INNER JOIN SQLDA_DB.sqlda.[public].customers c ON c.customer_id= s.customer_id
INNER JOIN SQLDA_DB.sqlda.[public].products p ON p.product_id= s.product_id


/*6: Then, return the dealership_id column from the sales table, but fill in dealership_id in saleswith -1
if it is null*/
/*Graded - correct*/
SELECT COALESCE(dealership_id, -1) AS dealership_id
FROM SQLDA_DB.sqlda.[public].sales

/*7: Add a column called high_savings that returns 1 if the sales amount was 500 less than base_msrp or lower. 
Otherwise, it returns 0.*/
/*Graded - correct. I was on the right track using the sales as a go-between*/
SELECT * 
FROM SQLDA_DB.sqlda.[public].sales

SELECT * 
FROM SQLDA_DB.sqlda.[public].products

SELECT s.*, p.*,
	CASE WHEN s.sales_amount<= base_msrp-500 THEN 1
	ELSE 0 END
AS high_savings
FROM SQLDA_DB.sqlda.[public].sales s LEFT JOIN SQLDA_DB.sqlda.[public].products p
ON s.product_id = p.product_id

/*POST-MORTEM*/
/*There were a lot of lessons to learn here. The good is that I've got a very good grasp of SQL functions,
and I feel confident in my understanding of how querying works.
TO IMPROVE: Everything can be one query. SAS usually needs a bunch of data steps to get things done.
SQL, much less so. I need to pay attention when the book says "Write A QUERY" to assemble the following 
dataset. */

























































































































































































