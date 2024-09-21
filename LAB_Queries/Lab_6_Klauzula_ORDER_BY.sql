use AdventureWorks2016
go

--z1
-- Wyœwietl wszystkie informacje z tabeli HumanResources.Employee. Uporz¹dkuj dane w kolejnoœci wg daty urodzenia (BirthDay) rosn¹co
select *
from HumanResources.Employee as hre
order by hre.BirthDate

--z2
-- Zmieñ kolejnoœæ na malej¹c¹
select *
from HumanResources.Employee as hre
order by hre.BirthDate desc

--z3
--Wylicz w zapytaniu wiek (od roku z daty dzisiejszej odejmij rok z daty urodzenia). Zaaliasuj kolumnê jako Age. Posortuj dane wg tej kolumny malej¹co
select *, year(GETDATE()) - YEAR(hre.BirthDate) as Age 
from HumanResources.Employee as hre
order by Age desc

--z4
--Z tabeli Production.Product wyœwietl ProductId, Name, ListPrice, Class, Style i Color. Uporz¹dkuj dane wg class i style
select 
	p_prod.ProductID
	, p_prod.Name
	, p_prod.ListPrice
	, p_prod.Class
	, p_prod.Style
	, p_prod.Color
from Production.Product p_prod
order by p_prod.Class
go

select 
	p_prod.ProductID
	, p_prod.Name
	, p_prod.ListPrice
	, p_prod.Class
	, p_prod.Style
	, p_prod.Color
from Production.Product p_prod
order by p_prod.Class, p_prod.Style
go

--z5
--Zmieñ poprzednie polecenie tak, aby sortowanie odbywa³o siê w oparciu o numer kolumny, a nie nazwê (pamiêtaj - to jest niezalecane rozwi¹zanie, ale warto je znaæ!)
select 
	p_prod.ProductID
	, p_prod.Name
	, p_prod.ListPrice
	, p_prod.Class
	, p_prod.Style
	, p_prod.Color
from Production.Product p_prod
order by 4, 5
go


