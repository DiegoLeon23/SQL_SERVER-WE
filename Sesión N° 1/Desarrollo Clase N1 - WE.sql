--DML
-----------------------------------------
--SELECT: MOSTRAR DATOS O INFORMACION
--INSERT: REGISTRAR DATOS O INFORMACION
--UPDATE: MODIFICAR O ACTUALIZAR DATOS O INFORMACION
--DELETE: ELIMINAR DATOS O INFORMACION
-----------------------------------------
--SELECT
-----------------------------------------
SELECT * FROM Production.Categories

SELECT 
	CATEGORYID AS 'CODIGO CATEGORIA',
	CATEGORYNAME
FROM Production.Categories AS C

SELECT * FROM Production.Categories
WHERE categoryid = 4
-----------------------------------------
--INSERT
-----------------------------------------
INSERT INTO Production.Categories
VALUES('GASEOSAS','PEPSI')

INSERT INTO Production.Categories
(categoryname,description)
VALUES ('CHOCOLATES','TRIANGULO')
-----------------------------------------
--TIPOS DATOS
-----------------------------------------
--NUMERICOS
	--ENTEROS
	--DECIMALES
--TEXTOS
--FECHA Y TIEMPO
	--FECHA
	--TIEMPO
-----------------------------------------
--UPDATE
-----------------------------------------
UPDATE Production.Categories
set description='TRIANGULO'
WHERE categoryid = 11

SELECT * FROM Production.Categories

-----------------------------------------
--DELETE
-----------------------------------------
SELECT * FROM Libro1

DELETE FROM Libro1

SELECT * FROM Production.Categories

DELETE FROM Production.Categories
WHERE categoryid > 9 