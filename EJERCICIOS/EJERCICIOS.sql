-- 1. Visualizar la fecha y hora actual, con 2 funciones diferentes
select curdate();
select curtime();
-- 2. Visualizar la fecha y hora con una sola función.
select now();
-- 3. Añade 25 minutos a la hora actual.
select addtime(curtime(), '00:25:00');
-- 4. Añade 24 horas a la fecha actual.
select adddate(curdate(), interval 1 day);
-- 5. Vamos ahora a usar la tabla “rental”.
select * from sakila.rental;
-- a. Visualizar rental_date, pero solo la parte de la fecha, quitando la hora
select date_format(rental_date, '%d / %m% / %y') as "Hora formateada" from sakila.rental;
-- b. Hacer la misma operación pero visualizando el nombre del mes, pero solo para Enero y Mayo de 2005
select date_format(rental_date, "%M"), rental_date as "Nombre del mes" from sakila.rental where TIMESTAMPDIFF(MONTH,'2005-01-01','2004-05-31');
-- c. Visualizar el nombre del mes, pero traducido al español, usando CASE.
select rental_date,
		case month(rental_date)
        WHEN 1 THEN 'Enero'
        WHEN 2 THEN 'Febrero'
        WHEN 3 THEN 'Marzo'
        WHEN 4 THEN 'Abril'
        WHEN 5 THEN 'Mayo'
        WHEN 6 THEN 'Junio'
        WHEN 7 THEN 'Julio'
        WHEN 8 THEN 'Agosto'
        WHEN 9 THEN 'Septiembre'
        WHEN 10 THEN 'Octubre'
        WHEN 11 THEN 'Noviembre'
        WHEN 12 THEN 'Diciembre'
        END as "Nombre del mes"
from sakila.rental;
        
-- d. Visualizar los alquileres que se hayan hecho los sábados y domingos del mes de mayo de 2005
select * from sakila.rental;
select dayname(now());
select * from sakila.rental where dayname(rental_date) = "Saturday" or dayname(rental_date) = "Sunday";
select dayname("2005-05-28");
-- e. Averiguar cuantos días llevas viviendo 
select datediff(current_date(), "1997-01.08") as "Días viviendo";
-- • Si la devolución de una película, tiene que hacerse en 48 horas,
--  calcula cual sería la fecha de devolución prevista de los alquileres
select adddate(current_date(),interval 2 day) as "Fecha máximoa devolución";
-- f. Poner el siguiente formato a la fecha y hora actual. Esto es un ejemplo,
-- debe salir la fecha real o Fecha de factura: Friday, dia 06 del mes de January del año 2023
select concat(dayname(current_date()), ", ", date_format(current_date(), "día %d del mes de %M del año %Y ")) as "Fecha de factura";