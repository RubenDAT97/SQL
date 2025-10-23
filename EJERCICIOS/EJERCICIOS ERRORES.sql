USE academia;

/* 7. Hacer un procedimiento llamado “error_generico” que intente modificar la 
columna nombre de un curso, pasando el código y el nuevo nombre. Con una 
SQLEXCEPTION debemos controlar si hay algún error y luego pintar el número 
de error usando DIAGNOSTIC. Luego probamos con algún error, como por 
ejemplo pasándole un nulo al campo o un nombre duplicado, lo que sea. */
DROP PROCEDURE IF EXISTS error_generico;
DELIMITER //
CREATE PROCEDURE error_generico(p_codigo INT, p_nombre VARCHAR(50))
BEGIN
	DECLARE SQL_ERROR INT;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	GET DIAGNOSTICS CONDITION 1 SQL_ERROR = MYSQL_ERRNO;
        SELECT CONCAT('Error detectado: ', sql_error) AS mensaje_error;
	END;
	INSERT INTO CURSOS(cod_curso, nombre) VALUES (p_codigo, p_nombre);

END //
DELIMITER ; 


call error_generico(NULL, 'CURSO1');
SELECT * FROM CURSOS;


/* 8. Crear un procedimiento llamado “error_condition”. Usando el ejercicio 
anterior, hacemos un update, aunque en este caso creamos 2 Condition, una 
para el nombre duplicado y el otro para el NULL. */
DROP PROCEDURE IF EXISTS error_condition;
DELIMITER //
CREATE PROCEDURE error_condition(p_codigo INT, p_nombre VARCHAR(50))
BEGIN
	DECLARE SQL_ERROR INT;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
    
	GET DIAGNOSTICS CONDITION 1 SQL_ERROR = MYSQL_ERRNO;
	IF SQL_ERROR = 1048 THEN
	SELECT 'No puedes introducir un valor nulo';
	ELSEIF SQL_ERROR =  1062 THEN 
	SELECT 'NO PUEDES INTRODUCIR UN VALOR DUPLICADO';
	END IF;
	END;
	INSERT INTO CURSOS(cod_curso, nombre) VALUES (p_codigo, p_nombre);

END //
DELIMITER ; 



call error_condition(NULL, 'CURSO1');
