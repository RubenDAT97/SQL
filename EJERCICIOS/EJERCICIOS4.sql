-- Extrae el continente, el país y el nombre de la ciudad de las tablas correspondientes de la base de datos world.
USE world;
select * from city;
select * from country;
select country.continent, country.name, city.name
from world.country, world.city
where City.CountryCode = Country.Code;
-- Extrae el identificador de cada película, el título y también el identificador de la 
-- categoría asociado a esa película. Usa la base de datos sakila.
USE sakila;
select * from film;
select * from film_category;
select film.film_id, film.title, film_category.category_id
FROM sakila.film, sakila.film_category
WHERE film.film_id = film_category.film_id;
 
--  Extrae la misma información que en el ejercicio anterior, pero además, extrae el nombre de la categoría.
select * from category;
select film.film_id, film.title, film_category.category_id, category.name
FROM sakila.film 
INNER JOIN sakila.film_category
ON film.film_id = film_category.film_id
INNER JOIN sakila.category
ON film_category.category_id = category.category_id;
-- Escribe el enunciado de unos cuantos posibles ejercicios para proponerlos y corregirlos en la siguiente sesión.