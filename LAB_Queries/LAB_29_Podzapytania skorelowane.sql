use AdventureWorks2016
go

-- 1. Napisz zapytanie, które ³aczy ze sob¹ tabele: HumanResources.Employee i Person.Person
--(kolumna ³¹cz¹ca BusinessEntityId) i wyœwietla LastName i FirstName
select 
	pp.LastName
	,pp.FirstName
from HumanResources.Employee as HRe 
inner join Person.Person as pp on HRe.BusinessEntityID = pp.BusinessEntityID

-- 2. Bazuj¹c na poprzednim zapytaniu dodaj w liœcie select podzapytanie, które wyliczy ile
-- razy dany pracownik zmienia³ departament pracuj¹c w firmie. W tym celu policz iloœæ rekordów 
-- w tabeli HumanResources. EmployeeDepartamentHistory, które maj¹ BusinessEntityId zgodne z numerem tego pracownika)
select 
	pp.LastName
	,pp.FirstName
	,(select count(*) from HumanResources.EmployeeDepartmentHistory as HRedh
	 where pp.BusinessEntityID = HRedh.BusinessEntityID) as [Number of departament changes]
from HumanResources.Employee as HRe 
inner join Person.Person as pp on HRe.BusinessEntityID = pp.BusinessEntityID

-- akurat dla tego zadania mo¿na to zrobiæ te¿ poprzez grupowanie
select 
	pp.LastName
	,pp.FirstName
	,count(*) as [Number of departament changes]
from HumanResources.Employee as HRe 
inner join Person.Person as pp on HRe.BusinessEntityID = pp.BusinessEntityID
inner join HumanResources.EmployeeDepartmentHistory as HRedh on HRe.BusinessEntityID = HRedh.BusinessEntityID
group by pp.BusinessEntityID, pp.LastName, pp.FirstName

select *
from HumanResources.EmployeeDepartmentHistory

-- 3. Zmodyfikuj poprzednie polecenie tak, aby wyœwietliæ tylko pracowników, którzy pracowali
-- co najmniej w dwóch departamentach
select 
	pp.LastName
	,pp.FirstName
	,(select count(*) from HumanResources.EmployeeDepartmentHistory as HRedh
	 where pp.BusinessEntityID = HRedh.BusinessEntityID) as [Number of departament changes]
from HumanResources.Employee as HRe 
inner join Person.Person as pp on HRe.BusinessEntityID = pp.BusinessEntityID
where 2 <= (select count(*) from HumanResources.EmployeeDepartmentHistory as HRedh
	 where pp.BusinessEntityID = HRedh.BusinessEntityID) 

-- dla grupowania tez tutaj dziala tak samo, imo bardziej czytelne
select 
	pp.LastName
	,pp.FirstName
	,count(*) as [Number of departament changes]
from HumanResources.Employee as HRe 
inner join Person.Person as pp on HRe.BusinessEntityID = pp.BusinessEntityID
inner join HumanResources.EmployeeDepartmentHistory as HRedh on HRe.BusinessEntityID = HRedh.BusinessEntityID
group by pp.BusinessEntityID, pp.LastName, pp.FirstName
having count(*) >= 2

-- 4. W oparciu o dane z tabel HumanResources.Employee i Person.Person wyœwietl imiê
-- i nazwisko pracownika (FirstName i LastName) oraz rok z daty zatrudnienia pracownika
select 
	pp.FirstName
	,pp.LastName
	,HRe.HireDate
from HumanResources.Employee as HRe 
inner join Person.Person as pp on HRe.BusinessEntityID = pp.BusinessEntityID

-- 5. Do poprzedniego zapytania dodaj w SELECT podzapytanie wyœwietlaj¹ce informacjê o 
-- tym, ile osób zatrudni³o siê w tym samym roku co dany pracownik
select 
	pp.FirstName
	,pp.LastName
	,HRe1.HireDate
	,(select count(*) from HumanResources.Employee as HRe2 where year(HRe1.HireDate) = year(HRe2.HireDate)) as [Hired employees]
from HumanResources.Employee as HRe1
inner join Person.Person as pp on HRe1.BusinessEntityID = pp.BusinessEntityID

-- tego sie chyba nie da zrobiæ przez grupowanie
select 
	pp.BusinessEntityID
	,pp.FirstName
	,pp.LastName
	,HRe1.HireDate
	,year(HRe1.HireDate) as Year
	,count(*) as [Hired employees]
