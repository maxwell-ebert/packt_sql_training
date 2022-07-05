/*ACTIVITY 6: Analyzing SalesData Using Aggregate Functions*/

/* Same deal - this is just more exercises from the SQL book, just for me to get up to speed and comfortable
after years of just using SAS. My first commit will be my un-checked run, then a second push with annotations
and/or corrections*/

/*The big reminder here is that this should get as close to one big query as possible.
Given that this is gathering some aggregates, it may be less important to condense it 
all the way down*/

/*1: This will be mostly done out of sales table*/
SELECT * 
FROM SQLDA_DB.sqlda.[public].sales

SELECT *
FROM SQLDA_DB.sqlda.[public].dealerships

/*2: Calculate the total number of unit sales the company has done*/
/*Graded - correct*/
SELECT COUNT(*)
FROM SQLDA_DB.sqlda.[public].sales

/*3: Calculate the total sales amount in dollars for each state*/
/*Graded - I had the right idea, but the solution (below) uses customers instead of dealerships,
which gives a different set of answers. I'm really not sure why we'd use customers as a frame of 
reference, versus the dealerships that made the sale. Using customers makes more sense, though
because of internet sales. I'd argue that the prompt should state whether it's state of dealership
or state of customer residence. I'm giving myself like a 9/10 on this one*/
SELECT SUM(s.sales_amount) AS state_sales, d.[state]
FROM SQLDA_DB.sqlda.[public].sales s
LEFT JOIN SQLDA_DB.sqlda.[public].dealerships d
ON s.dealership_id = d.dealership_id
WHERE d.[state] IS NOT NULL
GROUP BY d.[state]
ORDER BY d.[state]

/*Book answer*/
SELECT c.[state], SUM(sales_amount) as total_sales_amount
FROM SQLDA_DB.sqlda.[public].sales s
INNER JOIN SQLDA_DB.sqlda.[public].customers c ON c.customer_id=s.customer_id
GROUP BY c.[state]
ORDER BY c.[state]


/*4: Identify the top five best dealerships in terms of the most units sold (ignoring internet sales)*/
/*Graded - correct - i had 19 as top, but that was a typo*/
SELECT COUNT(*) AS dealership_sales, dealership_id
FROM SQLDA_DB.sqlda.[public].sales
WHERE channel='dealership'
GROUP BY dealership_id
ORDER BY dealership_sales DESC
/*Top 5 performing dealerships are: 10, 7, 18, 11, 1 in desc order*/

/*5: Calculate the average sales amount for each channel, as seen in the sales table, and look at the average
sales amount first by channel sales, then by product_id, and then by both together*/
/*Graded - Correct - the answer in the book has some slightly different aliasing, which I've
gone ahead and just included for the sake of clarity*/
SELECT * 
FROM SQLDA_DB.sqlda.[public].sales

/*by channel*/
SELECT channel, AVG(sales_amount) AS avg_sales_amount
FROM SQLDA_DB.sqlda.[public].sales
GROUP BY channel
ORDER BY channel

/*by product id*/
SELECT product_id, AVG(sales_amount) AS avg_sales_amount
FROM SQLDA_DB.sqlda.[public].sales
GROUP BY product_id
ORDER BY product_id ASC

/*Both together*/
SELECT channel, product_id, AVG(sales_amount) AS avg_sales_amount
FROM SQLDA_DB.sqlda.[public].sales
GROUP BY GROUPING SETS (
(channel),
(product_id),
(channel,product_id)
)
ORDER BY 1 ASC, 2

/*From the book*/
SELECT s.channel, s.product_id, AVG(sales_amount)as avg_sales_amount
FROM SQLDA_DB.sqlda.[public].sales s
GROUP BY
GROUPING SETS(
(s.channel),(s.product_id),
(s.channel, s.product_id)
)
ORDER BY 1,2