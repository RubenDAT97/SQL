-- EJERCICIOS CURSORES TRIGGERS
USE ACADEMIA;
/*
1. Crear un procedimiento llamado “listar_profesores” que tengan un cursor. 
Debemos ir pintando el nombre completo del profesor en mayúsculas y la 
edad. Hacerlo con un bucle LOOP */ 
DROP PROCEDURE IF EXISTS listar_profesores;
DELIMITER //
CREATE PROCEDURE listar_profesores()
BEGIN
-- CREAR VARIABLES
	DECLARE fin BOOL;
    DECLARE resultado text;
    DECLARE codigo_profesor int;
    DECLARE nombre_profesor VARCHAR(50);
    DECLARE apellidos_profesor VARCHAR(50);
    DECLARE email_profesor VARCHAR(50);
    DECLARE edad_profesor INT;
-- CURSOR Y HANDLER 
	DECLARE cursor_profesor CURSOR FOR SELECT * FROM profesores;
    DECLARE CONTINUE HANDLER FOR NOT FOUND
		set fin = true;
        set resultado = ' ';
	OPEN  cursor_profesor;
    
    BUCLE: LOOP
    FETCH cursor_profesor INTO codigo_profesor, nombre_profesor, apellidos_profesor, email_profesor, edad_profesor;
		IF fin THEN
			LEAVE bucle;
		END IF;
		SET resultado = CONCAT(resultado, 'NOMBRE:  ', UPPER(nombre_profesor), ' EDAD: ', edad_profesor, CHAR(13,10));
        -- CHAR(13,10) -----> Para saltos de línea en WINDOWS
    END LOOP;
    CLOSE cursor_profesor;
    SELECT resultado;

END //
DELIMITER ;
CALL listar_profesores();
SELECT * FROM profesores;


/* 2. Crear un procedimiento denominado “notas_max_mix” que tenga un curso 
que extraiga las notas máximas y mínimas de cada curso. Hacerlo con un 
bucle WHILE */
DROP PROCEDURE IF EXISTS notas_max_min;
DELIMITER //
CREATE PROCEDURE notas_max_min()
BEGIN
-- Crear Variables
	DECLARE fin BOOL DEFAULT FALSE;
    DECLARE resultado TEXT;
    DECLARE c_curso INT;
    DECLARE min_nota INT;
    DECLARE max_nota INT;
    
-- CURSOR Y HANDLER 
   DECLARE cursor_nota CURSOR FOR 
   select cod_curso, min(nota), max(nota) FROM notas_alumnos
   GROUP BY cod_curso;
   DECLARE CONTINUE HANDLER FOR NOT FOUND
		set fin = true;
	
    set resultado = " ";
    OPEN cursor_nota;
    FETCH cursor_nota INTO c_curso, min_nota, max_nota;
	-- Bucle WHILE para recorrer los resultados
    WHILE NOT fin DO
        
        -- Concatenar resultados
        SET resultado = CONCAT(resultado, 'CURSO: ', c_curso, 
                               ' | NOTA MÍNIMA: ', min_nota, 
                               ' | NOTA MÁXIMA: ', max_nota, CHAR(13,10));
		FETCH cursor_nota INTO c_curso, min_nota, max_nota;
    END WHILE;
    CLOSE cursor_nota;
    SELECT resultado;

END //
DELIMITER ; 
CALL notas_max_min();
/* 3. Crear un trigger llamado “insert_profesores” sobre profesores que al insertar 
un registro realice lo siguiente:
 a. Ponga el nombre y apellidos en mayúsculas o Si la edad está en blanco, 
ponemos de forma automática 24
 b. Debemos comprobar que el correo está OK. De lo contrario disparamos 
un error 45000. Para que esté bien debe tener una ‘@’ y luego un punto 
en algún lugar o Insertar el insert en la tabla de auditoría.
 c. Modificar el trigger para que sea de tipo after */
 -- CREAMOS TABLA AUDITORIA
 USE ACADEMIA;
 CREATE TABLE auditoria_profesores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    profesor_id INT,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    email VARCHAR(50),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 DROP TRIGGER IF EXISTS insert_profesores;
DELIMITER //

CREATE TRIGGER insert_profesores
BEFORE INSERT ON profesores
FOR EACH ROW
BEGIN
    -- NOMBRES Y APELLIDOS EN MAYÚSCULAS
    DECLARE nombre_mayus VARCHAR(50);
    DECLARE apellido_mayus VARCHAR(50);
    
    -- Convertir nombre y apellidos a mayúsculas
    SET nombre_mayus = UPPER(NEW.nombre);
    SET apellido_mayus = UPPER(NEW.apellidos);

    -- EDAD SI NO HAY VALOR
    IF NEW.edad IS NULL THEN
        SET NEW.edad = 24;
    END IF;

    -- COMPROBAR CORREO
    IF NOT (NEW.email LIKE '%@%' AND NEW.email LIKE '%.%') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Correo electrónico no válido. Debe contener un "@" y un "."';
    END IF;

    -- INSERTAMOS DATOS EN LA TABLA DE AUDITORÍA PARA MANTENER UN REGISTRO
    INSERT INTO auditoria_profesores (profesor_id, nombre, apellidos, email)
    VALUES (NEW.cod_profesor, nombre_mayus, apellido_mayus, NEW.email);

END //

DELIMITER ;

 SELECT * FROM profesores;
 SELECT * FROM auditoria_profesores;
 INSERT INTO profesores VALUES (52, 'pedro', 'perez', 'pepe@.email', NULL);
/* 4. Crear un trigger de borrado de alumnos de tipo before. Si se intenta borrar 
fuera del horario laboral debe rechazar el borrado con un signal de error 45000.
 a. El horario laboral será de 8 a 18
 b. Además debemos guardar en la tabla auditorías el borrado si es 
satisfactorio.
 c. Modificar el trigger para que sea de tipo after. ¿impedimos el borrado? 
*/
USE ACADEMIA;
CREATE TABLE auditoria_alumnos_borrados (
id INT AUTO_INCREMENT PRIMARY KEY,
    alumno_id INT,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    email VARCHAR(50),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);
 DROP TRIGGER IF EXISTS borrado_alumnos;
DELIMITER //

CREATE TRIGGER borrado_alumnos
BEFORE DELETE ON alumnos
FOR EACH ROW
BEGIN
	DECLARE V_HORA TIME;
    

    -- COMPROBAR SE ESTÁ EN HORARIO LABORAL 8 A 18 HORAS
    SET V_HORA = current_time();
    IF NOT V_HORA BETWEEN '08:00:00' AND '18:00:00' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Para realizar el borrado se tiene que hacer en horario laboral --> 08:00 - 18:00';
    END IF;

    -- INSERTAMOS DATOS EN LA TABLA DE AUDITORÍA PARA MANTENER UN REGISTRO
    INSERT INTO auditoria_alumnos_borrados (alumno_id, nombre, apellidos, email)
    VALUES (OLD.cod_alumno, OLD.nombre, OLD.apellidos, OLD.correo);

END //

DELIMITER ;
SELECT * FROM alumnos;
DELETE FROM alumnos WHERE cod_alumno = 101;
