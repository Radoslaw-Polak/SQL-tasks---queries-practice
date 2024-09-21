use AdventureWorks2016
go

-- 1. Po³¹cz tabele Production.Product z Sales.SalesOrderDetail (kolumna ProductId) i z Sales.SalesOrderHeader (kolumna SalesOrderId). 
-- Wyœwietl:
-- nazwê produktu (Name)
-- datê zamówienia (OrderDate)
select 
	pp.Name as [Product name]
	,ssoh.OrderDate
from Production.Product as pp
inner join Sales.SalesOrderDetail as ssod on pp.ProductID = ssod.ProductID
inner join Sales.SalesOrderHeader as ssoh on ssod.SalesOrderID = ssoh.SalesOrderID

-- 2. W oparciu o poprzednie zapytanie wyœwietl informacjê o ostatniej dacie
-- sprzeda¿y produktu. Wynik uporz¹dkuj wg ostatniej daty zamówienia malej¹co
select 
	pp.ProductID
	,pp.Name
	,max(ssoh.OrderDate) as [Last sale date]
from Production.Product as pp
inner join Sales.SalesOrderDetail as ssod on pp.ProductID = ssod.ProductID
inner join Sales.SalesOrderHeader as ssoh on ssod.SalesOrderID = ssoh.SalesOrderID
group by pp.ProductID, pp.Name
order by [Last sale date] desc

-- 3. Zmodyfikuj poprzednie zapytanie tak, aby uwzglêdnione zosta³y
-- równie¿ produkty, które nigdy nie by³y sprzedane
select 
	pp.ProductID
	,pp.Name
	,max(ssoh.OrderDate) as [Last sale date]
from Production.Product as pp
left join Sales.SalesOrderDetail as ssod on pp.ProductID = ssod.ProductID
left join Sales.SalesOrderHeader as ssoh on ssod.SalesOrderID = ssoh.SalesOrderID
group by pp.ProductID, pp.Name
order by [Last sale date] desc


-- 4. SpradŸ na jakich zmianach pracuj¹ pracownicy firmy
-- Wyœwietl
-- z tabeli Person.Person: LastName i FirstName
-- z tabeli HumanResources.Shift: Name
-- do z³¹czenia przyda siê jeszcze tabela HumanResources.EmployeeDepartmentHistory. Odgadnij nazwy kolumn ³¹cz¹ce te tabele ze sob¹
select 
	pp.LastName
	,pp.FirstName
	,HRs.Name
from Person.Person as pp
inner join HumanResources.EmployeeDepartmentHistory as HRedh on pp.BusinessEntityID = HRedh.BusinessEntityID
inner join HumanResources.Shift as HRs on HRedh.ShiftID = HRs.ShiftID

-- 5. SprawdŸ w ramach jakich promocji s¹ sprzedawane produkty
-- Wyœwietl
-- z tabeli Production.Product: Name
-- z tabeli Sales.SpecialOffer: Description
-- do z³aczenia przyda siê tabela Sales.SpecialOfferProduct. Odgadnij nazwy kolumn ³¹cz¹ce te tabele
select 
	pp.Name
	,sso.Description
from Production.Product as pp
inner join Sales.SpecialOfferProduct as ssop on pp.ProductID = ssop.ProductID
inner join Sales.SpecialOffer as sso on ssop.SpecialOfferID = sso.SpecialOfferID
