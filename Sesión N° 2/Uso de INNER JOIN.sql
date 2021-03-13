---RESUMEN CLASE 1 WE CONSULTING

SELECT  custid as CodigoCliente,
		companyname as NombreEmpresa,
		contactname as NombreContacto,
		country as Pais,
		city as Ciudad,
		phone as Celular
FROM Sales.Customers
WHERE country in ('Mexico','USA')

CREATE TABLE Test(
id int,
dni char(8),
nombre varchar(30)
)
SELECT   * FROM Test
INSERT INTO Test VALUES(1,'72179861','Diego Leon')
INSERT INTO Test VALUES(2,'72179862','Angie Leon')
UPDATE Test set nombre='DiegoLO' WHERE id=1
DELETE FROM Test WHERE dni='72179862' 

SELECT P.productid, 
	P.productname,
	P.categoryid, 
	P.categoryid, 
	P.unitprice, 
	c.categoryname from Production.Products AS P
INNER JOIN Production.Categories AS C 
ON P.categoryid=C.categoryid


select top 5 * from Sales.Orders

select top 5 * from Sales.Customers

SELECT  orderid,
		orderdate,
		O.custid, 
		C.contactname 
FROM Sales.Orders AS O INNER JOIN Sales.Customers AS C
ON  O.custid=C.custid