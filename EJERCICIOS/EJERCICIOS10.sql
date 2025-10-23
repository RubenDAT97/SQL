-- 1. Crear una tabla llamada “FABRICANTES” que tenga la siguiente estructura
USE academia;
CREATE TABLE FABRICANTES(
CODIGO INT PRIMARY KEY auto_increment,
NONBRE VARCHAR(50) NOT NULL,
APELLIDOS VARCHAR(50),
EDAD INT,
FECHA_ALTA DATE
);
-- 2. . Hacer un DESC dela tabla para ver sus propiedades y comprobamos que
-- tenemos la Primary Key y el auto_increment.
DESC FABRICANTES;
-- 3. Insertar un par de filas en la tabla para comprobar el autoincrement. Debe
-- haber generado un valor a partir de 1.
INSERT FABRICANTES VALUES(1, 'JUÁN', 'PÉREZ', 40, current_date());
INSERT INTO FABRICANTES VALUES(3, 'ANA', 'GARCÍA', 26, current_date());
SELECT * FROM FABRICANTES;
INSERT INTO FABRICANTES (NONBRE, APELLIDOS, EDAD, FECHA_ALTA) VALUES ('PEDRO', 'MARÍA', 34, current_date());
ALTER TABLE FABRICANTES CHANGE NONBRE  NOMBRE VARCHAR(50);
-- EJERCICIO 4 Y 5
-- 4. Modificar el campo AUTOINCREMENT para que comience ahora desde 1000
--  5. Insertar otro par de filas para omprobar el resultado
ALTER TABLE FABRICANTES auto_increment = 1000;
INSERT INTO FABRICANTES (NOMBRE, APELLIDOS, EDAD, FECHA_ALTA) VALUES ('MARTA', 'LARA', 56, current_date());

-- 6. Crear una clave única a nivel de TABLA para las columnas nombre
-- y apellidos.
ALTER TABLE FABRICANTES ADD CONSTRAINT nombre_completo UNIQUE(NOMBRE, APELLIDOS);

-- 7. Hacer un DESC para comprobar el resultado. Debe poner MUL para indicar que
-- es una clave múltiple.
DESC FABRICANTES;
--  8. Comprobar las constraints de la tabla con
--  “information_schema.table_constraints
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'FABRICANTES' AND TABLE_SCHEMA = 'academia';


-- ---------------

 --  9. Crear una tabla llamada “TANQUES” con la siguiente estructura y después
 -- comprobar con DESC:
 CREATE TABLE TANQUES(
 CODIGO INT PRIMARY KEY auto_increment,
 NOMBRE VARCHAR(50) NOT NULL,
 PAIS VARCHAR(50) NOT NULL DEFAULT('DESCONOCIDO'),
 LONGITUD INT NOT NULL DEFAULT(0),
 PESO INT DEFAULT(5600),
 PESO_ARMADO INT
 );
 DESC TANQUES;
 
 -- 10. AÑADIR FILAS
  insert into tanques (nombre,pais,longitud,peso,peso_armado) values
 ('Lepoard A','Alemania',9.67,62000,65000);
 insert into tanques (nombre,pais,longitud,peso,peso_armado) values
 ('Lepoard E','España',9.67,62000,65000);
 insert into tanques (nombre,pais,longitud,peso,peso_armado) values
 ('T-90M','Rusia',9.63,46000,48000);
 insert into tanques (nombre,pais,longitud,peso,peso_armado) values
 ('Leclerc','Francia',10.6,56000,73000);
 insert into tanques (nombre,pais,longitud,peso,peso_armado) values
 ('Merkava Mk.4','Israel',9.04,65000,73000);
 SELECT * FROM TANQUES;

-- 11. Añadir una constraint de tipo UNIQUE en la columna “nombre_tanque”
ALTER TABLE TANQUES ADD CONSTRAINT nombre_tanque UNIQUE (nombre);
-- 12. Comprobar que se ha realizado la restricción
DESC TANQUES;
-- 13. 13. Intentar añadir una de las filas anteriores. Debe generar 
-- un error porque aunque genera una nueva Primary Key con el increment, 
-- la clave única debe fallar.
-- 14. Insertar una nueva fila dejando los default por defecto
 insert into tanques (nombre,pais) values
 ('Merkava CBD67','RUSIA');
 -- 15. 16. Crear una constraint de tipo CHECK, donde el peso_armado no puede ser
-- inferior al peso del tanque. La llamamos “control_peso”
ALTER TABLE TANQUES ADD CONSTRAINT control_peso CHECK (PESO_ARMADO > PESO);
DESC TANQUES;
-- 16. Comprobar las constraints
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'TANQUES' AND TABLE_SCHEMA = 'academia';
-- 18. Insertar una fila para comprobar que funciona y que no deja insertarlo.
 insert into tanques (nombre,pais,longitud,peso,peso_armado) values
 ('Merkava Mk.9','Israel',9.04,85000,73000);
 
 -- SIGUIENTE TABLA 
 CREATE TABLE PAISES (
 NOMBRE_PAIS VARCHAR(50) PRIMARY KEY,
 DESCRIPCION VARCHAR(150)
 );
-- 20 Intentar crear una clave ajena entre tanques y países, de forma que el país de
-- Tanques sea foreign key de la columna nombre_pais de la tablas países.
 ALTER TABLE TANQUES
 ADD CONSTRAINT fk_pais foreign key (PAIS)
 references PAISES (NOMBRE_PAIS);
-- Insertar los valores necesarios
-- 22. Intentar de nuevo crear la foreign key. Ahora debería funcionar
  INSERT INTO PAISES VALUES('España', 'TIERRA');
   INSERT INTO PAISES VALUES('Alemania', 'TIERRA');
 INSERT INTO PAISES VALUES('Rusia', 'TIERRA');
  INSERT INTO PAISES VALUES('Francia', 'TIERRA');
   INSERT INTO PAISES VALUES('Israel', 'TIERRA');
DESC PAISES;
--  Borrar la restricción de tipo Check que creamos antes, denominada
-- “control_peso” y comprobamos que ha desaparecido.
ALTER TABLE TANQUES DROP CHECK control_peso;
-- 25. Borrar el default de la columna “longitud” y comprobar que ha desaparecido
-- con un DESC
ALTER TABLE TANQUES ALTER LONGITUD DROP default;
DESC TANQUES;