/*
C. ROLES
 1. Crear dos usuarios (‘Test1’@’%’, ‘Test2’@’%’)con la password de vuestra
 preferencia y comprobar que se han creado.
 2. Abrir una sesión en el terminal con el usuario Test1 e intentar entrar en la base
 de datos academia.
 3. Crear un rol llamado: testing
 4. Crear el privilegio para hacer SELECT sobre la tabla CURSOS y asignarlo al
 rol. Visualizar estos permisos.
 5. Asignar el rol a los usuarios creados.
 6. Activar los roles y comprobar si se puede acceder a la tabla cursos.
 7. Ver los roles existentes.
*/
CREATE USER 'Test1'@'%' identified by 'TEST1'; 
CREATE USER 'Test2'@'%' identified by 'TEST2'; 
-- 2 
-- 3
CREATE ROLE testing; 
-- 4
GRANT SELECT ON academia.cursos TO testing;
GRANT testing TO 'Test1'@'%';
SHOW GRANTS FOR testing;
/*
SELECT current_role();
+----------------+
| current_role() |
+----------------+
| NONE           |
+----------------+
1 row in set (0.01 sec)
*/
-- SABER SI EL ROLE ESTÁ ACTIVADO
-- 5 
GRANT testing TO 'Test2'@'%';
-- 6 
SET DEFAULT ROLE ALL TO 'Test1'@'%';
-- ACTIVAR ROLES
show GRANTS FOR 'Test1'@'%';
SELECT * FROM MYSQL.USER;
-- Cambia en las columnas 'authentication_string', (no hay clave de autentificación),
-- 'password_expired' (CLAVE HA EXPIRADO), 'password_lifetime'(NO TIENE CLAVE). 
-- Por las cuales se diferencian que es un rol y no un usuario como tal.

