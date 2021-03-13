---CREACION TABLA Prueba2
CREATE table Prueba2 (
	custID int,
	año int,
	Conteo_Ord int,
	Suma_VentaTotal money
)
---FIN CREACION TABLA Prueba2

---CREACION DE STORE PROCEDURE
CREATE PROC SP_VentaCliente (@codigocliente int)
AS
BEGIN
	IF not EXISTS (SELECT custID FROM Prueba2 WHERE @codigocliente=custID) 
		INSERT INTO Prueba2 
		SELECT
			O.custid,
			YEAR(O.orderdate) as año,
			COUNT(O.orderid) as Conteo_Ordenes,
			SUM(OD.unitprice*OD.qty) as Suma_VentaTotal	 
		FROM Sales.Orders O INNER JOIN Sales.OrderDetails OD ON (O.orderid=OD.orderid)
		WHERE O.custid=@codigocliente 
		GROUP BY O.custid,YEAR(O.orderdate)
	SELECT * FROM Prueba2 ORDER BY 1
END
---FIN STORE PROCEDURE

---CONSULTA PARA INSERTAR EN LA TABLA CREADA
INSERT INTO Prueba2
SELECT 
	O.custid,
	YEAR(O.orderdate) as año,
	COUNT(O.orderid) as Conteo_Ordenes,
	SUM(OD.unitprice*OD.qty) as Suma_VentaTotal
	 
FROM Sales.Orders O INNER JOIN Sales.OrderDetails OD ON (O.orderid=OD.orderid)
WHERE O.custid=4 ---MODIFICAR PARA INSERTAR CON EL custID DESEADO
GROUP BY O.custid,YEAR(O.orderdate)
ORDER BY 1


DELETE FROM Prueba2 WHERE custID=3-- MODIFICAR EL VALOR 3 Y COLOCAR LA VARIABLE @custid

---FIN CONSULTA INSERTAR 


---ZONA PRUEBAS

EXEC SP_VentaCliente 6
SELECT * FROM Prueba2 ORDER BY 1

