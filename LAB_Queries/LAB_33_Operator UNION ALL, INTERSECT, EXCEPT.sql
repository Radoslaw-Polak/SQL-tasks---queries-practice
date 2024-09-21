use AdventureWorks2016
go

-- 1. Napisz zapytanie, które z tabeli Person.Person wybierze LastName i FirstName. 
-- Napisz zapytanie, które z tabeli HumanResources.Employee i Person.Person wybierze LastName i FirstName pracowników
-- Po³¹cz oba w/w zapytania tak, aby jeœli dana osoba jest pracownikiem, pojawi³a sie w wyniku 2 razy
select
	pp.LastName
	,pp.FirstName
from Person.Person as pp
union all
select 
	pp.LastName
	,pp.FirstName
from HumanResources.Employee as HRe 
inner join Person.Person as pp on HRe.BusinessEntityID = pp.BusinessEntityID

-- 2. A teraz poka¿ te osoby z pierwszego zapytania, które NIE s¹ pracownikami.
select
	pp.LastName
	,pp.FirstName
from Person.Person as pp
except
select 
	pp.LastName
	,pp.FirstName
from HumanResources.Employee as HRe 
inner join Person.Person as pp on HRe.BusinessEntityID = pp.BusinessEntityID

-- 3. 3. A teraz wyœwietl te osoby, które s¹ pracownikami
select
	pp.LastName
	,pp.FirstName
from Person.Person as pp
intersect
select 
	pp.LastName
	,pp.FirstName
from HumanResources.Employee as HRe 
inner join Person.Person as pp on HRe.BusinessEntityID = pp.BusinessEntityID
