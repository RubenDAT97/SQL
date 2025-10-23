-- Encuentra la cantidad de países en cada continente
Use world;
select * from country;
select count(name) as 'Numero_paises', Continent from country group by Continent;
-- Encuentra el número total de ciudades en cada país
select * from city;
select count(name) as 'Numero_ciudades', CountryCode from city group by CountryCode;
-- Encuentra los países cuya población total es superior a 100 millones
select name, population from country where population > 100000000;
-- Encuentra la cantidad de idiomas oficiales en cada país
select * from countrylanguage;
select count(language) as 'Cantidad_idiomas' from countrylanguage 
where IsOfficial = 'T'; 
-- Encuentra los continentes donde la expectativa de vida promedio es inferior a 70 años
SELECT * from Country;
select name, continent, lifeexpectancy from country where LifeExpectancy < 70;
-- Encuentra el número total de hablantes de cada idioma en todo el mundo
select * from countryLanguage;
select language, sum(Percentage) from CountryLanguage group by language;
-- Encuentra los continentes donde ningún país tiene una población superior a 200 millones
SELECT * from Country;
select  continent
 from country
 group by continent
 HAVING 
    MAX(population) <= 200000000;
-- Encuentra los continentes donde la cantidad de países con una expectativa de vida superior a 80 años sea igual o mayor a 3
select * from country;
select continent
FROM country
WHERE LifeExpectancy > 80 
GROUP BY continent
HAVING 
    COUNT(*) >= 3;
--  Encuentra el promedio de la expectativa de vida en cada continente, excluyendo aquellos donde el promedio sea inferior a 70 año
select continent, AVG(LifeExpectancy) as 'Promedio'
FROM country
GROUP BY continent
HAVING AVG(LifeExpectancy) > 70;
