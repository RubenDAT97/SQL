-- De las tablas FABRICANTES y ARTÍCULOS:
USE empresa;
SELECT * FROM fabricantes;
SELECT * FROM articulos;
-- a. Obtener los nombres de los productos de la tienda.
SELECT nombre, Codigo FROM articulos;


-- b. Obtener nombres y precios de los artículos.
SELECT nombre, precio, Codigo FROM articulos;
-- c. Obtener el nombre de los artículos cuyo precio sea menor o igual a 20 €.
SELECT nombre, precio 
FROM articulos
WHERE precio <= 20;
-- d. Obtener todos los datos de los artículos cuyo precio esté entre los 60€ y los 120€.
SELECT nombre, precio 
FROM articulos
WHERE precio > 60 AND precio < 120;
-- e. Calcular el precio medio de todos los productos
SELECT AVG(precio) as 'PRECIO_MEDIO'
FROM articulos;
-- f. Calcular el precio medio de los productos del fabricante 3
SELECT AVG(A.precio) as 'PRECIO_MEDIO', F.Nombre
FROM articulos AS A INNER JOIN fabricantes AS F
WHERE F.Nombre = 'Fabricante 3' AND A.Fabricante = 3;
-- g. Calcular el número de artículos cuyo precio sea menor o igual a 160€
SELECT COUNT(nombre)
FROM articulos
WHERE precio <= 160;
-- h. Obtener un listado completo de artículos en el que aparezca el nombre del artículo y el nombre del fabricante
SELECT A.nombre, F.Nombre
FROM articulos AS A INNER JOIN fabricantes AS F
ON A.Fabricante = F.Codigo;
-- i. Obtener el precio medio de los productos de cada fabricante
SELECT AVG(precio) AS 'Precio_medio', F.Nombre
FROM articulos AS A INNER JOIN fabricantes AS F
ON A.Fabricante = F.Codigo
GROUP BY Fabricante;
-- j. Obtener el precio medio de los productos de cada fabricante mostrando además el nombre del fabricante
SELECT F.Nombre, AVG(A.precio) AS 'Precio_medio'
FROM articulos AS A, fabricantes AS F
WHERE A.Fabricante = F.Codigo
GROUP BY F.NOMBRE;
-- k. Obtener los nombres de los fabricantes que ofrezcan productos cuyo precio medio sea mayor o igual a 100€
SELECT AVG(A.Precio), F.Nombre
FROM articulos AS A INNER JOIN fabricantes AS F
ON A.Fabricante = F.Codigo
HAVING AVG(A.Precio) >= 100
ORDER BY F.Nombre ;
-- l. Obtener el nombre y el precio del artículo más barato
SELECT Nombre, Precio
FROM articulos
WHERE precio = (SELECT MIN(precio) FROM articulos);