--  Quitar el autocommit. Comprobar que ha funcionado
SHOW VARIABLES LIKE 'autocommit';
SET AUTOCOMMIT = 0;
-- Vemos las filas existentes
USE academia;
SELECT * FROM alumnos;

-- Insertamos un par de filas usando las columnas completas
-- Comprobamos que están
INSERT INTO alumnos VALUES(101, 'Frac', 'GALAGHER', 'fgalaher@email.com', 45, 2),
							(102, 'FIONA', 'GALAGHER', 'fi-galaher@email.com', 23, 6);
COMMIT;
-- Hacemos un ROLLBACK y comprobamos de nuevo
ROLLBACK;
-- 6. Volvemos a insertarlas y hacemos un COMMIT
 -- 7. Intentar hacer un ROLLBACK. ¿funciona?
 
 /** Ahora vamos a hacer una transacción con START TRANSACTION.
 a. Insertamos una fila
 b. Borramos otra
 c. Modificamos otra
 9. Hacemos un Rollback y comprobamos que se ha deshecho la transacción **/
 select * from alumnos;
 START TRANSACTION;
 INSERT INTO alumnos VALUES(104, 'MARC', 'JAMES', 'marcjames@email.com', 30, 8);
 REPLACE INTO alumnos VALUES(102, 'Fiona', 'GALAGHER', 'fiona-galaher@email.com', 24, 9);
 DELETE FROM alumnos WHERE cod_alumno = 104;
 COMMIT;
 ROLLBACK;
 /** 10. Volvemos a lanzar la transacción pero con COMMIT y comprobamos que ha
 funcionado
 11. Vamos a hacer ahora un Rollback parcial
 a. Insertamos una fila
 b. Ponemos un SAVEPOINT
 c. Borramos otra
 d. Modificamos otra **/
 START TRANSACTION;
 INSERT INTO alumnos VALUES(104, 'MARC', 'JAMES', 'marcjames@email.com', 30, 8);
 SAVEPOINT alumnoMarc;
 DELETE FROM alumnos WHERE cod_alumno = 104;
 ROLLBACK TO alumnoMarc;
 
/** 12. Truncamos la tabla coches para que quede vacía
 13. Volvemos a poner el autocommi **/
 TRUNCATE coches2;
 SELECT * FROM coches2;
 
 SHOW VARIABLES LIKE 'autocommit';
SET AUTOCOMMIT = 1;