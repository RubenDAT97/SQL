/*
 Dentro de la base de datos academia:
 A. USUARIOS
 1. Conectarse desde el usuario root desde el terminal. Crear un usuario llamado
 “usu1” que pueda conectarse desde cualquier host. Comprobar después que
 el usuario se ha creado correctamente.
 2. Abrir una segunda sesión de mysql y conectarnos con el usuario recién
 creado.
 3. Crear un usuario llamado “usu2” sin ningún host asociado. Comprobar que se
 ha creado correctamente. ¿Qué host le ha puesto por defecto?
 4. Cambiar la password al usu1.
 5. Cambia de diferente forma la password al usu2.
 6. Borra el usu2.*/
 -- 1 
 CREATE USER 'usu1'@'%' identified by 'clave';
SELECT * FROM mysql.user;

-- 3 
 CREATE USER 'usu2'@'' identified by 'clave2';
 DROP USER 'usu2'@'%';
 -- 4
 SET password FOR 'usu1'@'%' = 'clave1';
 -- 5

-- 6 
DROP USER'usu2'@'';


-- SABER QUE USUARIOS ESTAN CONECTADOS 
SHOW processlist;
