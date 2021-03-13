---- RESUMEN DE LA SESIÓN N° 1 ----

SELECT custid, companyname, contactname, country, city, phone 
FROM Sales.Customers
WHERE country = 'Mexico'

SELECT custid, companyname, contactname, country, city, phone 
FROM Sales.Customers
WHERE country in ('Mexico','USA','Venezuela')

SELECT	custid as CodigoCliente, 
		companyname as NombreEmpresa, 
		contactname as NombreContacto, 
		country as País, 
		city as Ciudad, 
		phone as Celular
FROM Sales.Customers
WHERE custid > 17

SELECT custid, companyname, contactname, country, city, phone 
FROM Sales.Customers

---------------------------------------------------------------------
---------------------------------------------------------------------
-- Tipos de Datos: 
-- Número -> números enteros (int), números decimales (decimal(18,5))
-- Texto -> Texto variable (varchar(200)) , Texto fijo (char(8))
-- Fecha -> Date(17/10/2020), DateTime(17/10/2020 00:00:00:000)

create table Test
(
 id int,
 dni char(8),
 nombres_completos varchar(60)
)

-- DNI EN NUMEROS
-- 06787644 -> 6787644

-- DNI EN TEXTO FIJO
-- 06787644 -> 06787644

select * from Test

-- Insertar registros:
insert into Test values (1,'45665433','Carlos Reyes')
insert into Test values (2,'25665433','Miguel Juarez')

-- OJOOOO:
--- CONSULTAS A TENER MUCHO CUIDADO!!!!!
-- Modificar:
update Test set nombres_completos='Carlos Sanchez'
where dni='45665433'

-- Eliminar: 
delete from Test
where dni='45665433'

-- Te borras totalmente la tabla completa con todo y datos:
drop table Test
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------

--- SESIÓN N° 2 --- "JOINS"
---------------------------------------------------------------------

-- USO DEL TOP
select top 5 * from Production.Products
select top 5 * from Production.Categories

-- TRAEME LA INFORMACIÓN DE PRODUCTOS CON EL NOMBRE DE LA CATEGORÍA QUE CORRESPONDA.
-- PRODUCTID, PRODUCTNAME, UNITPRICE, CATEGORYID, "NOMBRE_CATEGORÍA_PROD"
select p.productid as CodigoProducto,
	   p.productname, p.unitprice, p.categoryid, c.categoryname
from Production.Products as P
inner join Production.Categories as C ON p.categoryid=c.categoryid

--------
select top 5 * from Sales.Orders
select top 5 * from Sales.Customers

-- Necesito información de las ordenes de venta: (Tabla: Sales.Orders)
-- Orderid, Orderdate, CustId
-- Tienes que agregarle el nombre del cliente (contactname -> Tabla: Sales.Customers)
-- +1pt -- Herny Ninapaitan, Teresa Flores, Diego Leon

select o.orderid, o.orderdate, o.custid, c.contactname
from Sales.Orders as o
inner join Sales.Customers as c ON o.custid=c.custid


select o.orderid, o.orderdate, o.custid, c.contactname, o.empid, e.lastname
from Sales.Orders as o
inner join Sales.Customers as c ON o.custid=c.custid
inner join HR.Employees as e on o.empid=e.empid



