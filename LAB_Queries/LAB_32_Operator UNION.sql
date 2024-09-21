use AdventureWorks2016
go

-- 1. Napisz zapytanie, które z tabeli Sales.SalesPerson oraz Person.Person wyœwietli: LastName, FirstName i sta³y napis Seller
-- Napisz zapytanie, które z tabeli HumanResources.Employee oraz Person.Person wyœwietli LastName, FIrstName oraz JobTitle
-- Po³¹cz wyniki tych dwóch zapytañ. Postaraj siê aby:
-- -alias ostatniej kolumny by³ "job"
-- wyniki by³y posortowane wg ostatniej kolumny
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

-- 2. Z tabeli HumanResources.Department  pobierz nazwê departamentu (Name) oraz sta³y napis "Department"
-- Z tabeli Sales.Store pobierz nazwê sklepu (Name) oraz sta³y napis 'Store'
-- Po³acz wyniki tych dwóch poleceñ. Zadbaj aby:
-- Kolumna prezentuj¹ca sta³e wartoœci by³a zaaliasowana jako "Location"
-- Sortowanie odbywa³o siê w oparciu o Name
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




