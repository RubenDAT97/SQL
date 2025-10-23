-- Funciones y Control de Errores
 -- Entra en la base de datos academia y carga el fichero TARJETAS.sql.
/* 1. Crea una función que divida los números de las tarjetas en grupos de 4 
dígitos. Para las que son tipo VISA, separaremos estos grupos con ‘-’. Y para 
las que son tipo MASTERCARD, separaremos con ‘/’. Si el número no tiene 16 
dígitos escribe: ‘Número incorrecto’ */

USE academia;

DELIMITER //
DROP FUNCTION IF exists FUNCION_VISA;

CREATE FUNCTION FUNCION_VISA(numero_tarjeta VARCHAR(50), clase VARCHAR(50))
RETURNS VARCHAR(25) DETERMINISTIC
BEGIN
    DECLARE numero_formateado VARCHAR(25);
    SET numero_tarjeta = TRIM(numero_tarjeta);

    -- Verificar que el número tiene 16 dígitos
    IF CHAR_LENGTH(numero_tarjeta) = 16 THEN
        IF clase = 'mastercard' THEN
            SET numero_formateado = CONCAT(
                SUBSTRING(numero_tarjeta, 1, 4), '/', 
                SUBSTRING(numero_tarjeta, 5, 4), '/', 
                SUBSTRING(numero_tarjeta, 9, 4), '/', 
                SUBSTRING(numero_tarjeta, 13, 4)
            );
        ELSEIF clase = 'VISA' THEN
            SET numero_formateado = CONCAT(
                SUBSTRING(numero_tarjeta, 1, 4), '-', 
                SUBSTRING(numero_tarjeta, 5, 4), '-', 
                SUBSTRING(numero_tarjeta, 9, 4), '-', 
                SUBSTRING(numero_tarjeta, 13, 4)
            );
        ELSE
            SET numero_formateado = 'Tipo desconocido';
        END IF;
    ELSE
        SET numero_formateado = 'Número incorrecto';
    END IF;

    RETURN numero_formateado;
END//
DELIMITER ;
SELECT id, num_tarjeta, tipo , FUNCION_VISA(num_tarjeta, tipo) AS 'Numero_Formateado' from tarjetas;

 

/* 2. Crea una función llamada “datos alumno” que devuelva en un solo valor el 
nombre, apellidos y correo del alumno. Debe recibir como argumentos los 3 
datos del alumno. Lo probamos en una SELECT.*/ 
DELIMITER //
DROP FUNCTION IF EXISTS DATOS_ALUMNO;
CREATE FUNCTION DATOS_ALUMNO(nombre_alumno VARCHAR(50), apellidos_alumno VARCHAR(50), correo_alumno VARCHAR (50))
RETURNS VARCHAR(150) DETERMINISTIC
BEGIN
	DECLARE datos_completos VARCHAR (150);
	SET datos_completos = CONCAT(nombre_alumno, ' ', apellidos_alumno, ' ', correo_alumno);
	RETURN datos_completos;
END //
DELIMITER ;
SELECT *, DATOS_ALUMNO(nombre, apellidos, correo) AS 'Datos_Completos' FROM alumnos;
/*3. Crear una función llamada “cursos_num_alumnos” que devuelva el número de 
alumnos de un curso que se pasa como argumento Lo probamos con una 
SELECT.*/
DELIMITER //
DROP FUNCTION IF EXISTS cursos_num_alumnos;
CREATE FUNCTION cursos_num_alumnos(codigo INT)
RETURNS VARCHAR(255) DETERMINISTIC 
BEGIN
	DECLARE numero INT;
    DECLARE mensaje VARCHAR(255);
    SELECT count(*) INTO numero FROM alumnos
    WHERE cod_curso = codigo;
    SET mensaje = CONCAT('El numero de alumnos para el curso', codigo, ' es de', numero);
RETURN mensaje;
	
END //
DELIMITER ; 
SELECT cursos_num_alumnos(1);
/* 4. Crea una función llamada “nota_media” que pasándole el código del alumno 
nos indique la nota media de dicho alumno */
DELIMITER //
DROP FUNCTION IF EXISTS nota_media;
CREATE FUNCTION nota_media(codigo INT)
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN 
	DECLARE media DECIMAL(10,2);
	SELECT (sum(nota)/count(nota)) INTO media FROM notas_alumnos
	WHERE cod_alumno = codigo; 
RETURN COALESCE (media, 0);
END //
DELIMITER ;
SELECT nota_media(4);



/* 5. Crea una tabla con únicamente dos columnas: Código y Texto. Después, crea 
un procedimiento llamado “handler1” que lea la tabla. Debe tener un handler 
que controle si la tabla existe. Código 1146. ¿Qué pasa si eliminamos la tabla? */
CREATE TABLE tabla_prueba(
	CODIGO INT,
	TEXTO VARCHAR(255)
	);
