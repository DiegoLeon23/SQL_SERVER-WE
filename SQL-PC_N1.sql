----MI SOLUCION 
SELECT  O.custid,
		O.orderid as orderID, 
		SUM(OD.unitprice*OD.qty) as VentaTotal
FROM Sales.OrderDetails OD INNER JOIN Sales.Orders O ON(OD.orderid=O.orderid)
GROUP BY O.custid, O.orderid
HAVING SUM(OD.unitprice*OD.qty) in (
				SELECT 	
					MAX(Tablon.VentaTotal) as [VentaTotal] 
				FROM 
					(SELECT O.custid as custID, O.orderid as orderID, SUM(OD.unitprice*OD.qty) as VentaTotal
					FROM Sales.OrderDetails OD INNER JOIN Sales.Orders O ON(OD.orderid=O.orderid)  
					GROUP BY O.custid, O.orderid) as Tablon
				GROUP BY Tablon.custID) 
ORDER BY custid

---SOLUCION OPTIMA
SELECT Tabla.custid,Tabla.orderid,Tabla.VentaTotal FROM (
SELECT	 O.custid custid, 
		O.orderid orderid,
		 SUM(OD.unitprice*OD.qty) as VentaTotal,
		 Rank () OVER (
						partition by o.custid order by SUM(OD.unitprice*OD.qty) desc) as RankingTotal
FROM Sales.OrderDetails OD INNER JOIN Sales.Orders O ON(OD.orderid=O.orderid)  
GROUP BY O.custid, O.orderid) as Tabla
WHERE RankingTotal=1


