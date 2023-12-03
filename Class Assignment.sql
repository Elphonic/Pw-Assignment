use mavenmovies ; 
 -- 1)Identify the primary keys and foreign keys in maven movies db. Discuss the differences
 
SELECT TABLE_NAME, COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE CONSTRAINT_NAME = 'PRIMARY'AND TABLE_SCHEMA = 'mavenmovies';

SELECT 
    TABLE_NAME, COLUMN_name
FROM
    information_schema.KEY_COLUMN_USAGE
WHERE
    constraint_name = 'FOREIGN'
        AND TABLE_SCHEMA = 'mavenmovies'; 

select * from actor ;  -- List all details of actors
select * from customer ;  -- List all customer information from DB. 
select * from country ; 
select country from country ; -- list of different country 
select * from customer ;  -- Display all active customers. 
select customer_id , concat(first_name,last_name) as customer_name from customer where active = 1 ;
-- List of all rental IDs for customer with ID 1. 
select * from rental ; 
select rental_id from rental where customer_id = 1 ; 
-- Display all the films whose rental duration is greater than 5 .  
  select * from film ; 
select film_id , title as film  from film where rental_duration = 5 ;
-- List the total number of films whose replacement cost is greater than $15 and less than $20. 
 select title as film , replacement_cost from film where replacement_cost > 15 and replacement_cost < 20 ; 
 -- Display the count of unique first names of actors. 
 select * from actor ; 
 SELECT MIN(actor_id) AS actor_id, first_name
FROM actor
GROUP BY first_name
HAVING COUNT(actor_id) = 1;

 --  Display the first 10 records from the customer table . 
 select * from customer ;
 select customer_id , first_name , last_name from customer limit 10 ;  

 --  Display the first 3 records from the customer table whose first name starts with ‘b’.
 select * from customer ; 
select customer_id , first_name from customer where first_name like 'b%' limit 3 ;

-- Display the names of the first 5 movies which are rated as ‘G’. 

select * from film ; 
select rating , title  from film where rating = 'G' order by rating limit 5;

-- Find all customers whose first name starts with "a". 
select * from customer ;  
select customer_id , first_name from customer where first_name like 'a%' ; 

-- Find all customers whose first name ends with "a". 
select customer_id , first_name from customer where first_name like '%a' ;

--  Display the list of first 4 cities which start and end with ‘a’ . 
select * from city ; 
 select city , city_id from city where city like 'a%a' ;
 
 -- Find all customers whose first name have "NI" in any position. 
select * from customer ; 
select first_name , CUSTOMER_ID from customer where first_name like '%NI%' ;

-- Find all customers whose first name have "r" in the second position .
select first_name , customer_id from customer where first_name like '_r%' ;  

--  Find all customers whose first name starts with "a" and are at least 5 characters in length. 
select * from customer where first_name like 'a%' and length(first_name) <= 5 ; 

--  Find all customers whose first name starts with "a" and ends with "o". 
select first_name from customer where first_name like 'a%o' ; 

-- Get the films with pg and pg-13 rating using IN operator.
select * from film ;  
 SELECT film_id, title , rating 
FROM film
WHERE rating IN ('PG', 'PG-13');

-- Get the films with length between 50 to 100 using between operator. 
select * from film ; 
select length , film_id from film where length between 50 and 100 ;  

-- Get the top 50 actors using limit operator. 
select * from actor ; 
select actor_id , first_name from actor where actor_id limit 50 ; 


 