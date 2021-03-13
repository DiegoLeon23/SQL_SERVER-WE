SELECT * FROM Sales.Orders WHERE year(orderdate) in (2008,2007) --and month(orderdate)=3 and day(orderdate)=6


SELECT empid, COUNT(orderid) as CantidadOrdenes FROM Sales.Orders 
WHERE year(orderdate) in (2008,2007)
GROUP BY (empid) 
HAVING COUNT(orderid)>80


SELECT O.empid as [Codigo Empleado],CONCAT(E.lastname ,' ',E.firstname) AS [Nombre Completo], COUNT(O.orderid) as [Cantidad Ordenes] ,
	case when COUNT(O.orderid)<90
		   then 'NO ok'
		when COUNT(O.orderid)between 90 and 110
			then 'OK'
		else 'XDD'
	end as Segmento
FROM Sales.Orders as O 
	INNER JOIN HR.Employees as E ON O.empid=E.empid 
WHERE year(O.orderdate) in (2007,2008)
GROUP BY O.empid,E.lastname,E.firstname
HAVING COUNT(O.orderid)>20
ORDER BY 2 desc

----VISTAAAAS (no permiten la clausuia order by)

CREATE VIEW vw_miprimeravista
AS 
	SELECT  O.empid as [Codigo Empleado],
			CONCAT(E.lastname ,' ',E.firstname) AS [Nombre Completo], 
			COUNT(O.orderid) as [Cantidad Ordenes],
			case when COUNT(O.orderid)<90
				   then 'NO ok'
				when COUNT(O.orderid)between 90 and 110
					then 'OK'
				else 'XDD'
			end as Segmento
	FROM Sales.Orders as O 
		INNER JOIN HR.Employees as E ON O.empid=E.empid 
	WHERE year(O.orderdate) in (2007,2008)
	GROUP BY O.empid,E.lastname,E.firstname
	HAVING COUNT(O.orderid)>20

--------------------------------------------------------------------------
--USO DE LAS VISTAS
select * from vw_miprimeravista ---para visualizar las vistas (no permite delete , update, insert, si modificas la tabla original, automaticamente la vista se actualiza)

---Uso de tablas derivadaaaas (TAMPOCO ESTA PERMITIDO EL ORDER BY )

SELECT * FROM 
(SELECT empid as CodigoEmp, COUNT(orderid) as CantidadOrdenes 
FROM Sales.Orders 
WHERE year(orderdate) in (2008,2007)
GROUP BY (empid) 
HAVING COUNT(orderid)>80
) as Tablon 
WHERE CodigoEmp=4


---------- USO DE CTE's (se le coloca el punto y coma adelante porque sino no se puede ejecutar a la vez con alguna consulta que este por encima de ellos)

;WITH cte_tabla1 as 
	(select * from Sales.Customers Where custid between 10 and 50),
	cte_tabla2 as
	(select * from Production.Products WHERE categoryid in (5,6,7)),
	cte_tabla3 as
	(select * from Production.Categories WHERE categoryid in (5,6,7))


select a.*, b.categoryname from cte_tabla2 as a  inner join cte_tabla3 as b on a.categoryid=b.categoryid  


---UNION VS UNION ALL

select country,city,region from Sales.Customers
UNION ALL--se encarga de quedarse con TODO!! --(admite valores repetidos)
select country,city, region from HR.Employees

select country,city,region from Sales.Customers
UNION --se encarga de quedarse con valores unicos --(no admite valores repetidos)
select country,city, region from HR.Employees


---USO DE VARIABLES !!!

declare @var1 int  ---declaramos nuestra variable 
set @var1=57		---seteamos el valor a nuestra variable 
select @var1		--- leemos nuestra variable 



SELECT * FROM Sales.OrderDetails

SELECT * FROM Sales.Orders