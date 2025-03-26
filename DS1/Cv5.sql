-- 1
select f.film_id, f.title, (
	select count(*)
	from film_actor fa
	where f.film_id = fa.film_id
), (
	select count(*)
	from film_category fc
	where fc.film_id = f.film_id
)
from film f

-- 4
select f.title, (
	select count(*)
	from film_actor fa
	where fa.film_id = f.film_id
), (
	select count(distinct r.customer_id)
	from inventory i
	join rental r on r.inventory_id = i.inventory_id
	where f.film_id = i.film_id and month(r.rental_date) = 8
), (
	select avg(p.amount)
	from inventory i
	join rental r on r.inventory_id = i.inventory_id
	join payment p on p.rental_id = r.rental_id
	where f.film_id = i.film_id
)
from film f

-- 5
select *
from (
	select c.customer_id, c.first_name, c.last_name, (
		select count(*)
		from payment p
		where p.customer_id = c.customer_id and month(p.payment_date) = 6
	) cnt_pay, (
		select max(f.length)
		from film f
		join inventory i on f.film_id = i.film_id
		join rental r on r.inventory_id = i.inventory_id
		where r.customer_id = c.customer_id
	) max_len
	from customer c
) t
where t.cnt_pay > 5 and t.max_len >= 185

-- 6
-- blbe
select *
from (
	select c.customer_id, (
		select count(*)
		from payment p
		where c.customer_id = p.customer_id and p.amount > 4
	) more, (
		select count(*)
		from payment p
		where c.customer_id = p.customer_id
	) less
	from customer c
	) t
where t.more > t.less
-- dobre
select c.customer_id, c.first_name, c.last_name
from customer c
left join payment p on c.customer_id = p.customer_id
group by c.customer_id, c.first_name, c.last_name
having
	count(case when p.amount > 4 then 1 end) >
	count(case when p.amount <= 4 then 1 end)

-- 11
select c.customer_id, c.first_name, c.last_name
from customer c
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
join language l on f.language_id = l.language_id
group by c.customer_id, c.first_name, c.last_name
having
	count(*) =
	count(case when l.name = 'English' then 1 end)

-- 13
select f.title, f.length
from film f
where f.length = (
	select max(f.length)
	from film f
)

-- 14
select f1.title, f1.length, f1.rating
from film f1
where f1.length = (
	select max(f2.length)
	from film f2
	where f1.rating = f2.rating
)

select f.title, f.rating, f.length
from film f
join (
	select f.rating, max(f.length) max_len
	from film f
	group by f.rating
) t on t.rating = f.rating and t.max_len = f.length

-- 25
-- ani kokot
