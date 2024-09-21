use AdventureWorks2016
go

BEGIN TRAN
 
ALTER TABLE Person.Person NOCHECK CONSTRAINT ALL
ALTER TABLE Sales.SalesPerson NOCHECK CONSTRAINT ALL
ALTER TABLE HumanResources.EmployeeDepartmentHistory NOCHECK CONSTRAINT ALL
ALTER TABLE HumanResources.EmployeePayHistory NOCHECK CONSTRAINT ALL
ALTER TABLE HumanResources.JobCandidate NOCHECK CONSTRAINT ALL
ALTER TABLE HumanResources.Employee NOCHECK CONSTRAINT ALL
UPDATE HumanResources.Employee set BusinessEntityID=1074 WHERE BusinessEntityID = 274

-- 1. Z tabeli HumanResources.Employee wyœwietl BusinessEntityId i LoginId. Ile jest rekordów?
-- 290 rekordów
select 
	BusinessEntityID
	,LoginID
from HumanResources.Employee as HRe
order by BusinessEntityID


-- 2. Z tabeli Sales.SalesPerson wyœwietl BusinessEntityId i Bonus. Ile jest rekordów ?
-- 17 rekordów
select *
from Sales.SalesPerson as ssp

-- 3. Szukamy pracowników, którzy s¹ sprzedawcami. Po³¹cz obie tabele przez INNER JOIN - ile jest rekordów? 
-- 16 rekordów, bo jednego pracownika nie ma na liœcie pracowników ale jest na liœcie sprzedawców
select *
from HumanResources.Employee as HRe
inner join Sales.SalesPerson as ssp on HRe.BusinessEntityID = ssp.BusinessEntityID

-- 4. O ka¿dym pracowniku szukamy informacji o tym czy jest sprzedawc¹. Oczywiœcie wielu pracowników nie jest sprzedawcami. 
-- Po³¹cz tabelê HumanResources.Employee z tabel¹ Sales.SalesPerson przy pomocy LEFT JOIN. Ile rekordów zostanie zwróconych?
-- 290
select *
from HumanResources.Employee as HRe
left join Sales.SalesPerson as ssp on HRe.BusinessEntityID = ssp.BusinessEntityID

-- 5. O ka¿dym sprzedawcy szukamy informacji, czy jest pracownikem. Wszyscy poza jednym s¹...
-- Po³¹cz tabbelê Sales.SalesPerson z tabel¹ HumanResources.Employee przy pomocy RIGHT JOIN. Ile rekordów zostanie zwróconych?
-- 17 rekordów
select *
from HumanResources.Employee as HRe
right join Sales.SalesPerson as ssp on HRe.BusinessEntityID = ssp.BusinessEntityID

-- 6. Po³¹cz obie tabele korzystaj¹c z FULL JOIN - ile rekordów zostanie zwróconych?
select 
	HRe.BusinessEntityID
	,HRe.LoginID
	,ssp.BusinessEntityID
	,ssp.Bonus
from HumanResources.Employee as HRe
full outer join Sales.SalesPerson as ssp on HRe.BusinessEntityID = ssp.BusinessEntityID

rollback
-- teraz znowu jest ten pracownik o ID 274, czyli rollback cofnê³o wszystkie zmiany
select 
	BusinessEntityID
	,LoginID
from HumanResources.Employee as HRe
order by BusinessEntityID