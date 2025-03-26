-- 1
select *
from city c
join country co on c.country_id = co.country_id

-- 2
select title, name
from film f
join language l on f.language_id = l.language_id

-- 3
select rental_id
from rental r
join customer c on r.customer_id = c.customer_id
where c.last_name = 'simpson'

-- 4
select address
from address a
join customer c on a.address_id = c.address_id
where c.last_name = 'simpson'

-- 7
select r.rental_id, s.first_name, s.last_name, c.first_name, c.last_name, f.title
from rental r
join customer c on r.customer_id = c.customer_id
join staff s on r.staff_id = s.staff_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id

-- 8
select a.first_name, a.last_name
from film f
join film_actor fa on f.film_id = fa.film_id
join actor a on fa.actor_id = a.actor_id

-- 10
select f.title
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'horror'

-- 11
select se.store_id, sf.first_name, sf.last_name, ae.address, af.address
from store se
join staff sf on se.manager_staff_id = sf.staff_id
join address ae on se.address_id = ae.address_id
join address af on sf.address_id = af.address_id

-- 12
select f.film_id, fa.actor_id, fc.category_id
from film f
join film_actor fa on f.film_id = fa.film_id
join film_category fc on f.film_id = fc.film_id
where f.film_id = 1

-- 14
select distinct title
from film f
join inventory i on i.film_id = f.film_id

-- 16
select distinct c.first_name, c.last_name, co.country
from customer c
join address a on c.address_id = a.address_id
join city ct on a.city_id = ct.city_id
join country co on ct.country_id = co.country_id
join rental r on c.customer_id = r.customer_id
join inventory i on i.inventory_id = r.inventory_id
join film f on i.film_id = f.film_id
where f.title = 'MOTIONS DETAILS' and co.country = 'ITALY'

-- 18
select *
from payment p
left join rental r on r.rental_id = p.rental_id

-- 19
select l.name, f.title
from language l
left join film f on f.language_id = l.language_id

-- 21
select distinct f.title
from film f
left join inventory i on f.film_id = i.film_id
left join rental r on i.inventory_id = r.inventory_id
left join customer c on r.customer_id = c.customer_id
where f.length = 48 or (c.first_name = 'TIM' and c.last_name = 'CARY')

-- 22
select f.title
from film f
left join inventory i on f.film_id = i.film_id
where i.inventory_id is null

-- 24
select f.title, l.name
from film f
left join language l on f.language_id = l.language_id and l.name like 'I%'

-- 25
select c.first_name, p.payment_id, p.amount
from customer c
left join payment p on c.customer_id = p.customer_id and p.amount > 9
