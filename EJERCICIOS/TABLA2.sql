CREATE SCHEMA empresa;
USE empresa;

CREATE TABLE FABRICANTES (
    Codigo INT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL
);

INSERT INTO FABRICANTES (Codigo, Nombre) VALUES
(1, 'Fabricante 1'),
(2, 'Fabricante 2'),
(3, 'Fabricante 3'),
(4, 'Fabricante 4'),
(5, 'Fabricante 5'),
(6, 'Fabricante 6'),
(7, 'Fabricante 7'),
(8, 'Fabricante 8'),
(9, 'Fabricante 9'),
(10, 'Fabricante 10'),
(11, 'Fabricante 11'),
(12, 'Fabricante 12'),
(13, 'Fabricante 13'),
(14, 'Fabricante 14'),
(15, 'Fabricante 15');


CREATE TABLE ARTICULOS (
    Codigo INT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL,
    Fabricante INT,
    FOREIGN KEY (Fabricante) REFERENCES FABRICANTES(Codigo)
);

INSERT INTO ARTICULOS (Codigo, Nombre, Precio, Fabricante) VALUES
(101, 'Articulo 1', 19.99, 1),
(102, 'Articulo 2', 29.99, 2),
(103, 'Articulo 3', 39.99, 3),
(104, 'Articulo 4', 49.99, 4),
(105, 'Articulo 5', 59.99, 5),
(106, 'Articulo 6', 69.99, 6),
(107, 'Articulo 7', 79.99, 7),
(108, 'Articulo 8', 89.99, 8),
(109, 'Articulo 9', 99.99, 9),
(110, 'Articulo 10', 109.99, 10),
(111, 'Articulo 11', 119.99, 11),
(112, 'Articulo 12', 129.99, 12),
(113, 'Articulo 13', 139.99, 13),
(114, 'Articulo 14', 149.99, 14),
(115, 'Articulo 15', 159.99, 15);
INSERT INTO ARTICULOS (Codigo, Nombre, Precio, Fabricante) VALUES
(116, 'Articulo 16', 169.99, 1),
(117, 'Articulo 17', 179.99, 2),
(118, 'Articulo 18', 189.99, 3),
(119, 'Articulo 19', 199.99, 4),
(120, 'Articulo 20', 209.99, 5),
(121, 'Articulo 21', 219.99, 6),
(122, 'Articulo 22', 229.99, 7),
(123, 'Articulo 23', 239.99, 8),
(124, 'Articulo 24', 249.99, 9),
(125, 'Articulo 25', 259.99, 10),
(126, 'Articulo 26', 269.99, 11),
(127, 'Articulo 27', 279.99, 12),
(128, 'Articulo 28', 289.99, 13),
(129, 'Articulo 29', 299.99, 14),
(130, 'Articulo 30', 309.99, 15);

CREATE TABLE DEPARTAMENTOS (
    Codigo INT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL
);
INSERT INTO DEPARTAMENTOS (Codigo, Nombre) VALUES
(1, 'Recursos Humanos'),
(2, 'Ventas'),
(3, 'Marketing'),
(4, 'Desarrollo de Software'),
(5, 'Finanzas'),
(6, 'Operaciones'),
(7, 'Soporte Técnico');

INSERT INTO DEPARTAMENTOS (Codigo, Nombre) VALUES
(8, 'Logística'),
(9, 'Diseño');


CREATE TABLE EMPLEADOS (
    Codigo INT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Apellido VARCHAR(255) NOT NULL,
    Nivel INT ,
    Departamento INT
);

-- Departamento 1
INSERT INTO EMPLEADOS (Codigo, Nombre, Apellido, Nivel, Departamento) VALUES
(1001, 'Juan', 'Gomez', 1, 1),
(1002, 'Ana', 'Perez', 2, 1),
(1003, 'Carlos', 'Lopez', 2, 1),
(1004, 'Laura', 'Rodriguez', 3, 1);

-- Departamento 2
INSERT INTO EMPLEADOS (Codigo, Nombre, Apellido, Nivel, Departamento) VALUES
(2001, 'Miguel', 'Fernandez', 1, 2),
(2002, 'Elena', 'Sanchez', 2, 2),
(2003, 'Pedro', 'Martinez', 3, 2),
(2004, 'Carmen', 'Garcia', 1, 2);

-- Departamento 3
INSERT INTO EMPLEADOS (Codigo, Nombre, Apellido, Nivel, Departamento) VALUES
(3001, 'Diego', 'Hernandez', 1, 3),
(3002, 'Isabel', 'Diaz', 2, 3),
(3003, 'Sergio', 'Jimenez', 3, 3),
(3004, 'Monica', 'Alvarez', 1, 3);

-- Departamento 4
INSERT INTO EMPLEADOS (Codigo, Nombre, Apellido, Nivel, Departamento) VALUES
(4001, 'Luis', 'Romero', 1, 4),
(4002, 'Patricia', 'Navarro', 2, 4),
(4003, 'Javier', 'Ortega', 3, 4),
(4004, 'Rosa', 'Flores', 1, 4);

-- Departamento 5
INSERT INTO EMPLEADOS (Codigo, Nombre, Apellido, Nivel, Departamento) VALUES
(5001, 'Jorge', 'Chavez', 1, 5),
(5002, 'Vanessa', 'Ramos', 2, 5),
(5003, 'Roberto', 'Gonzalez', 3, 5),
(5004, 'María', 'Martínez', 1, 5);

-- Departamento 6
INSERT INTO EMPLEADOS (Codigo, Nombre, Apellido, Nivel, Departamento) VALUES
(6001, 'Gustavo', 'Ruiz', 1, 6),
(6002, 'Cecilia', 'Herrera', 2, 6),
(6003, 'Andres', 'Sánchez', 3, 6),
(6004, 'Elena', 'Molina', 1, 6);

-- Departamento 7
INSERT INTO EMPLEADOS (Codigo, Nombre, Apellido, Nivel, Departamento) VALUES
(7001, 'Ricardo', 'Vega', 1, 7),
(7002, 'Fabiola', 'Diaz', 2, 7),
(7003, 'Javier', 'Flores', 3, 7),
(7004, 'Alejandra', 'Ortiz', 1, 7);



INSERT INTO EMPLEADOS (Codigo, Nombre, Apellido, Nivel, Departamento) VALUES
(0001, 'Fernando', 'Díaz', 1, 0),
(0002, 'Alberto', 'Perez', 1, 0),
(0003, 'Lucía', 'Vázquez', 1, 0);