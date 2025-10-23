USE world;
/*
'usuario'@'host'
'usuario'@'143.168.1.100'
'usuario'@'%' --> Puede conectarse de cualquier host

CREATE USER usuario ODENTIFY by `password'

*/

CREATE USER 'usuario1'@'%' identified by 'password';

SELECT * FROM mysql.USER;

GRANT SELECT ON WORLD.COUNTRY TO 'usuario1'@'%'; -- Darle permisos para algo en específico
GRANT All ON WORLD.* TO 'usuario1'@'%'; -- Darle todos los permisos al usuario para realizar sobre una base

-- Cambiar contraseña de usuario

SET password FOR 'usuario1'@'%' = 'prueba1';