use AdventureWorks2016
go

--z1
-- Wy�wietl wszystkie informacje z tabeli HumanResources.Employee. Uporz�dkuj dane w kolejno�ci wg daty urodzenia (BirthDay) rosn�co
select *
from HumanResources.Employee as hre
order by hre.BirthDate

--z2
-- Zmie� kolejno�� na malej�c�
select *
from HumanResources.Employee as hre
order by hre.BirthDate desc

--z3
--Wylicz w zapytaniu wiek (od roku z daty dzisiejszej odejmij rok z daty urodzenia). Zaaliasuj kolumn� jako Age. Posortuj dane wg tej kolumny malej�co
select *, year(GETDATE()) - YEAR(hre.BirthDate) as Age 
from HumanResources.Employee as hre
order by Age desc

--z4
--Z tabeli Production.Product wy�wietl ProductId, Name, ListPrice, Class, Style i Color. Uporz�dkuj dane wg class i style
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
--Zmie� poprzednie polecenie tak, aby sortowanie odbywa�o si� w oparciu o numer kolumny, a nie nazw� (pami�taj - to jest niezalecane rozwi�zanie, ale warto je zna�!)
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


