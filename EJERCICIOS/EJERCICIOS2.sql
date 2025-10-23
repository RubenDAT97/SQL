select * from conquerblocks.contabilidad;
-- 1. Obtener el importe total de ventas de cada departamento.
select departamento, sum(importe) AS 'IMPORTE TOTAL' from conquerblocks.contabilidad group by departamento;
-- 2. Obtener el importe total de gastos de cada departamento.
SELECT departamento, sum(importe) from conquerblocks.contabilidad
 where departamento LIKE ('Gastos%') 
 group by departamento;
-- 3. Obtener el número de registros de cada tipo de cuenta contable.
select * from conquerblocks.contabilidad;
select cuenta_contable, count(departamento) from conquerblocks.contabilidad
group by cuenta_contable;
-- 4. Obtener el importe total de ventas de cada mes.
select sum(importe) as 'Total ventas', monthname(fecha) as 'Mes' from conquerblocks.contabilidad
 group by monthname(fecha);
-- 5. Obtener el importe total de ventas de cada departamento y mes.
select departamento, sum(importe) as 'Total ventas', monthname(fecha) as 'Mes' from conquerblocks.contabilidad
 group by departamento, monthname(fecha);
-- 6. Obtener el número de registros de cada tipo de cuenta contable y mes.
select cuenta_contable, count(departamento) as 'Número de registros',  month(fecha) as 'Mes' from conquerblocks.contabilidad
 group by cuenta_contable, month(fecha);
-- 7. Obtener el importe total de ventas de cada departamento y mes, ordenado por importe de mayor a menor.
select departamento, sum(importe) as Total_Ventas, monthname(fecha) as 'Mes' from conquerblocks.contabilidad
 group by departamento, monthname(fecha)
 order by Total_Ventas DESC;
-- 8. Obtener el número de registros de cada tipo de cuenta contable y mes, ordenados por mes de mayor a menor
select cuenta_contable, count(departamento) as Numero_registros,  monthname(fecha) as 'Mes' from conquerblocks.contabilidad
 group by cuenta_contable, monthname(fecha)
 order by Numero_registros DESC;