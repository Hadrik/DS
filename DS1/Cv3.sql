-- 1
select rating, count(*)
from film
group by rating

-- 3
select customer_id, sum(amount) as total
from payment
group by customer_id
order by total

-- 5
select year(payment_date) as y, month(payment_date) as m, sum(amount)
from payment
group by year(payment_date), month(payment_date)
order by y, m

-- 6
select store_id
from inventory
group by store_id
having count(*) > 2300

-- 7
select language_id, min(length)
from film
group by language_id
having min(length) > 46

-- 9
select rating
from film
where length < 50
group by rating
having sum(length) > 250
order by rating

-- 10 - 12
select l.name, count(f.film_id)
from film f
right join language l on f.language_id = l.language_id
group by l.language_id, l.name

-- 14
select c.first_name, c.last_name, count(distinct i.film_id)
from customer c
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
group by c.customer_id, c.first_name, c.last_name

-- 23
select l.name, count(f.language_id)
from language l
left join film f on l.language_id = f.language_id and f.length > 350
group by l.language_id, l.name
