---LEON ORTIZ DIEGO ENRIQUE
---PRUEBA FINAL SQL SERVER - WEConsulting


---CREACION TABLA ProyectoFinal
CREATE table ProyectoFinal (
	custID int,
	año int,
	Conteo_Ord int,
	Suma_VentaTotal money
)
---FIN CREACION TABLA ProyectoFinal

---CREACION DE STORE PROCEDURE
CREATE PROC SP_ProyectoFinal (@codigocliente int)
AS
BEGIN
	IF not EXISTS (SELECT custID FROM ProyectoFinal WHERE @codigocliente=custID) 
		INSERT INTO ProyectoFinal
		SELECT
			O.custid,
			YEAR(O.orderdate) as año,
			COUNT(O.orderid) as Conteo_Ordenes,
			SUM(OD.unitprice*OD.qty) as Suma_VentaTotal	 
		FROM Sales.Orders O INNER JOIN Sales.OrderDetails OD ON (O.orderid=OD.orderid)
		WHERE O.custid=@codigocliente 
		GROUP BY O.custid,YEAR(O.orderdate)
END
---FIN STORE PROCEDURE

---EJECUCION SP
EXEC SP_ProyectoFinal 2
SELECT * FROM ProyectoFinal ORDER BY 1

