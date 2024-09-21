use AdventureWorks2016
go

-- 1. Napisz zapytanie, kt�re z tabeli Person.Person wybierze LastName i FirstName. 
-- Napisz zapytanie, kt�re z tabeli HumanResources.Employee i Person.Person wybierze LastName i FirstName pracownik�w
-- Po��cz oba w/w zapytania tak, aby je�li dana osoba jest pracownikiem, pojawi�a sie w wyniku 2 razy
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

-- 2. A teraz poka� te osoby z pierwszego zapytania, kt�re NIE s� pracownikami.
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

-- 3. 3. A teraz wy�wietl te osoby, kt�re s� pracownikami
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
