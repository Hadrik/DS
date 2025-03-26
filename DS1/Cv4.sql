-- 1
select *
from film f
join film_actor fa on f.film_id = fa.film_id
where fa.actor_id = 10

select *
from film f
where f.film_id in (
	select film_id 
	from film_actor fa
	where fa.actor_id = 10
)

select *
from film f
where exists (
	select 1
	from film_actor fa
	where fa.film_id = f.film_id and fa.actor_id = 10
)

-- 3
select *
from film f
where f.film_id in (
	select film_id
	from film_actor fa
	where fa.actor_id = 1
) and f.film_id in (
	select film_id
	from film_actor fa
	where fa.actor_id = 10
)

-- 4
select *
from film f
where f.film_id in (
	select film_id
	from film_actor fa
	where fa.actor_id = 1 or fa.actor_id = 10
)

-- 5
select *
from film f
where f.film_id not in (
	select film_id
	from film_actor fa
	where fa.actor_id = 1
)

-- 10
select *
from customer c
where c.customer_id in (
	select customer_id
	from rental r
	join inventory i on r.inventory_id = i.inventory_id
	join film f on i.film_id = f.film_id
	where f.title = 'grit clockwork' and month(r.rental_date) = 5
) and c.customer_id in (
	select customer_id
	from rental r
	join inventory i on r.inventory_id = i.inventory_id
	join film f on i.film_id = f.film_id
	where f.title = 'grit clockwork' and month(r.rental_date) = 6
)

-- 13
select *
from film
where length < any (
	select length
	from film f
	join film_actor fa on fa.film_id = f.film_id
	join actor a on a.actor_id = fa.actor_id
	where a.first_name = 'burt' and a.last_name = 'posey'
)

-- 14 blbe myslim
select *
from actor a
join film_actor fa on fa.actor_id = a.actor_id
where fa.film_id = any (
select film_id
from film
where length < 50
)

-- 20
select *
from actor a
where not exists (
	select 1
	from film_actor fa
	join film f on f.film_id = fa.film_id
	where f.length >= 180 and fa.actor_id = a.actor_id
)
select *
from actor a
where 180 > all (
	select length
	from film_actor fa
	join film f on f.film_id = fa.film_id
	where fa.actor_id = a.actor_id
)

-- 21
select *
from customer c
where not exists (
	select 1
	from rental r
	where r.customer_id = c.customer_id
	group by month(r.rental_date)
	having count(*) > 3
)

-- 22
select *
from customer c
where not exists (
	select 1
	from rental r
	where r.customer_id = c.customer_id and month(r.rental_date) not between 6 and 8
) and exists (
	select 1
	from rental r
	where r.customer_id = c.customer_id
)
