----Solucion primera PC
SELECT Tabla.custid,Tabla.orderid,Tabla.SumaTotal FROM 
	(SELECT O.custid custid,
			O.orderid orderid,
		   SUM(OD.unitprice*OD.qty) SumaTotal,
		   RANK () over (partition by O.custid order by SUM(OD.unitprice*OD.qty) desc) Ranking
	FROM Sales.OrderDetails OD INNER JOIN Sales.Orders O ON (O.orderid=OD.orderid)
	group by O.custid, O.orderid) as Tabla
WHERE Tabla.Ranking=1



---Hallar el ranking de productos segun su precio unitario
select *,
RANK () over ( partition by categoryid
				order by unitprice desc 
			 ) as RankByUnitPrice
from Production.Products


---RESUMEN PROCEDIMIENTO ALMACENADO PDF 
---Problema 1
	CREATE PROC Busqueda (@supplier int)
	AS
	BEGIN
		SELECT * FROM Production.Products WHERE supplierid=@supplier 
	END

	EXEC Busqueda 3
---Problema 2
	CREATE PROC RangoFecha (@fechain varchar(30),
							@fechafin varchar(30))
	AS
	BEGIN
		SELECT custid,COUNT(orderid) cantidad_ordenes FROM Sales.Orders WHERE orderdate between @fechain and @fechafin
		GROUP BY custid 
	END

	EXEC RangoFecha '2006-07-08' , '2006-10-18'

---Problema 3
	CREATE PROC BusquedaCustomers (@custid int)
	AS
	BEGIN
		SELECT custid,address,city,country FROM Sales.Customers WHERE custid=@custid 
	END

	EXEC BusquedaCustomers 3

---Problema 4
	CREATE PROC DatosEmpleado (@empid int)
	AS
	BEGIN
		SELECT 
			E.empid,
			lastname,
			lastname_jefe,
			title_jefe
			FROM
			(SELECT empid as empid,
					lastname as lastname_jefe,
					title as title_jefe
			FROM HR.Employees) as J
			INNER JOIN HR.Employees E ON (e.mgrid=j.empid)
		WHERE E.empid=@empid
	END

	EXEC DatosEmpleado 2

