
-- 1
select email
from customer
where active = 0

-- 2
select title, description
from film
where rating = 'G'

-- 3
select *
from payment
where payment_date >= '2006-01-01' and amount < 2

-- 4
select description
from film
where rating IN ('G', 'PG')

-- 5
select description
from film
where rating IN ('G', 'PG', 'PG-13')

-- 6
select description
from film
where rating NOT IN ('G', 'PG', 'PG-13')

-- 7
select *
from film
where length > 50 and rental_duration IN (3, 5)

-- 8
select title
from film
where length > 70 and (title LIKE '%RAINBOW%' or title LIKE 'TEXAS%')

-- 9
select title
from film
where description LIKE '%And%' and
	  length between 80 and 90 and
	  rental_duration % 2 = 1

-- 10
select distinct special_features
from film
where replacement_cost between 14 and 16
-- order by special_features

-- 11
select *
from film
where rental_duration < 4 and rating != 'PG' or rating = 'PG' and rental_duration >= 4

-- 12
select *
from address
where postal_code IS NOT NULL

-- 13
select distinct customer_id
from rental
where return_date IS NULL

-- 14
select year(payment_date) as year, month(payment_date) as month, day(payment_date) as day
from payment

-- 15
select *
from film
where len(title) != 20

-- 16
select rental_id, datediff(minute,rental_date, return_date) as minutes_rented
from rental

-- 17
select concat(first_name, ' ', last_name)
from customer

-- 18
select coalesce(postal_code, '(prazdne)')
from address

-- 19
select concat(rental_date, ' - ', return_date) as 'od - do'
from rental
where return_date is not null

-- 20 nedodelane
select concat(rental_date, ' - ', return_date) as 'od - do'
from rental

-- 21
select count(*)
from film

-- 22
select count(distinct rating)
from film

-- 23
select count(*) as 'pocet adres', count(postal_code) as 'pocet adres s PSC', count(distinct postal_code) as 'pocet ruznych PSC'
from address

-- 24
select min(length) as 'nejmensi', max(length) as 'nejvetsi', avg(length) as 'prumerna'
from film

-- 25
select count(*)
from payment
where year(payment_date) = '2005'