from HumanResources.Employee as HRe1
inner join Person.Person as pp on HRe1.BusinessEntityID = pp.BusinessEntityID
group by pp.BusinessEntityID, pp.FirstName, pp.LastName, HRe1.HireDate, year(HRe1.HireDate)

-- 6. Napisz zapytanie, które wyœwietli w oparciu o tabele Sales.SalesPerson oraz Person.Person:
-- LastName, FirstName, Bonus oraz SalesQuota
select
	pp.LastName
	,pp.FirstName
	,ssp.Bonus
	,ssp.SalesQuota
from Sales.SalesPerson as ssp
inner join Person.Person as pp on ssp.BusinessEntityID = pp.BusinessEntityID

-- 7. Do poprzedniego zapytania dodaj dwa podzapytania w SELECT, które:
-- -wyznacz¹ œredni¹ wartoœæ Bonus dla wszystkich pracowników z tego samego terytorium (równoœæ wartoœci w kolumnie TerritoryID)
-- -wyznacz¹ œredni¹ wartoœæ SalesQuota dla wszystkich pracowników z tego samego terytorium (równoœæ wartoœci w kolumnie TerritoryID)
select
	pp.LastName
	,pp.FirstName
	,ssp1.Bonus
	,ssp1.SalesQuota
	,ssp1.TerritoryID
	,(select avg(ssp2.Bonus) from Sales.SalesPerson as ssp2 where ssp1.TerritoryID = ssp2.TerritoryID) as [Avg bonus per territory]
	,(select avg(ssp2.SalesQuota) from Sales.SalesPerson as ssp2 where ssp1.TerritoryID = ssp2.TerritoryID) as [Avg SalesQuota per territory]
from Sales.SalesPerson as ssp1
inner join Person.Person as pp on ssp1.BusinessEntityID = pp.BusinessEntityID

-- 8. Napisz polecenie wyœwietlaj¹ce WSZYSTKIE informacje z tabeli Sales.SalesPerson,
-- dla tych sprzedawców, którzy SalesQuota maj¹ mniejsze od œrednieigo SalesQuota
select *
	   ,(select avg(ssp2.SalesQuota) from Sales.SalesPerson as ssp2) as [Avg sales quota]
from Sales.SalesPerson as ssp1
where ssp1.SalesQuota <
	  (select avg(ssp2.SalesQuota) from Sales.SalesPerson as ssp2)

select count(ssp.SalesQuota)
from Sales.SalesPerson as ssp

-- 9. Zmodyfikuj poprzednie polecenie tak, aby liczenie œredniego SalesQuota dotyczy³o
-- tylko sprzedawców z tego samego terytorium (zgodna kolumna TerritoryID)
select *
	   ,(select avg(ssp2.SalesQuota) from Sales.SalesPerson as ssp2 where ssp1.TerritoryID = ssp2.TerritoryID) as [Avg sales quota]
from Sales.SalesPerson as ssp1
where ssp1.SalesQuota <
	  (select avg(ssp2.SalesQuota) from Sales.SalesPerson as ssp2 where ssp1.TerritoryID = ssp2.TerritoryID)

-- 10. Z tabeli Sales.SalesOrderHeader wyœwietl rok i miesi¹c z OrderDate oraz iloœæ rekordów (pamiêtaj o grupowaniu)
select 
	year(ssoh.OrderDate) as Rok
	,month(ssoh.OrderDate) as [Miesi¹c]
	,count(*) as [Iloœæ zamówieñ]
from Sales.SalesOrderHeader as ssoh 
group by year(ssoh.OrderDate), month(ssoh.OrderDate)
order by Rok desc, Miesi¹c 

-- 11. Do poprzedniego polecenia dodaj do SELECT informacjê o iloœci zamówieñ w
-- poprzednim roku w tym samym miesi¹cu. Skorzystaj z podzapytania.
select 
	year(ssoh1.OrderDate) as Rok
	,month(ssoh1.OrderDate) as [Miesi¹c]
	,count(*) as [Iloœæ zamówieñ]
	,(select count(*) from Sales.SalesOrderHeader as ssoh2 where year(ssoh1.OrderDate) - 1 = year(ssoh2.OrderDate) and month(ssoh1.OrderDate) = month(ssoh2.OrderDate))
	as [Iloœæ zamówieñ rok wczeœniej]
from Sales.SalesOrderHeader as ssoh1 
group by year(ssoh1.OrderDate), month(ssoh1.OrderDate)
order by Rok desc
