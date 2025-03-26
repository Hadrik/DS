-- 1
-- a
insert into actor(first_name, last_name)
values ('Arnold', 'Schwarzenegger')

-- b
select *
from language
select top 1 * from film

insert into film(title, description, length, language_id, rental_duration, rental_rate, replacement_cost)
values ('Terminator', 'popis', 107, 
	(select language_id from language where name = 'english'),
	3, 1.99, 69)

-- c
insert into film_actor(actor_id, film_id)
values (
	(select actor_id from actor where first_name = 'Arnold' and last_name = 'Schwarzenegger'),
	(select film_id from film where title = 'Terminator')
)

-- f
update film
set replacement_cost = 2.99
where title = 'Terminator'

-- 3
update film
set rental_rate = rental_rate * 1.1
where film_id in (
	select film_id
	from film_actor fa
	join actor a on a.actor_id = fa.actor_id
	where a.first_name = 'zero' and a.last_name = 'cage'
)

-- 5
insert into inventory(film_id, store_id)
select film_id, 2
from film_actor fa
join actor a on a.actor_id = fa.actor_id
where a.first_name = 'groucho' and a.last_name = 'sinatra'

-- 4
update film
set original_language_id = null
where original_language_id = (
	select language_id
	from language
	where name = 'mandarin'
)

-- 6
delete from language
where name = 'mandarin'

-- 9
alter table film
add inventory_count int

update f
set inventory_count = (
	select count(*)
	from inventory i
	where f.film_id = i.film_id
)
from film f

-- 10
alter table category
alter column name verchar(50)

-- 12
alter table rental
add create_date date not null default getdate()

-- 13
alter table rental
drop constraint DF__rental__create_d__2739D489

alter table rental
drop column create_date

-- 14
alter table film
add creator_staff_id int references staff

-- 15
alter table staff
add constraint chck_staff_email check(email like '%@%.%')

-- 16
alter table staff
drop constraint chck_staff_email

-- 18
create table reservation (
	reservation_id int primary key identity,
	reservation_date date not null default getdate(),
	end_date date not null,
	customer_id int not null references customer,
	film_id int not null references film,
	staff_id tinyint references staff
)

-- 19
insert into reservation(end_date, customer_id, film_id)
values ('10-04-98', 420, 69)

select * from reservation

-- 23
create table rating (
	rating_id int primary key identity,
	name varchar(10) not null,
	description varchar
)

alter table film
add rating_id int not null references rating

-- 24

