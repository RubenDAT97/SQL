/*B. PERMISOS
 1. Trabajamos con el usuario “usu1” que hemos creado en el apartado anterior y
 vamos a tener 2 sesiones abiertas, una como usuario de tipo root y el otro con
 el usuario “usu1”. Desde “usu1”, intentar leer la tabla cursos de la base de
 datos “academia”.
 2. Dar permisos de SELECT sobre la tabla al usu1. Comprobar que ahora puede
 hacer una SELECT.
 3. Intentar hacer un delete del curso12.
 4. Dar permisos para que lo pueda hacer.
 5. Dar permisos de SELECT sobre las columnas nombre y apellidos de la tabla
 ALUMNOSal usuario “usu1” . Comprobar que solo puede leer esas columnas.
 6. Comprobar los permisos que tiene usu1.
 7. Dar todos los permisos sobre la base de datos academia a “usu1”. Comprobar
 los permisos.
 8. Ahora, quitar solo el permiso de SELECT sobre la columna nombre de la tabla
 ALUMNOS. ¿Qué ocurre?*/
 -- 1
 -- 2 
 GRANT SELECT ON academia.cursos TO 'usu1'@'%';
 -- 3
 -- 4
 GRANT UPDATE, INSERT, DELETE ON academia.cursos TO 'usu1'@'%';
 -- 5 
 GRANT SELECT (nombre, apellidos) ON academia.alumnos
 TO 'usu1'@'%';
 -- 6
 -- 7
 GRANT ALL ON academia.* TO 'usu1'@'%';
 -- 8 
 REVOKE SELECT (nombre) ON academia.alumnos FROM 'usu1'@'%';
 -- SIGUE TENIENTO PERMISOS 
 
 
 
 