use sakila;

select first_name, last_name from actor;

select upper(concat(first_name,' ',last_name)) as 'Actor Name' from actor;

select actor_id, first_name, last_name from actor where first_name = 'Joe';

select first_name, last_name from actor where last_name like '%GEN%'

select first_name, last_name from actor where last_name like '%LI%' order by last_name, first_name;

select country_id, country from country where country in ('Afghanistan', 'Bangladesh', 'China');

select country_id, country from country where country in ('Afghanistan', 'Bangladesh', 'China');

alter table actor
add column middle_name varchar(30) after first_name;

alter table actor
modify column middle_name blob;

alter table actor
drop column middle_name;

select last_name, count(last_name) from actor group by last_name;

select last_name, count(last_name) as 'Count of Last Name' from actor  group by last_name having count(last_name) > 2;

update actor set first_name = 'HARPO' where first_name = 'GROUCHO' and last_name = 'WILLIAMS';

update actor set first_name = 
CASE
when (actor_id = 172 and first_name = 'HARPO') then 'GROUCHO'
when (actor_id = 172 and first_name <> 'HARPO') then 'MUCHO GROUCHO'
ELSE
first_name
END;

show create table address;

select s.first_name, s.last_name, coalesce(a.address, 'No Address Found in Table') as 'address'
from
staff s
join
address a
on s.address_id = a.address_id;

select s.staff_id, s.first_name, s.last_name,  coalesce(concat('$', format(sum(p.amount), 2)), '$0') as amount 
from
staff s
join
payment p
on
s.staff_id = p.staff_id
where
p.payment_date >= '2005-08-01 00:00:00'
and
p.payment_date <   '2005-08-02 00:00:00'
group by s.staff_id;

select f.title, count(fa.actor_id) as 'Number of Actors'
from
film f
inner join
film_actor fa
on f.film_id = fa.film_id
group by f.title;

select f.title, count(i.film_id) as 'Number of Copies'
from
film f
inner join
inventory i
on
f.film_id = i.film_id
group by f.title
having f.title = 'Hunchback Impossible';

select c.first_name, c.last_name, sum(coalesce(p.amount, 0))
from customer c
join
payment p
on c.customer_id = p.customer_id
group by c.first_name, c.last_name
order by c.last_name asc;

select f.title
from film f 
where
f.language_id in
(select l.language_id from language l where name = 'English')
and
f.title rlike '^[K,Q]';

select a.first_name, a.last_name 
from actor a
where
a.actor_id in
(select fa.actor_id from film_actor fa
 where fa.film_id = 
 (select f.film_id from film f where title = 'Alone Trip'));
 
select cust.first_name
      ,cust.last_name
      ,coalesce(cust.email, 'No Email Available') as 'Email'
from
customer cust
inner join
address a
on cust.address_id = a.address_id
inner join
city
on a.city_id = city.city_id
inner join
country
on city.country_id = country.country_id
where
country.country = 'Canada';

select f.title
from film f
inner join
film_category fc
on
f.film_id = fc.film_id
inner join
category c
on
fc.category_id = c.category_id
where
c.name = 'Family';

select f.title, count(r.rental_id) as 'Number of Rentals'
from 
film f
inner join
inventory i
on f.film_id = i.film_id
inner join 
rental r
on r.inventory_id = i.inventory_id
group by f.title
order by count(r.rental_id) desc;

select  s.store_id
       ,coalesce(concat('$', format(sum(p.amount), 2)), '$0') as amount
from
store s
inner join
staff
on s.store_id = staff.store_id
inner join
payment p
on staff.staff_id = p.staff_id
group by s.store_id;

select s.store_id
      ,city.city
      ,cntry.country
from
store s
inner join
address a
on s.address_id = a.address_id
inner join
city 
on
city.city_id = a.city_id
inner join
country cntry
on
city.country_id = cntry.country_id;

select catg.name
          ,coalesce(concat('$', format(sum(p.amount), 2)), '$0') as 'Gross Revenue'
from
category catg
inner join
film_category fc
on catg.category_id = fc.category_id
inner join
inventory i
on fc.film_id = i.film_id
inner join
rental r
on i.inventory_id = r.inventory_id
inner join 
payment p
on r.rental_id = p.rental_id
group by catg.name
order by coalesce(concat('$', format(sum(p.amount), 2)), '$0') desc
limit 5;

create view top_five_genres as
select catg.name
          ,coalesce(concat('$', format(sum(p.amount), 2)), '$0') as 'Gross Revenue'
from
category catg
inner join
film_category fc
on catg.category_id = fc.category_id
inner join
inventory i
on fc.film_id = i.film_id
inner join
rental r
on i.inventory_id = r.inventory_id
inner join 
payment p
on r.rental_id = p.rental_id
group by catg.name
order by coalesce(concat('$', format(sum(p.amount), 2)), '$0') desc
limit 5;

select * from top_five_genres;

drop view top_five_genres;

