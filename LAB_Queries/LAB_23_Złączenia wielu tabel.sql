use AdventureWorks2016
go

-- 1. Po��cz tabele Production.Product z Sales.SalesOrderDetail (kolumna ProductId) i z Sales.SalesOrderHeader (kolumna SalesOrderId). 
-- Wy�wietl:
-- nazw� produktu (Name)
-- dat� zam�wienia (OrderDate)
select 
	pp.Name as [Product name]
	,ssoh.OrderDate
from Production.Product as pp
inner join Sales.SalesOrderDetail as ssod on pp.ProductID = ssod.ProductID
inner join Sales.SalesOrderHeader as ssoh on ssod.SalesOrderID = ssoh.SalesOrderID

-- 2. W oparciu o poprzednie zapytanie wy�wietl informacj� o ostatniej dacie
-- sprzeda�y produktu. Wynik uporz�dkuj wg ostatniej daty zam�wienia malej�co
select 
	pp.ProductID
	,pp.Name
	,max(ssoh.OrderDate) as [Last sale date]
from Production.Product as pp
inner join Sales.SalesOrderDetail as ssod on pp.ProductID = ssod.ProductID
inner join Sales.SalesOrderHeader as ssoh on ssod.SalesOrderID = ssoh.SalesOrderID
group by pp.ProductID, pp.Name
order by [Last sale date] desc

-- 3. Zmodyfikuj poprzednie zapytanie tak, aby uwzgl�dnione zosta�y
-- r�wnie� produkty, kt�re nigdy nie by�y sprzedane
select 
	pp.ProductID
	,pp.Name
	,max(ssoh.OrderDate) as [Last sale date]
from Production.Product as pp
left join Sales.SalesOrderDetail as ssod on pp.ProductID = ssod.ProductID
left join Sales.SalesOrderHeader as ssoh on ssod.SalesOrderID = ssoh.SalesOrderID
group by pp.ProductID, pp.Name
order by [Last sale date] desc


-- 4. Sprad� na jakich zmianach pracuj� pracownicy firmy
-- Wy�wietl
-- z tabeli Person.Person: LastName i FirstName
-- z tabeli HumanResources.Shift: Name
-- do z��czenia przyda si� jeszcze tabela HumanResources.EmployeeDepartmentHistory. Odgadnij nazwy kolumn ��cz�ce te tabele ze sob�
select 
	pp.LastName
	,pp.FirstName
	,HRs.Name
from Person.Person as pp
inner join HumanResources.EmployeeDepartmentHistory as HRedh on pp.BusinessEntityID = HRedh.BusinessEntityID
inner join HumanResources.Shift as HRs on HRedh.ShiftID = HRs.ShiftID

-- 5. Sprawd� w ramach jakich promocji s� sprzedawane produkty
-- Wy�wietl
-- z tabeli Production.Product: Name
-- z tabeli Sales.SpecialOffer: Description
-- do z�aczenia przyda si� tabela Sales.SpecialOfferProduct. Odgadnij nazwy kolumn ��cz�ce te tabele
select 
	pp.Name
	,sso.Description
from Production.Product as pp
inner join Sales.SpecialOfferProduct as ssop on pp.ProductID = ssop.ProductID
inner join Sales.SpecialOffer as sso on ssop.SpecialOfferID = sso.SpecialOfferID
