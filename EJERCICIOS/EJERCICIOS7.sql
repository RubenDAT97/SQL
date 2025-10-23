USE academia;
select * from coches;
INSERT INTO COCHES (matricula,modelo,marca,precio,fecha_compra) VALUES('0000AAA', 'FIESTA','FORD', 9999, current_date());
INSERT INTO COCHES (matricula,modelo,marca,precio,fecha_compra) VALUES('1111BBB', 'FOCUS','FORD', 12000, curdate());

INSERT INTO COCHES VALUES('2222CCC', 'GT','FORD', 30000, curdate());

INSERT INTO COCHES (matricula,modelo,marca) VALUES('3333DDD', 'CMAX','FORD');

INSERT INTO COCHES (matricula,modelo) VALUES('1111BBB', 'FOCUS');

INSERT INTO COCHES (matricula,modelo,marca,precio,fecha_compra) VALUES('1111BBB', 'FOCUS','FORD', 12000, curdate()),
																		('5555EEEE', 'MONDEO', 'FORD', 14000, curdate());


CREATE TABLE `coches2` (
  `matricula` varchar(8) NOT NULL,
  `marca` varchar(45) NOT NULL,
  `modelo` varchar(45) NOT NULL,
  `precio` int DEFAULT NULL,
  `fecha_compra` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO coches2 select * FROM coches;
select * from coches2;
select * from coches;
SET SQL_SAFE_UPDATES = 0;
UPDATE coches SET precio = precio  + 100 WHERE precio >10000;
DELETE FROM coches WHERE modelo = 'FOCUS';

REPLACE into coches VALUES('0000AAB', 'CLIO', 'RENAULT', '6000', '2014-07-01');


-- --------------------------------------
