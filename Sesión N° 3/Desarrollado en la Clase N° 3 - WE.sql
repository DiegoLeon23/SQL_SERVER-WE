--- RESUMEN ---
SELECT * 
FROM Sales.Customers
WHERE country in ('Germany','USA')

--- Funciones de Agregación: ---
-- SUM -> SUMAR
-- MIN -> MÍNIMO
-- MAX -> MÁXIMO
-- AVG -> PROMEDIO
-- COUNT -> CONTAR

----- USO DE GROUP BY !!!---
-- Hallar la cantidad de Clientes que hay por Country!!!
select country, COUNT(custid) as ConteoClientes
from Sales.Customers
group by country

-- Hallar la cantidad de ordenes que hay por Cliente (CustID)
select custid, COUNT(orderid) as ConteoOrdenes 
from Sales.Orders
group by custid

-- Hallar la cantidad de productos que hay por Categoría (CategoryID)
select CategoryID, COUNT(productid) as ConteoProductos
from Production.Products
group by CategoryID

-- +1 Pt
-- Flavio Alvarado, Teresa Flores, Gino Chuquillanqui, Jimmy Nazario,
-- Abner Llanos, Diego Vasquez, Daniel Davila, Jose Torres

---------
-- Hallar la cantidad de productos únicos que hay por Orden
-- Tabla: Sales.OrderDetails
select orderid, COUNT(productid) as ConteoProductosUnicos
from Sales.OrderDetails
group by orderid

-- Hallar la cantidad de ordenes por empleado (empid)
-- Tabla: Sales.Orders
select empid, COUNT(orderid) as ConteoOrdenes
from Sales.Orders
group by empid

-- Uso del distinct -> Valores únicos
select COUNT(distinct orderid) as ConteoOrdenes
from Sales.OrderDetails

-- +1 Pt
-- Abner Llanos, Gino Chuquillanqui, Angel Otañe, Flavio Alvarado,
-- Julio Cordova, Sebastian villalobos, Karla Gamarra, Teresa FLores,
-- Diego Vasquez, Daniel Davila, Jose Torres, Jimmy Nazario, 
-- Liliana Yncarroca, Esther Gonzales

----
---- Uso del "LEFT JOIN" --- 

---- Hallar la cantidad de Ordenes que hay por todos los clientes (Contactname)
select * from Sales.Customers -- 91 rows
select * from Sales.Orders -- 830 rows

select c.contactname, COUNT(orderid) as ConteoOrdenes
from Sales.Customers as c
left join Sales.Orders as o on c.custid=o.custid
group by c.contactname
order by 2

-- +2 Pt
-- Teresa Flores, Abner Llanos, Flavio Alvarado, Julio Cesar, 
-- Gino Chuquillanqui, Daniel Davila, Jose Alexander, Henry Ninapaitan, 
-- Karla Gamarra


---- Hallar la cantidad de Ordenes que hay por todos los clientes (Contactname)
select * from Sales.Customers -- 91 rows
select * from Sales.Orders -- 830 rows

--- Solo quedate con los que tengan más de 15 ordenes

select c.contactname, COUNT(orderid) as ConteoOrdenes
from Sales.Customers as c
left join Sales.Orders as o on c.custid=o.custid
group by c.contactname
having COUNT(orderid) > 15
order by 2

select top 3 * from Sales.Customers
select top 3 * from Sales.Orders

-- Existen 6 cláusulas de base de datos:
------------------------------------------
-- SELECT		-> seleccionar campos de una tabla
-- FROM			-> apuntar a que tabla vamos a consultar
-- WHERE		-> filtrar campos de búsqueda
-- GROUP BY		-> agrupar datos
-- HAVING		-> filtrar campos de (funciones de agregación)
-- ORDER BY		-> ordenar los datos

----
select c.contactname, COUNT(orderid) as ConteoOrdenes
from Sales.Customers as c
left join Sales.Orders as o on c.custid=o.custid
group by c.contactname
having COUNT(orderid) > 15
order by 2
---

--- Hallar la cantidad de Productos que hay por Categoría (CategoryId)
--- Solo tomar las Categorías que tengan más de 6 productos
--- Tabla: Production.Products
--- Ordenarlo descendentemente por ConteoProductos

select categoryid, COUNT(productid) as ConteoProductos 
from Production.Products
group by categoryid
having COUNT(productid) > 6
order by 2 desc -- asc: ascendente y desc: descendente

-- Jimmy Nazario, Gino Chuquillanqui, Henry Ninapaitan, Teresa Flores,
-- Julio Cordova, Daniel Davila, Flavio Alvarado, Karla Gamarra, Jose Torres

--- Uso de Conversión de Datos:
-- Uso del CAST:

select cast(565.89 as int) -- 565
select cast(565.89 as decimal(18,1)) -- 565.9
select cast(565.89 as decimal(18,0)) -- 566
select cast('565.78' as decimal(18,2)) --565.78
select cast(546 as varchar(10)) --546
select cast(GETDATE() as date) --2020-12-27
select cast(GETDATE() as datetime) --2020-12-27 11:24:43.930
select cast(GETDATE() as smalldatetime) --2020-12-27 11:25:00
select cast(GETDATE() as varchar(20)) --Dec 27 2020 11:25AM

-- Función Redondeo (round)
select round(566.66,0)-- 567.00
select round(566.66,1)-- 566.70

--- Uso del Concat (Concatenar)
select CONCAT(custid, ' | ', contactname, ' - ', country)
from Sales.Customers

--- Funciones de TExto:
-- Substring
select substring('MICROSOFT SQL SERVER',6,4) --SOFT
select substring('MICROSOFT SQL SERVER',15,6) --SERVER

-- Left, right
select left('MICROSOFT SQL SERVER',9) --MICROSOFT
select right('MICROSOFT SQL SERVER',6) --SERVER
select left(right('MICROSOFT SQL SERVER',10),3) --SQL

-- Len
select len('MICROSOFT SQL SERVER') --20

-- Upper, Lower
select upper('MiCRosOfT SqL SeRveR') --MICROSOFT SQL SERVER
select lower('MiCRosOfT SqL SeRveR') --microsoft sql server

---------------------------------------------------------------------------
---------------------------------------------------------------------------
-- USO DEL CASE
-- SEGMENTACION DE CLIENTES:
--- CLIENTE PREMIUM -> Country in (USA, Germany) and contacttitle like '%Manager%'
--- CLIENTE VIP -> Country in (UK, Spain, France, Italy) and contacttitle like '%Sales%'
--- CLIENTE BASIC -> los que nos cumplan con las anteriores reglas.
select custid, contactname, contacttitle, country,
case when Country in ('USA', 'Germany') and contacttitle like '%Manager%'
				then 'CLIENTE PREMIUM'
			 when Country in ('UK', 'Spain', 'France', 'Italy') and contacttitle like '%Sales%'
				then 'CLIENTE VIP'
			else 'CLIENTE BASIC'
		end as Segmento_Clientes
from Sales.Customers

select Segmento_Clientes, COUNT(custid) as ConteoClientes
from 
(
	select custid, contactname, contacttitle, country,
			case when Country in ('USA', 'Germany') and contacttitle like '%Manager%'
					then 'CLIENTE PREMIUM'
				 when Country in ('UK', 'Spain', 'France', 'Italy') and contacttitle like '%Sales%'
					then 'CLIENTE VIP'
				else 'CLIENTE BASIC'
			end as Segmento_Clientes
	from Sales.Customers
) as Tablon
group by Segmento_Clientes