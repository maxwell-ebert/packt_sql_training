/*ACTIVITY3: Querying the customerstable using Basic keywords in a SELECT query*/

/*This is version 1 of the first SQL activity from this book. For GIT practice, I'll write this code, get it working as best as I can,
then commit. Then, I'll look at the answers in the book, and make fixes with annotations, and commit that. That way, I can get more
comfortable with GIT versioning*/

/*1: Open your favorite SQL client and connect to the sqlda database. Examine the schema for the customers table*/
SELECT * 
FROM SQLDA_DB.sqlda.[public].customers

/*2:Write a query that pulls all emails for ZoomZoom customers in the state of florida in alphabetical order*/
SELECT email
FROM SQLDA_DB.sqlda.[public].customers
where [state]= 'FL'
order by email

/*3:Write a query that pulls all the first names, last names, and email details for ZoomZoom customers in New York City in the 
state of NY. They should be ordered alphabetically by the last name followed by the first name.*/
SELECT last_name,first_name, email
FROM SQLDA_DB.sqlda.[public].customers
WHERE city= 'New York City' AND [state]= 'NY'
ORDER BY last_name

/*4:Write a query that returns all customers with a phone number ordered by the date the customer was added to the database*/
SELECT *
FROM SQLDA_DB.sqlda.[public].customers
WHERE phone IS NOT NULL
ORDER BY date_added ASC