CREATE schema op_conjuntos;
use op_conjuntos;
-- Crear la tabla TABLA1
CREATE TABLE TABLA1 (
    ID INT,
    TEXTO VARCHAR(255),
    TIPO VARCHAR(50)
);

-- Crear la tabla TABLA2 con la misma estructura que TABLA1
CREATE TABLE TABLA2 (
    ID INT,
    TEXTO VARCHAR(255),
    TIPO VARCHAR(50)
);

INSERT INTO TABLA1 (ID, TEXTO, TIPO) VALUES
(1, 'Texto1', 'Tipo1'),
(2, 'Texto2', 'Tipo2'),
(3, 'Texto3', 'Tipo3'),
(4, 'Texto4', 'Tipo4'),
(5, 'Texto5', 'Tipo5'),
(6, 'Texto6', 'Tipo6'),
(7, 'Texto7', 'Tipo7'),
(8, 'Texto8', 'Tipo8'),
(9, 'Texto9', 'Tipo9'),
(10, 'Texto10', 'Tipo10');

INSERT INTO TABLA2 (ID, TEXTO, TIPO) VALUES
(0, 'Texto0', 'Tipo0'),
(1, 'Texto01', 'Tipo1'),
(2, 'Texto02', 'Tipo2'),
(3, 'Texto3', 'Tipo3'),
(4, 'Texto4', 'Tipo4'),
(3, 'Texto3', 'Tipo3'),
(1, 'Texto4', 'Tipo4'),
(5, 'Texto5', 'Tipo5'),
(4, 'Texto4', 'Tipo4')
;