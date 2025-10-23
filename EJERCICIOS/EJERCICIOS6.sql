-- 2. De las tablas ALMACENES y CAJAS:
-- a. Obtener todos los almacenes
use empresas;
select * FROM almacenes;
-- b. Obtener todas las cajas con valor superior a 250
SELECT A.codigo, A.Lugar 
FROM almacenes AS A
WHERE A.capacidad > 250;
-- c. Obtener los distintos tipos de contenidos de las cajas
SELECT * FROM cajas;
SELECT DISTINCT(C.Contenido), C.NumReferencia
FROM cajas AS C;
-- d. Obtener el valor medio de las cajas
SELECT AVG(C.Valor) AS 'Valor_Medio'
FROM cajas AS C;
-- e. Obtener el valor medio de las cajas de cada almacén
SELECT A.LUGAR, AVG(C.Valor), A.Codigo
FROM cajas AS C INNER JOIN almacenes AS A
ON C.Almacen = A.Codigo
GROUP BY A.Codigo;
-- f. Obtener el número de referencia de la caja junto con el lugar en el que se encuentra
SELECT A.Lugar, C.NumReferencia, A.Codigo
FROM cajas AS C INNER JOIN almacenes AS A
ON C.Almacen = A.Codigo;
-- g. Obtener el número de cajas que hay en cada almacén
SELECT A.Lugar, COUNT(C.NumReferencia)
FROM cajas AS C LEFT JOIN almacenes AS A
ON C.Almacen = A.Codigo
GROUP BY A.Lugar;
-- h. Obtener los números de referencia de las cajas que están en el Almacén N
SELECT A.Lugar, COUNT(C.NumReferencia)
FROM cajas AS C LEFT JOIN almacenes AS A
ON C.Almacen = A.Codigo
WHERE A.Lugar = 'Almacen N';
-- 3. De las tablas DIRECTORES y DESPACHOS:
SELECT * FROM directores;
SELECT * FROM despachos;
-- a. Mostrar el DNI, el nombre y los apellidos de todos los directores:
SELECT DNI, NombreCompleto FROM directores;
-- b. Mostrar los datos de los directores que no tienen jefes
SELECT DNI, NombreCompleto, Despacho 
FROM directores
WHERE DNIJefe = null;

-- c. Mostrar el nombre y apellidos de cada director, junto con la capacidad del despacho en el que se encuentra
SELECT DI.NombreCompleto, DE.Capacidad
FROM directores AS DI INNER JOIN despachos AS DE
ON DI.Despacho = DE.Codigo; 
-- d. Mostrar el número de directores en cada despacho
SELECT despacho, COUNT(DI.NombreCompleto) AS 'Numero_Directores'
FROM directores AS DI
GROUP BY despacho
ORDER BY despacho; 
-- e. Mostrar los nombres y apellidos de los directores junto con los de su jefe
SELECT NombreCompleto, DNIJefe
FROM directores;
-- 4. De las tablas CIENTIFICOS, ASIGNADO_A y PROYECTO:
USE centro_investigacion;
SELECT * FROM asignado_a;
SELECT * FROM cientificos;
SELECT * FROM proyecto; 
-- a. Saca una relación completa de los científicos asignados a cada proyecto. Muestra el
-- DNI, el nombre del científico, el identificador del proyecto y el nombre del proyecto
SELECT A.cientifico AS 'DNI_Cientifico', A.Proyecto AS 'Identificador_PROYECTO', P.Nombre AS 'Nombre_Proyecto'
FROM asignado_a AS A INNER JOIN proyecto AS P
ON A.Proyecto = P.ID
ORDER BY P.Nombre;
use centro_investigacion;
-- b. Obtener el número de proyectos al que está asignado cada científico. Mostrar el nombre y el DNI
SELECT C.NombreApellidos, C.DNI, COUNT(A.Proyecto) AS 'Numero_Proyectos'
FROM cientificos AS C INNER JOIN asignado_a AS A
ON C.DNI = A.Cientifico
GROUP BY C.NombreApellidoS, C.DNI;
-- c. Obtener el número de científicos asignados a cada proyecto. Mostrar el identificador del proyecto y el nombre del proyecto
SELECT P.ID, P.Nombre AS 'Nombre_Proyecto', COUNT(A.Cientifico) AS 'Cientificos_Asignados'  
FROM asignado_a AS A INNER JOIN proyecto AS P
ON A.Proyecto = P.ID
GROUP BY P.ID, P.nombre
ORDER BY P.ID;
-- d. Mostrar el número de horas de dedicación de cada científico
SELECT C.NombreApellidos, C.DNI, SUM(P.Horas) AS 'Horas_Dedicacion'
FROM cientificos AS C INNER JOIN asignado_a AS A
ON C.DNI = A.Cientifico
INNER JOIN proyecto AS P
ON A.Proyecto = P.ID
GROUP BY C.NombreApellidos, C.DNI;