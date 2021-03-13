-- INICIO DEL CURSO DE SQL SERVER --

-- Para leer una tabla:
select * from Sales.Customers -- Tabla de Clientes
select * from Production.Products -- Tabla de Productos

-- Leer algunos campos de la tabla Clientes:
select custid, companyname, contactname, city, country 
from Sales.Customers

-- Existen 6 cláusulas de base de datos:
------------------------------------------
-- SELECT		-> seleccionar campos de una tabla
-- FROM			-> apuntar a que tabla vamos a consultar
-- WHERE		-> filtrar campos de búsqueda
-- GROUP BY		-> agrupar datos
-- HAVING		-> filtrar campos de (funciones de agregación)
-- ORDER BY		-> ordenar los datos

-- OJO: Para texto en filtros usar -> ' ' y para números (van solos) ejm -> 7,8,9

-- Leer todos los clientes que son de Mexico:
select custid, companyname, contactname, contacttitle, city, country, phone
from Sales.Customers
where country = 'Mexico'

-- Leer los datos del cliente con código(custid) => 17
select custid, companyname, contactname, contacttitle, city, country, phone
from Sales.Customers
where custid = 17

-- Leer todos los clientes que son de Mexico, España y USA:
select * from Sales.Customers
where country in ('Mexico','Spain','USA') --se utiliza in para filtrar 2 o más valores.

-- Leer todos los clientes del custid del 1 al 10:
select * from Sales.Customers
where custid in (1,2,3,4,5,6,7,8,9,10)

-- Leer todos los clientes del custid del 20 al 50:
select * from Sales.Customers
where custid between 20 and 50

-- Leer todos los clientes del 20 al 50 y 
-- traer solo a los que son del país de France, Spain, Brazil
select * from Sales.Customers
where custid between 20 and 50 and country in ('France','Spain','Brazil')

-- Leer todos los clientes que son del 35 al 80
select * from Sales.Customers
where custid >= 35 and custid <=80 ---> para evitar el doble filtro utilizar el between

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
---- DML -> select, insert, update, delete
---- DDL -> create, alter, drop

--- Para los ejemplos crearemos nuestro propio esquema de BD: 
create schema Test -- Creamos el schema de BD llamado Test.

-- Tipos de Datos:
-- Texto -> varchar(50) "caracteres no definidos" , char(8) "caracteres definidos"
-- Números -> int "Número entero", decimal(18,5)
-- Fecha -> date, datetime, smalldatetime

-- OJO:
--> ejemplo dni 04678944 en texto -> llegará así -> 4678944 en número

-- Creando nuestra primera tabla - Alumnos:
create table Test.Alumnos
	(
		IdAlumno int,
		Nombres varchar(50),
		Edad int,
		MesCumpleaños varchar(15)
	)

select * from Test.Alumnos

--- Insertar registros a nuestra tabla de Test.Alumnos:
insert into Test.Alumnos values (1, 'Victor Custodio', 24, 'Febrero')
insert into Test.Alumnos values (2, 'Joaquín Silva', 25, 'Marzo')
insert into Test.Alumnos values (3, 'Daniel Huayta', 26, 'Abril')
insert into Test.Alumnos values (4, 'Jhon Cochachi', 27, 'Mayo')
insert into Test.Alumnos values (5, 'José Laurente', 28, 'Junio')
insert into Test.Alumnos values (6, 'Yohan Yangales', 29, 'Julio')

--- Actualizar la edad de José Laurente ---> 30 años
update Test.Alumnos set Edad=30
where IdAlumno=5

--- Eliminar a José Laurente 
delete from Test.Alumnos
where IdAlumno=5

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Uso del Like:
select * from Sales.Customers
where contactname like 'a%' --- empiecen con "A"

select * from Sales.Customers
where contactname like '%na' --- termine con "na"

select * from Sales.Customers
where contactname like '%on%' --- contenga la palabra "on"

select * from Sales.Customers
where contactname not like '%on%' --- no contenga la palabra "on"

--- USAMOS COMODINES =)
select * from Sales.Customers
where contactname like '_a_a%' --- empiecen con "A" en la segunda y cuarta letra

