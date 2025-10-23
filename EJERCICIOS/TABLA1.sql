USE CONQUERBLOCKS; 
create TABLE CONTABILIDAD (
id INT auto_increment primary KEY,
fecha date,
concepto varchar(255),
importe decimal (10,2),
cuenta_contable varchar(255),
departamento varchar(255)
);

INSERT INTO contabilidad (fecha, concepto, importe, cuenta_contable, departamento) VALUES
('2023-07-20', 'Compra de mercadería', 10000.00, '4000', 'Ventas'),
('2023-07-21', 'Venta de mercadería', 20000.00, '4100', 'Ventas'),
('2023-07-22', 'Pago de sueldos', 5000.00, '4200', 'Gastos de personal'),
('2023-07-23', 'Pago de alquiler', 3000.00, '4300', 'Gastos generales'),
('2023-07-24', 'Pago de luz', 2000.00, '4400', 'Gastos generales'),
('2023-07-25', 'Pago de agua', 1000.00, '4400', 'Gastos generales'),
('2023-07-26', 'Recepción de préstamo', 100000.00, '1000', 'Activos financieros'),
('2023-07-27', 'Compra de equipo de cómputo', 50000.00, '2000', 'Activos fijos'),
('2023-07-28', 'Pago de intereses de préstamo', 5000.00, '6300', 'Gastos financieros'),
('2023-08-01', 'Compra de mercadería', 15000.00, '4000', 'Ventas'),
('2023-08-02', 'Venta de mercadería', 25000.00, '4100', 'Ventas'),
('2023-08-03', 'Pago de sueldos', 7500.00, '4200', 'Gastos de personal'),
('2023-08-04', 'Pago de alquiler', 4500.00, '4300', 'Gastos generales'),
('2023-08-05', 'Pago de luz', 3000.00, '4400', 'Gastos generales'),
('2023-08-06', 'Pago de agua', 1500.00, '4400', 'Gastos generales'),
('2023-08-07', 'Recepción de dividendos', 50000.00, '1000', 'Activos financieros'),
('2023-08-08', 'Compra de mobiliario', 25000.00, '2000', 'Activos fijos'),
('2023-08-09', 'Pago de intereses de préstamo', 2500.00, '6300', 'Gastos financieros');
