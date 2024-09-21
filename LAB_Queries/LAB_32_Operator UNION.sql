use AdventureWorks2016
go

-- 1. Napisz zapytanie, kt�re z tabeli Sales.SalesPerson oraz Person.Person wy�wietli: LastName, FirstName i sta�y napis Seller
-- Napisz zapytanie, kt�re z tabeli HumanResources.Employee oraz Person.Person wy�wietli LastName, FIrstName oraz JobTitle
-- Po��cz wyniki tych dw�ch zapyta�. Postaraj si� aby:
-- -alias ostatniej kolumny by� "job"
-- wyniki by�y posortowane wg ostatniej kolumny
select
	pp.LastName
	,pp.FirstName
	,'Seller' as job
from Sales.SalesPerson as ssp
inner join Person.Person as pp on ssp.BusinessEntityID = pp.BusinessEntityID

union 

select 
	pp.LastName
	,pp.FirstName
	,HRe.JobTitle
from HumanResources.Employee as HRe 
inner join Person.Person as pp on HRe.BusinessEntityID = pp.BusinessEntityID
order by job

-- 2. Z tabeli HumanResources.Department  pobierz nazw� departamentu (Name) oraz sta�y napis "Department"
-- Z tabeli Sales.Store pobierz nazw� sklepu (Name) oraz sta�y napis 'Store'
-- Po�acz wyniki tych dw�ch polece�. Zadbaj aby:
-- Kolumna prezentuj�ca sta�e warto�ci by�a zaaliasowana jako "Location"
-- Sortowanie odbywa�o si� w oparciu o Name
select 
	HRd.Name
	,'Department' as Location
from HumanResources.Department as HRd
union
select 
	ss.Name
	,'Store'
from Sales.Store as ss
order by HRd.Name




