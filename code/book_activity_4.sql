/*ACTIVITY 4: Marketing Operations with CRUD statements*/

/* Same deal - this is just more exercises from the SQL book, just for me to get up to speed and comfortable
after years of just using SAS. My first commit will be my un-checked run, then a second push with annotations
and/or corrections*/

/*This activity uses the customers table again, so doing a quick query to see the schema*/
SELECT * 
FROM SQLDA_DB.sqlda.[public].customers

/*1: Create a new table called customers_nyc that pulls all rows from the customers table where the customer
lives in New York City in the state of New York.*/
/*A note here - The book is in postgresql, and I'm using microsoft SQL server, since my job is a microsoft shop.
my answer here is going to be pretty different, so I'm grading myself on the fundamental correctness of the output 
table.*/
SELECT * 
INTO customers_nyc
FROM SQLDA_DB.sqlda.[public].customers
WHERE city= 'New York City' 
AND [state]= 'NY'

/*Just querying the new table to make sure it worked right*/
SELECT * 
FROM dbo.customers_nyc

/*2: Delete from the new table all customers in postal code 10014. Due to state laws, they will not be eligible
for marketing.*/
DELETE FROM dbo.customers_nyc
WHERE postal_code= 10014

/*Checking to make sure everyone in 10014 did get dropped*/
SELECT * 
FROM dbo.customers_nyc
WHERE postal_code= 10014

/*3: Add a new text column called event*/
ALTER TABLE dbo.customers_nyc
ADD [event] VARCHAR(20) NULL

SELECT * 
FROM dbo.customers_nyc

/*4: Set the value of the even to 'thank-you party'*/
UPDATE dbo.customers_nyc
SET [event]= 'thank-you party'

SELECT * 
FROM dbo.customers_nyc

/*5: You've told the manager that you've completed these steps. He tells the marketing ops team, who then uses the data 
to launch a marketing campaign.The marketing manager thanks you and then asks you to delete the customers_nyc table*/
DROP TABLE dbo.customers_nyc

/*This should throw an error*/
SELECT * 
FROM dbo.customers_nyc