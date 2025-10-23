/*
 PROCEDIMIENTOS
 Dentro de la base de datos academia:
 1. Crea un procedimiento llamado “cursos_asignaturas”para visualizar los cursos y sus
 asignaturas respectivamente. Ordénalo por cursos.
 2. Crea un procedimiento llamado “actualizar_precio”, que reciba como parámetro el
 código del curso y el precio que se le va a asignar a ese curso. Se debe controlar
 que el precio sea mayor que 100. Si no se cumple, se fija el precio a 100.
 3. Crea un procedimiento llamado “profesores_cursos” para visualizar los cursos de
 cada profesor. Debe recibir un parámetro que sea el nombre del profesor para ver
 las asignaturas.
 4. Crea un procedimiento llamado “nombre_completo” que devuelva una SELECT con
 el nombre y el apellido de un alumno. Debe recibir el parámetro de entrada del
 código del alumno.
 5. Modificar el procedimiento anterior (crea uno nuevo con otro nombre) para que el
 resultado se almacene en una variable de tipo OUT. Para ver que ha funcionado,
 visualiza la variable.
 6. Crea un procedimiento llamado “devolver_mayus” con un argumento de tipo INOUT.
 El parámetro debe ser una cadena de texto que se devuelva en mayúsculas.
 7. Crea un procedimiento llamado “devolver_datos” que reciba como parámetro de
 entrada el código del curso, y que devuelva en dos variables de tipo OUT el nombre
 y el precio. Visualiza el resultado para ver que ha salido correctamente
*/
-- 1 EJERCICIO
USE academia;
DELIMITER //
DROP PROCEDURE IF exists cursos_asignaturas;
	CREATE PROCEDURE cursos_asignaturas()
    BEGIN
    SELECT cod_curso, count(nombre) AS numero_cursos FROM asignaturas
    GROUP BY cod_curso;
    END //
DELIMITER ; 
CALL cursos_asignaturas();

-- 2 EJERCICIO
DELIMITER //

DROP PROCEDURE IF EXISTS actualizar_precios;
CREATE PROCEDURE actualizar_precios(IN codigo INT, IN precio_curso INT)
BEGIN
	IF precio_curso < 100 THEN
    SET precio_curso = 100;
    END IF;
    UPDATE academia.cursos
    SET precio = precio_curso
    WHERE cod_curso = codigo;
END //

DELIMITER ;
SELECT * FROM academia.cursos; 

CALL actualizar_precios(1, 190);
-- 3
DELIMITER //
DROP PROCEDURE IF EXISTS profesores_cursos;
CREATE PROCEDURE profesores_cursos(IN nombre_profesor VARCHAR(50))
	BEGIN 
		select asignaturas.nombre, profesores.nombre FROM asignaturas 
		INNER JOIN profesores ON asignaturas.cod_profesor = profesores.cod_profesor
        WHERE profesores.nombre = nombre_profesor;
	END //
DELIMITER ;
SELECT nombre FROM profesores;
CALL profesores_cursos('Dreddy');
-- 4 
DELIMITER // 
DROP PROCEDURE IF EXISTS nombre_completo;
CREATE PROCEDURE nombre_completo(IN nombre_alumno VARCHAR(50))
BEGIN
SELECT concat(nombre, ' ', apellidos) AS nombre_apellidos FROM alumnos
WHERE nombre = nombre_alumno;
END //
DELIMITER ;
SELECT nombre FROM alumnos;
CALL nombre_completo('Alli');
-- 5
SET @nombre = '';
DELIMITER // 
DROP PROCEDURE IF EXISTS nombre_completo;
CREATE PROCEDURE nombre_completo(IN nombre_alumno VARCHAR(50), OUT n_a VARCHAR(100))
BEGIN
SELECT concat(nombre, ' ', apellidos) AS nombre_apellidos INTO n_a FROM alumnos
WHERE nombre = nombre_alumno;
END //
DELIMITER ;
CALL nombre_completo('Alli', @nombre);
SELECT @nombre;
-- 6
SET @texto_min = 'hola me llamo juan';
DELIMITER //
DROP PROCEDURE IF EXISTS devolver_mayus;
CREATE PROCEDURE devolver_mayus(INOUT texto VARCHAR (255))
BEGIN
	SET texto = upper(texto) ;
END //
DELIMITER ; 
CALL devolver_mayus(@texto_min);
SELECT @texto_min;
-- 7 
SET @curso_nombre = '';
SET @precio_curso = '';
DELIMITER //
DROP PROCEDURE IF EXISTS devolver_datos;
CREATE PROCEDURE devolver_datos(IN codigo int, OUT nombre_curso VARCHAR(50), OUT precio_curso INT)
BEGIN 
	SELECT nombre, precio INTO nombre_curso, precio_curso FROM cursos
	WHERE cod_curso = codigo;
END //
DELIMITER ;
CALL devolver_datos(4, @curso_nombre, @precio_curso);
SELECT @curso_nombre, @precio_curso;

