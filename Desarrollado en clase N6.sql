SELECT *, concat(cast((VentaTotal/sumorderid)*100 as varchar(10)),'%') as Porcentaje 
FROM (SELECT orderid, productid, unitprice,qty,unitprice*qty as VentaTotal,
	sum(unitprice*qty ) OVER (partition by orderid) as sumorderid
FROM Sales.OrderDetails) as A 
