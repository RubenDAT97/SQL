USE academia;
-- 1. Crea una vista llamada ‘cursos_precio_alto’ con los cursos cuyo precio sea
 -- superior a 150
 CREATE VIEW cursos_precio_alto AS select * from cursos WHERE precio > 150;
 SELECT * FROM cursos_precio_alto;
 -- 2. Crea una vista llamada ‘cursos_alumno’ que tengan las columnas nombre del
 -- curso y nombre del alumno. Tiene que aparecer el alumno y sus cursos
 CREATE VIEW cursos_alumno (CURSO, NOMBRE_ALUMNO) AS 
 SELECT alumnos.nombre, cursos.nombre FROM alumnos INNER JOIN cursos
 ON alumnos.cod_curso = cursos.cod_curso;
 select * from alumnos;
 select * from cursos;
 SELECT * FROM asignaturas;
 SELECT * FROM cursos_alumno;
 /*3. Crea una vista llamada ‘asignaturas_curso’ en la que aparezcan los cursos con
 las asignaturas que tienen. En este caso las columnas se llamarán
 “Asignatura” y “curso”. Los nombres de las columnas deben ser creadas en la
 declaración de la vista. También debe estar ordenado por el nombre del curso.*/
 CREATE VIEW asisgnaturas_curso (cursos, asignaturas) AS 
 SELECT asignaturas.nombre, cursos.nombre FROM asignaturas INNER JOIN cursos ON
 asignaturas.cod_curso = cursos.cod_curso
 ORDER BY cursos.nombre;
 SELECT * FROM asignaturas_curso;
 RENAME TABLE asisgnaturas_curso TO asignaturas_curso;
 -- 4. Intenta insertar un nuevo curso a través de la vista ‘cursos_precio_alto’
 INSERT INTO cursos_precio_alto VALUES(11, 'CURSO2', 250);
 -- 5. Intenta hacer lo mismo con ‘asignaturas_curso’
 INSERT INTO asignaturas_curso values('filosofia', 'CURSO11');
 -- 6. ¿Ysi le ponemos todas las columnas de las tablas asignaturas y cursos?
 -- 7. Vamosahora a probar el Check Option. Vamos a insertar una fila en la vista
 -- “cursos_precio_alto” que sea de un curso que no cumpla la condición (precio > 150) ¿funciona?
 INSERT INTO cursos_precio_alto VALUES(12, 'CURSO7', 50);
 -- 8. Introduce un check option ahora
 CREATE OR REPLACE VIEW cursos_precio_alto AS select * from cursos WHERE precio > 150
 WITH CHECK OPTION;
 -- 9. Intenta insertar una fila que no cumpla las condiciones
  INSERT INTO cursos_precio_alto VALUES(13, 'CURSO13', 175);
  SELECT * FROM cursos_precio_alto;
