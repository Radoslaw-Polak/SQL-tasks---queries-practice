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

-- 1. Z tabeli HumanResources.Employee wy�wietl BusinessEntityId i LoginId. Ile jest rekord�w?
-- 290 rekord�w
select 
	BusinessEntityID
	,LoginID
from HumanResources.Employee as HRe
order by BusinessEntityID


-- 2. Z tabeli Sales.SalesPerson wy�wietl BusinessEntityId i Bonus. Ile jest rekord�w ?
-- 17 rekord�w
select *
from Sales.SalesPerson as ssp

-- 3. Szukamy pracownik�w, kt�rzy s� sprzedawcami. Po��cz obie tabele przez INNER JOIN - ile jest rekord�w? 
-- 16 rekord�w, bo jednego pracownika nie ma na li�cie pracownik�w ale jest na li�cie sprzedawc�w
select *
from HumanResources.Employee as HRe
inner join Sales.SalesPerson as ssp on HRe.BusinessEntityID = ssp.BusinessEntityID

-- 4. O ka�dym pracowniku szukamy informacji o tym czy jest sprzedawc�. Oczywi�cie wielu pracownik�w nie jest sprzedawcami. 
-- Po��cz tabel� HumanResources.Employee z tabel� Sales.SalesPerson przy pomocy LEFT JOIN. Ile rekord�w zostanie zwr�conych?
-- 290
select *
from HumanResources.Employee as HRe
left join Sales.SalesPerson as ssp on HRe.BusinessEntityID = ssp.BusinessEntityID

-- 5. O ka�dym sprzedawcy szukamy informacji, czy jest pracownikem. Wszyscy poza jednym s�...
-- Po��cz tabbel� Sales.SalesPerson z tabel� HumanResources.Employee przy pomocy RIGHT JOIN. Ile rekord�w zostanie zwr�conych?
-- 17 rekord�w
select *
from HumanResources.Employee as HRe
right join Sales.SalesPerson as ssp on HRe.BusinessEntityID = ssp.BusinessEntityID

-- 6. Po��cz obie tabele korzystaj�c z FULL JOIN - ile rekord�w zostanie zwr�conych?
select 
	HRe.BusinessEntityID
	,HRe.LoginID
	,ssp.BusinessEntityID
	,ssp.Bonus
from HumanResources.Employee as HRe
full outer join Sales.SalesPerson as ssp on HRe.BusinessEntityID = ssp.BusinessEntityID

rollback
-- teraz znowu jest ten pracownik o ID 274, czyli rollback cofn�o wszystkie zmiany
select 
	BusinessEntityID
	,LoginID
from HumanResources.Employee as HRe
order by BusinessEntityID