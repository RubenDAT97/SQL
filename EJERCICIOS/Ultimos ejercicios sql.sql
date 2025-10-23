

/*
. Ejercicios con BETWEEN
a. Extrae el nombre y la duración de las películas que duran entre 120 y 130
horas. Utiliza la tabla film
b. Extrae de la tabla rent, el ‘rental_id’ y el ‘rental_date’ de los alquileres de
febrero de 2006
c. Extrae de la tabla actor el ‘first_name’ de los actores cuyo primer nombre
comience entre B y C
*/
-- a 
select title, rental_duration from sakila.film where length between '120' and '130';

-- b. Extrae de la tabla rent, el ‘rental_id’ y el ‘rental_date’ de los alquileres de febrero de 2006
select * from sakila.rental;
select rental_id, rental_date from sakila.rental where last_update > '2006-02-01 00:00';
-- Extrae de la tabla actor el ‘first_name’ de los actores cuyo primer nombre comience entre B y C
select * from sakila.actor;
select first_name from sakila.actor where first_name between 'B' and 'C';

-- Like
-- . Averigua los actores cuyo nombre comience en B y termine en A
select * from sakila.actor where first_name like 'B%A';

--  Extrae los apellidos de los clientes cuyo apellido empiece por MA
SELECT * from sakila.customer; 
select * from sakila.customer where last_name like 'MA%';

-- . Extrae los nombres y apellidos de los clientes cuyos apellidos tengan TH en cualquier parte
select first_name, last_name from sakila.customer where last_name like '%TH%';

-- Extrae los apellidos que tengan una A como segunda letra y una E como cuarta letra
select last_name from sakila.customer where last_name like '_A_E%';
-- Extrae el nombre y los apellidos de los actores cuyo nombre sea: ‘sara’,‘fred’, ‘ed’ y ‘helen’
select first_name, last_name from sakila.actor where first_name in ('sara', 'freed', 'ed', 'helen');
-- Extrae el ‘title’ y el ‘rental_date’ de la tabla film, cuyo ‘rental_date’ sea 2.99 o 4.99
select title, rental_rate from sakila.film where rental_rate in ('2.99', '4.99');
-- Extrae el título y las características especiales de las películas que sean ‘Deleted scenes’ o ‘Comedy’
select title, special_features from sakila.film where special_features in ('Deleted Scenes','Comedy');
-- Extrae el nombre de la ciudad cuyo país es el 87 o el 60
select country from sakila.country where country_id in('87', '60');
-- Extrae la dirección (address) y dirección2 (address2) donde la dirección2 sea nula de la tabla es address
select address, address2 from sakila.address where address2 is null;
-- Extrae el rental_id, rental_date y return_date para aquellos alquileres que ya 
-- tienen fecha de devolución de la tabla rental
select rental_date, rental_id, return_date from sakila.rental where return_date is not null;
-- Vamos a usar la tabla “category”. Con un case vamos a traducir alguna de las
-- categorías, no hace falta todas
select * from sakila.category;
select *,
	case name
		when 'Action' then 'Acción'
        when 'Animation' then 'Animación'
        when 'Comedy' then 'Comedia'
        when 'Family' then 'Familia'
        Else 'Otra categoría'
	END AS 'Nombres traducidos'
from sakila.category;
/* 
Vamos a usar la tabla payment y la columna amount según las siguientes
condiciones:
a. amount<= 0.99 'Barato'
b. amount entre 1 y 4.99 'Medio'
c. amount >= 4.99 'Caro'
d. Para cualquier otra cosa ponemos 'Otros valores*/
select *,
	Case
    when amount <= 0.99 then 'Barato'
    when amount between 1 and 4.99 then 'Medio'
    when amount >= 4.99 then 'Caro'
    Else 'Otros valores'
    End As 'Precio'
    
from sakila.payment;

