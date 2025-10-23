CREATE SCHEMA INDCIES;
DROP SCHEMA INDCIES;
CREATE SCHEMA INDICES;

--  1. Crear un índice llamado i_nombre en la tabla cursos y columna “nombre”
CREATE INDEX i_nombre ON academia.cursos(nombre);
-- 2. Mostrar los índices de la tabla “cursos”
SHOW INDEXES FROM academia.cursos;
-- 3. ¿Por qué aparecen dos?
-- El primero hace referencia a la clave PRIMARY que de por si ya es un índice y el segundo al índice que hemos creado referente a la columa nombres.
-- 4. Comprobar que el índice se usa la consultar por “nombre”
EXPLAIN SELECT nombre FROM academia.cursos;
-- En la columna 'possible_keys' MYSQL chace la consulta a través del índice.
-- 5. Borrar el índice
DROP INDEX i_nombre ON academia.cursos;
-- 6. Volver a crearlo pero de tipo único y comprobar que se ha creado. La columna  “Non unique” debe ser de tipo 0 (único).
CREATE UNIQUE INDEX i_nombre ON academia.coches(modelo);
SELECT modelo FROM academia.coches;
SHOW INDEXES FROM academia.coches;
-- Crear la siguiente tabla. Debemos crear los índices en el momento de creación
-- de la tabla. Después, comprobar la creación de estos índices.
CREATE TABLE DATOS(
CODIGO INT PRIMARY KEY,
NOMBRE VARCHAR(50) UNIQUE,
APELLIDOS VARCHAR(50),
INDEX nombre_completo(NOMBRE, APELLIDOS)
);
SHOW INDEXES FROM DATOS;