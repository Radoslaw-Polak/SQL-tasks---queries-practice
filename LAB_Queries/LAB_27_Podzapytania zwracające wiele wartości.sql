use AdventureWorks2016
go

-- 1. Napisz zapytanie zwracaj¹ce BusinessEntityId dla jednego dowolnego pracownika
-- (TOP(1)) z tabeli Sales.SalesPerson. Rekord powinien prezentowaæ pracownika z TerritoryId=1
select top 1 
	BusinessEntityID
from Sales.SalesPerson as ssp
where TerritoryID = 1

-- 2. Napisz zapytanie wyœwietlaj¹ce zamówienia z tabeli SalesOrderHeader dla tego pracownika
select *
from Sales.SalesOrderHeader as ssoh
where ssoh.SalesPersonID =
	(
	select top 1 
		BusinessEntityID
	from Sales.SalesPerson as ssp
	where TerritoryID = 1
	)

-- 3. Skopuj zapytanie z punktu (1) i usuñ z niego TOP(1).  Ile rekordów jest wyœwietlanych?
select 
	BusinessEntityID
from Sales.SalesPerson as ssp
where TerritoryID = 1

-- 4. Skopiuj zapytanie z punktu (2). Usuñ z niego TOP(1). Czy zapytanie dzia³a?
-- nie zadziala bo podzapytanie zwraca wiele rekordów
select *
from Sales.SalesOrderHeader as ssoh
where ssoh.SalesPersonID =
	(
	select 
		BusinessEntityID
	from Sales.SalesPerson as ssp
	where TerritoryID = 1
	)

-- 5. Popraw zapytanie aby zwraca³o poprawny wynik
select *
from Sales.SalesOrderHeader as ssoh
where ssoh.SalesPersonID in
	(
	select 
		BusinessEntityID
	from Sales.SalesPerson as ssp
	where TerritoryID = 1
	)

-- 6. Wyœwietl BusinessEntityId z tabeli HumanResources.DepartmentHistory dla DepartmentId=1.
select
	BusinessEntityID
from HumanResources.EmployeeDepartmentHistory as HRedh
where DepartmentID = 1

-- 7. Wyœwietl rekordy z HumanResources.Employee rekordy pracowników, którzy kiedykolwiek
-- pracowali w DepartamentId=1. Skorzystaj w tym celu z zapytania z pkt (6)
select *
from HumanResources.Employee as HRe
where HRe.BusinessEntityID in
	(
	select
		BusinessEntityID
	from HumanResources.EmployeeDepartmentHistory as HRedh
	where DepartmentID = 1
	)

-- ten sam wynik
select *
from HumanResources.Employee as HRe
inner join HumanResources.EmployeeDepartmentHistory as HRedh on HRe.BusinessEntityID = HRedh.BusinessEntityID
where DepartmentID = 1