-- En la tabla country de la bases de datos world, extraer los siguientes datos:
-- a. Países cuyo continente es Asia y la poblacion supera los 20.000.000
select name from world.country where (Continent = 'Asia' and Population > 20000000);
-- b. Países que pertenecen a Asia o a África
select name from world.country where (Continent = 'Asia' or 'Africa');
-- c. Países que empiecen por B y que pertenezcan a África
select name from world.country where (Name like 'B%' and Continent = 'Africa');
-- d. Países que pertenezcan a Europa y cuya expectativa de vida esté entre 75 y 85 años
select name, LifeExpectancy from world.country where (LifeExpectancy between '75' and '85');
-- e. Países cuyo gobierno sea República o Monarquía
select name, GovernmentForm from world.country where (GovernmentForm = 'Monarchy' or GovernmentForm = 'Republic');
-- f. Países de África que se independizaron despué de los 50 y cuyo gobierno sea república
select name, indepYear, GovernmentForm from world.country where (IndepYear > 1950 and GovernmentForm = 'Republic');


-- En la base de datos sakila, buscar dónde se encuentran (en qué tabla) y extraer los siguientes datos:
-- a. Todos los actores cuyo nombre no es ‘Tom’ o ‘John’
select first_name from sakila.actor where (first_name not like 'Tom' or 'John');
-- b. Películas que no están en inglés y que tienen una clasificación ‘PG’
select title, language_id, rating from sakila.film where (language_id = 1 and rating = 'PG');
-- c. Películas que son clasificadas como ‘PG’ o ‘G’
select title, rating from sakila.film where (rating = 'PG' or rating = 'G');
-- d. Alquileres que ocurrieron antes de ‘2005-05-15’ o después de ‘2006-01-01’
select * from sakila.payment where (payment_date < '2005-05-15' or payment_date > 2006-01-01);
-- e. Clientes que tienen un nombre que comienza con ‘A’ y que están en ‘Canada’
select * from sakila.customer where (first_name like 'A%');

-- 1. En la tabla empleados, visualizar los siguientes datos:
-- a. Visualizar los nombres de los empleados que tengan más de 10 letras
select first_name from sakila.customer where length(first_name) > 10;
-- b. Visualizar el nombre y apellido1 de los empleados que tengan la misma longitud
select first_name, last_name from sakila.customer where length(first_name) = length(last_name);
-- c. Visualizar el nombre y los apellidos en un único campo
select concat(first_name, ' ', last_name) as 'Nombre Completo' from sakila.customer;
-- d. Visualizar las iniciales del nombre y los apellidos. Por ejemplo: Yolanda López Guillén debe aparecer como Y.L.G
select concat(substr(first_name, 1, 1), '.', substr(last_name,1, 1)) as 'Iniciales' from sakila.customer; 
-- e. Visualizar el nombre de los empleados que tengan una ‘a’ sin usar LIKE. (Utiliza la función LOCATE.)
select first_name as 'Nombres con al menos una A' from sakila.customer where position('a' in first_name) > 0;
-- f. Visualiza el nombre y la última letra del nombre
select first_name, concat(substr(first_name,1,1), substr(first_name, -1)) as 'Primera y última letra' from sakila.customer; 
-- g. Visualiza el nombre y la última letra del nombre, pero sólo si esta última letra es una vocal
select first_name as 'Nombres que acaban en vocal' from sakila.customer where
right(first_name,1) in ('a','e','i','o','u');
-- h. Extraer del correo del empleado solo una parte del nombre. Elimina lo que hay desde el ‘@’ hasta el final.
select email, substring(email, 1, instr(email, '@')-1) as 'Correo' from sakila.customer;
-- 2. También en la tabla empleados, visualiza los siguientes datos:
select customer_id, case
					when mod(customer_id,2) = 0 then 'Par'
                    when mod(customer_id,2) != 0 then 'Impar'
                    end as 'Par o Impar'
                    from sakila.customer;
-- a. Visualizar el salario y decir si es impar o par.cliente
select * FROM sakila.payment;
-- 3. En la tabla payment:
-- a. Visualiza el numero entero inferior y el posterior de la columna amount
select amount,
floor(amount) as 'Inferior', ceil(amount) as 'Superior' from sakila.payment;
