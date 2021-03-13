use TSQL
SELECT * FROM Production.Categories

SELECT  categoryid , categoryname  FROM Production.Categories WHERE categoryid BETWEEN 6 AND 9

INSERT INTO Production.Categories (categoryname,description) VALUES ('Fruta','Uva')

UPDATE Production.Categories 
set description = 'Sublime' WHERE categoryid=10

DELETE FROM Production.Categories WHERE categoryid=11