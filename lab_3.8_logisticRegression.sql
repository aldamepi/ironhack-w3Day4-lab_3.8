

--

--

-- Lab 3.8 - Logistic Regression Predictions



use sakila;

-- general queries
select * from film;
select * from rental;


select * from store;
select * from staff;
select * from inventory;

select * from film_category;
select * from category;
select * from actor;
select * from film_actor;



-- just check the meaning of categories from film_category

select film_id, count(category_id) as counter from film_category
group by film_id
order by counter desc; -- every film has a single category


-- just check the rental

select * from rental
where year(rental_date) = 2005 and month(rental_date) = 7;





--

-- get the most rented categories in the month of july 2005

select * from film_category;
select * from film;
select * from inventory;
select * from rental;


-- what if I just get the categories and the rentals?

-- the categories sorted by rentals in july -- add after categories table

select category_id, count(rental_id) as n_rents from film_category
join film
using(film_id)
join inventory
using(film_id)
join rental
using(inventory_id)
where year(rental_date) = 2005 and month(rental_date) = 7
group by category_id
order by n_rents desc
limit 5;



-- get the table of categories

select film_id, category_id from film_category;


-- the top rented categories
select film_id, category_id as top_categories from film_category
where category_id in (15,2,1,7,14);





--

-- get the most rented actors in july


select * from film_actor;
select * from film;
select * from inventory;
select * from rental;

select actor_id, count(rental_id) as n_rents from film_actor
join film
using(film_id)
join inventory
using(film_id)
join rental
using(inventory_id)
where year(rental_date) = 2005 and month(rental_date) = 7 -- and n_rents > ((max(n_rents)-min(n_rents))*0.8+min(n_rents))
group by actor_id
order by n_rents desc
limit 5;


-- get the table of actors

select film_id, actor_id from film_actor;
-- where actor_id in (107,181,198,144,60);


-- table number of super stars

select film_id, count(actor_id) as n_stars from film_actor
where actor_id in (107,181,198,144,60) -- if I place a subquery must be with having instead of limit
group by film_id
order by n_stars;
-- having n_stars >1; -- some films have more than one super stars
-- order by n_stars;



--

-- get the general table

select distinct(rental_duration) from film;
select distinct(rental_rate) from film;
select rental_duration, rental_rate from film
order by rental_rate, rental_duration;


select film_id, round(rental_rate/rental_duration,2) as daily_cost, length
		, rating, replacement_cost
        , count(customer_id) as n_customers
		, count(inventory_id) as copies
        -- , store_id --> beyond the scope
        -- , count(rental_id) as n_rents -- the number of rentals is required later
--		-- rental_id, rental_date, customer_id
from film
join inventory
using(film_id)
join rental
using(inventory_id)
where year(rental_date) = 2005 -- and month(rental_date) = 7 
group by film_id; -- , store_id; --> beyond the scope





--

-- check individual columns


-- check release_year -- meaningless

select * from film
where release_year <> 2006;



-- Get ratings ranking


select * from film;

select rating, count(rental_id) as n_rents from film
join inventory
using(film_id)
join rental
using(inventory_id)
where year(rental_date) = 2005 -- and month(rental_date) = 7
group by rating
order by n_rents desc;


/*
-- check languages -- meaningless

select * from film;

select distinct(language_id) from film;



-- check replacement costs

select distinct(replacement_cost) from film order by replacement_cost;

select max(replacement_cost), min(replacement_cost) from film;



-- check special features -- meaningless

select distinct(special_features) from film;



select special_features, avg(replacement_cost) as cost from film
group by special_features
order by cost desc;

select special_features, count(rental_id) as n_rents from film
join inventory
using(film_id)
join rental
using(inventory_id)
group by special_features
order by n_rents desc;
*/




--

-- Obtain aggragates from rental



-- get the number of copies by store -- is it possible? group by two columns

select * from film;
select * from inventory;
select * from rental;


select film_id -- , count(inventory_id) as copies
	,count(customer_id) as n_customers
    -- , count(rental_id) as n_rents, store_id,
from film
join inventory
using(film_id)
join rental
using(inventory_id)
group by film_id; -- , store_id;
-- order by copies desc;




select film_id, round(rental_rate/rental_duration,2) as daily_cost, length
		, rating, replacement_cost
        , count(customer_id) as n_customers
		, count(inventory_id) as copies
        -- , store_id --> beyond the scope
        -- , count(rental_id) as n_rents -- the number of rentals is required later
--		-- rental_id, rental_date, customer_id
from film
join inventory
using(film_id)
join rental
using(inventory_id)
where year(rental_date) = 2005 -- and month(rental_date) = 7 
group by film_id; 








--

-- check rental period

select film_id, round(avg(datediff(return_date, rental_date)),0) as rent_period
from film
join inventory
using(film_id)
join rental
using(inventory_id)
where return_date is not null
group by film_id; -- , store_id; -- beyond the scope 


select * from rental;



--

-- final tables of rentals


-- rentals in june

select film_id, count(rental_id) as n_rents 
from film
join inventory
using(film_id)
join rental
using(inventory_id)
where year(rental_date) = 2005 and month(rental_date) = 6 
group by film_id; -- , store_id; --> beyond the scope



-- rentals in july

select film_id, count(rental_id) as n_rents 
from film
join inventory
using(film_id)
join rental
using(inventory_id)
where year(rental_date) = 2005 and month(rental_date) = 7 
group by film_id; -- , store_id; --> beyond the scope