DELIMITER //

DROP PROCEDURE IF EXISTS handler1;

CREATE PROCEDURE handler1()
BEGIN
    DECLARE tabla_existe INT DEFAULT 0;

    -- Verificar si la tabla existe en INFORMATION_SCHEMA
    SELECT COUNT(*) INTO tabla_existe 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'tabla_prueba';

    -- Si la tabla existe, leer los datos
    IF tabla_existe = 1 THEN
        SELECT * FROM tabla_prueba;
    ELSE
        SELECT 'ERROR 1146: La tabla no existe' AS mensaje;
    END IF;

END //

DELIMITER ;
CALL handler1();
DROP TABLE tabla_prueba;

/* 6. Hacer un procedimiento denominado “insert_curso_error” que intente insertar 
una fila en la tabla cursos. Si la clave primaria está duplicada (código 1062), en 
vez de generar un error, recalculamos la clave indicando el valor más alto más 
uno. */
DELIMITER //
DROP PROCEDURE IF EXISTS insert_curso_error;
CREATE PROCEDURE insert_curso_error(IN curso INT, IN nombre_curso VARCHAR(50), precio_curso INT)
BEGIN
	DECLARE mensaje_error VARCHAR (50) DEFAULT 'Código 1062 - Duplicado';
    DECLARE codigo_nuevo INT;
    IF EXISTS (SELECT 1 FROM cursos WHERE cod_curso = curso) THEN
		SELECT mensaje_error AS error;
        SELECT COALESCE(MAX(cod_curso) + 1, 1) INTO codigo_nuevo FROM cursos;
        INSERT INTO cursos (cod_curso, nombre, precio) VALUES (codigo_nuevo, nombre_curso, precio_curso);
	ELSE
        INSERT INTO cursos (cod_curso, nombre, precio) VALUES (curso, nombre_curso, precio_curso);
	END IF;
    
END //
DELIMITER ;
SELECT * FROM cursos;
CALL insert_curso_error(1, 'CURSO14', 200);
/* 7. Hacer un procedimiento llamado “error_generico” que intente modificar la 
columna nombre de un curso, pasando el código y el nuevo nombre. Con una 
SQLEXCEPTION debemos controlar si hay algún error y luego pintar el número 
de error usando DIAGNOSTIC. Luego probamos con algún error, como por 
ejemplo pasándole un nulo al campo o un nombre duplicado, lo que sea. */
DELIMITER //

DROP PROCEDURE IF EXISTS error_generico;

CREATE PROCEDURE error_generico (IN codigo INT, IN nuevo_nombre VARCHAR (50))
BEGIN
    DECLARE sql_error INT;
    
    -- Manejador de errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 sql_error = MYSQL_ERRNO;
        SELECT CONCAT('Error detectado: ', sql_error) AS mensaje_error;
    END;

    -- Actualizar el curso
    UPDATE cursos 
    SET nombre = nuevo_nombre 
    WHERE cod_curso = codigo;
    
    -- Mensaje de éxito si no hay errores
    SELECT 'Curso actualizado correctamente' AS mensaje_exito;
END //

DELIMITER ;
CALL error_generico(12, REPEAT('A', 51));
SELECT * FROM cursos;

/* 8. Crear un procedimiento llamado “error_condition”. Usando el ejercicio 
anterior, hacemos un update, aunque en este caso creamos 2 Condition, una 
para el nombre duplicado y el otro para el NULL. */
DELIMITER //

DROP PROCEDURE IF EXISTS error_condition;

CREATE PROCEDURE error_condition (IN codigo INT, IN nuevo_nombre VARCHAR(50))
BEGIN
    DECLARE sql_error INT;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 sql_error = MYSQL_ERRNO;

        CASE sql_error
            WHEN 1062 THEN 
                SELECT 'Error: Nombre duplicado, el curso ya existe.' AS mensaje_error;
            WHEN 1048 THEN 
                SELECT 'Error: No puedes asignar un valor NULL al nombre del curso.' AS mensaje_error;
            ELSE 
                SELECT CONCAT('Error detectado: ', sql_error) AS mensaje_error;
        END CASE;
    END;

    -- Intento de actualizar el nombre del curso
    UPDATE cursos 
    SET nombre = nuevo_nombre 
    WHERE cod_curso = codigo;

    -- Mensaje de éxito si no hay errores
    SELECT 'Curso actualizado correctamente' AS mensaje_exito;
END //

DELIMITER ;
-- REPARAR ESTOS DOS ULTIMOS EJERCICOS --
