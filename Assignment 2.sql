use sakila ; 

-- Retrieve the total number of rentals made in the Sakila database. 
select * from rental ; 
select count(*) as tot_rental from rental ;

-- Find the average rental duration (in days) of movies rented from the Sakila database 
select * from film ;
describe film ;
select title , avg(rental_duration) as average_rental_duration , avg(rental_duration) as average_rental_duration_in_days 
from film group by title ; 

-- Display the first name and last name of customers in uppercase. 
select * from customer ; 
Select UPPER(concat(first_name,' ',last_name)) as Customer_Name from Customer ;

-- Extract the month from the rental date and display it alongside the rental ID. 
select * from rental ; 
select distinct rental_id , month(rental_date) from rental ; 

-- Retrieve the count of rentals for each customer (display customer ID and the count of rentals). 
select * from rental ; 
select customer_id , count(rental_id) from rental group by customer_id ; 

-- Find the total revenue generated by each store.             -- 
select * from store ;        -- Sakila Database has no (staff_id) nor specific store which can be joined to payment 
					-- to gather revenue by each store so .... we will take TABLE(Payment) to work upon all. 
select * from payment ;                     
select staff_id , sum(amount) from payment group by staff_id ;                                 

-- Display the title of the movie, customer s first name, and last name who rented it. 

select distinct title , concat(first_name,' ',last_name) as Customer_Name 
from film 
inner join inventory on film.film_id=inventory.film_id
inner join customer on inventory.store_id=customer.store_id 
inner join rental on rental.customer_id=customer.customer_id ; 

-- Retrieve the names of all actors who have appeared in the film "Gone with the Wind." -- 'ACE GOLDFINGER'  
select concat(first_name,' ',last_name) as Actor_name from actor  -- GONE WITH THE WIND (TITLE) FILM IS NOT IN DATABASE
inner join film_actor on actor.actor_id=film_actor.actor_id        -- SO INSTEAD I HAVE CHANGED THE FILM
inner join film on film_actor.film_id=film.film_id 
WHERE title = 'ACE GOLDFINGER' ; 

-- Determine the total number of rentals for each category of movies. 
select* from film_category ; -- film_id 
select * from film ;  -- film_id 
select * from rental ; -- rental_id 
 select * from inventory ; 
SELECT
    film_category.category_id,
    COUNT(rental.rental_id) AS total_rentals
FROM
    film_category
INNER JOIN
    film ON film_category.film_id = film.film_id
INNER JOIN
    inventory ON film.film_id = inventory.film_id
INNER JOIN
    rental ON inventory.inventory_id = rental.inventory_id
GROUP BY
    film_category.category_id;

-- Find the average rental rate of movies in each language. 
select * from film ; 
select * from language ; 
select language.name, avg(film.rental_rate) as AVG_rentalrate
from language
join film on language.language_id=film.language_id 
group by language.name
having avg(film.rental_rate) is not null ; 

-- Retrieve the customer names along with the total amount they've spent on rentals. 
select * from customer ; -- customer_id 
select * from payment ; -- rental_id  -- customer_id
select * from rental ; -- customer_id -- rental_id 

select customer.first_name as Customer_Name , sum(payment.amount) as tot_amount from customer
join payment on customer.customer_id=payment.customer_id
join rental on payment.rental_id=rental.rental_id 
group by customer.first_name 
having sum(payment.amount) ; 

-- List the titles of movies rented by each customer in a particular city (e.g., 'London'). 
select * from customer ; -- customer_id -- address_id
select * from address ;   -- address_id -- city_id 
select * from city ;  -- city_id 
select * from rental ; -- customer_id -- inventory_id
select * from inventory ; -- film_id -- inventory_id
select * from film ; -- film-id
SELECT 
    film.title, customer.first_name, city.city
FROM
    film
        INNER JOIN
    inventory ON film.film_id = inventory.film_id
        INNER JOIN
    rental ON inventory.inventory_id = rental.inventory_id
        INNER JOIN
    customer ON rental.customer_id = customer.customer_id
        INNER JOIN
    address ON customer.address_id = address.address_id
        INNER JOIN
    city ON address.city_id = city.city_id
GROUP BY film.title , customer.first_name , city.city ; 

-- Display the top 5 rented movies along with the number of times they've been rented. 
select * from film ; -- film_id 
select * from inventory ; -- film_id -- inventory_id 
select * from rental ; -- inventory_id 

select film.title , count(rental.rental_id) as rental_count from film
inner join inventory on film.film_id=inventory.film_id
inner join rental on inventory.inventory_id=rental.inventory_id
group by film.title order by rental_count desc limit 5 ;  

-- Determine the customers who have rented movies from both stores (store ID 1 and store ID 2). 
select * from customer ;  -- customer_id  -- store_id 
select * from rental;  -- customer_id --inventory_id
select * from inventory ;  -- inventory_id -- store_id

select c.customer_id , c.first_name , c.last_name 
    from customer c 
inner join rental r  on c.customer_id=r.customer_id
inner join inventory i  on r.inventory_id=i.inventory_id 
where i.store_id in (1,2)
group by c.customer_id
having count(DISTINCT i.store_id) = 2 ;