------------------------------------------------------------------------------
-- Uso de Operadores Matemáticos:
select (5+5*5/5)-1
select sum(Edad) from Test.Alumnos ---> funciones de agregación lo veremos la sgte clase.

-- Uso del Concat:
select concat('Hola',' - ','Cómo estás?')

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
--- Funciones Condicionales:
select iif((5+5) > 9, 'TRUE', 'FALSE')

-- Para colocar alias o sobrenombres a los campos:
select	custid as Codigo, 
		companyname as Compañia,
		contactname as NombreContacto, 
		city as Ciudad, 
		country as País,
		iif(country='Mexico','EN ONDA','NADA') as CampoNuevo
from Sales.Customers

------------------------------------------------------------------------------------------
--- SEGMENTACIÓN DE CLIENTES:

-- EJEMPLOS:
-------------
--- TARJETA CLASICA:
---		Hombre, entre 20 y 25 años, soltero, 930 soles
--- TARJETA PLATINUM
--- TARJETA BLACK
---		Hombre, entre 20 y 25 años, soltero, 2000 a 3000 soles

-- SEGMENTOS
-------------
--- CLIENTE PLATINUM:
	--- country in (UK,Germany,France) ; contacttitle like '%Manager%'
--- CLIENTE VIP:
	--- country in (USA,Spain,Brazil) ; contacttitle like '%Sales%'
--- CLIENTE CLASICO:
	--- los que nos cumplan las reglas de arriba :)

select	custid, contactname, contacttitle, city, country,
		case when country in ('UK','Germany','France') and contacttitle like '%Manager%'
				then 'CLIENTE PLATINUM'
			 when country in ('USA','Spain','Brazil') and contacttitle like '%Sales%'
				then 'CLIENTE VIP'
			 else 'CLIENTE CLASICO'
		end as Segmento_Cliente
from Sales.Customers

--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--- Dar Permisos de Administrador al usuario SA a nuestra BD TSQL =)
Alter authorization on database::TSQL to sa

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
--- CREANDO NUESTRO MODELO DE MATRICULA:
-- Automaticamente se crean los campos para que acepten nulos
create table Test.Alumnos
	(
		IdAlumno int,
		Nombres varchar(50),
		Edad int,
		MesCumpleaños varchar(15)
	)

select * from Test.Alumnos

--- Cambiaremos la estructura de la tabla:
-------------------------------------------------
--- Cambiar el IdAlumno para que no acepte nulos:
alter table Test.Alumnos 
alter column IdAlumno int not null

------------------------------------------------
-- Cambiar el IdAlumno como llave primaria:
alter table Test.Alumnos 
add primary key (IdAlumno)

-- LLAVES: 
-- Llaves Primarias (PK) -> Llave principal de la tabla y son únicas
-- Llaves Foraneas (FK)

create table Test.Profesor 
	(	IdProfesor int primary key, 
		Nombres varchar(50)	)

insert into Test.Profesor values (1,'Carlos Reyes')
insert into Test.Profesor values (2,'Mario Reyes')

select * from Test.Profesor

create table Test.Asignatura 
	(	IdAsignatura int primary key, 
		Nombre varchar(50)	)

insert into Test.Asignatura values (1,'SQL SERVER')
insert into Test.Asignatura values (2,'POWER BI')

select * from Test.Asignatura

create table Test.Matricula 
(
IdMatricula int primary key,
IdAlumno int,
IdProfesor int,
IdAsignatura int,
Fecha date,
constraint FK_Alumno foreign key (IdAlumno) references Test.Alumnos(IdAlumno),
constraint FK_Profesor foreign key (IdProfesor) references Test.Profesor(IdProfesor),
constraint FK_Asignatura foreign key (IdAsignatura) references Test.Asignatura(IdAsignatura)
)

---------------------------------------------------------
---- Con esto hemos cambiado de fecha a fecha y hora :D
alter table Test.Matricula 
alter column Fecha datetime
---------------------------------------------------------

insert into Test.Matricula values (1,4,1,1,GETDATE())
insert into Test.Matricula values (2,2,2,2,GETDATE())
insert into Test.Matricula values (3,4,2,1,GETDATE())

select * from Test.Matricula