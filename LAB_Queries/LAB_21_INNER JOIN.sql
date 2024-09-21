use AdventureWorks2016
go
-- 1. Wyœwietl:
-- z tabeli Person.Person: FirstName i LastName
-- z tabeli Sales.SalesPerson: Bonus
-- kolumn¹ ³¹cz¹c¹ jest BusinessEntityId
select 
	FirstName
	,LastName
	,Bonus
from Person.Person as p
inner join Sales.SalesPerson as s on p.BusinessEntityID = s.BusinessEntityID

-- 2. Wyœwietl:
-- z tabeli Sales.SalesOrderHeader: SalesOrderId, OrderDate i SalesOrderNumber
-- z tabeli SalesOrderDetail: ProductId, OrderQty, UnitPrice
-- kolumn¹ ³¹cz¹c¹ jest SalesOrderId
select
	ssoh.SalesOrderID
	,OrderDate
	,SalesOrderNumber
	,ProductID
	,OrderQty
	,UnitPrice
from Sales.SalesOrderHeader as ssoh
inner join Sales.SalesOrderDetail as ssod on ssoh.SalesOrderID = ssod.SalesOrderID

-- 3. Wyœwietl:
-- z tabeli Production.Product: Name
-- z tabeli Sales.SalesOrderDetails: wartoœæ zamówienia z rabatem (UnitPrice - UnitPriceDiscount)*OrderQty
-- kolumna ³¹cz¹ca to ProductId
select 
	Name
	,(UnitPrice - UnitPriceDiscount) * OrderQty
from Production.Product as pp
inner join Sales.SalesOrderDetail as ssod on pp.ProductID = ssod.ProductID

-- 4. Bazuj¹c na poprzednim zapytaniu wyznacz jaka jest ca³kowita wartoœæ sprzeda¿y okreœlonych produktów, tzn. w wyniku masz zobaczyæ:
-- nazwê produktu
-- ca³kowit¹ wartoœæ sprzeda¿y tego produktu
-- wynik posortuj wg wysokoœci sprzeda¿y malej¹co
select 
	pp.ProductID
	,pp.Name
	,cast( sum( (UnitPrice - UnitPriceDiscount) * OrderQty ) as decimal(10, 2) ) as [TotalSales]
from Production.Product as pp
inner join Sales.SalesOrderDetail as ssod on pp.ProductID = ssod.ProductID
group by pp.ProductID, pp.Name
order by TotalSales desc

-- 5. Wyœwietl
-- z tabeli Production.Category: Name
-- z tabeli Production.SubCategory: Name
-- zaaliasuj kolumny, aby by³o wiadomo, co w nich siê znajduje
select 
	productCat.Name as [Category name]
	,productSubcat.Name as [Subcategory name]
from Production.ProductCategory as productCat
inner join Production.ProductSubcategory as productSubcat on productCat.ProductCategoryID = productSubcat.ProductCategoryID

-- 6.Na podstawie poprzedniego zapytania przygotuj nastêpne, które poka¿e ile podkategorii ma ka¿da kategoria. Wyœwietl:
-- nazwê kategorii
-- iloœæ podkategorii
-- posortuj wg nazwy kategorii
select 
	productCat.Name as [Category name]
	,count(productCat.ProductCategoryID) as [Liczba podkategorii]
from Production.ProductCategory as productCat
inner join Production.ProductSubcategory as productSubcat on productCat.ProductCategoryID = productSubcat.ProductCategoryID
group by productCat.Name
order by productCat.Name

-- 7. Wyœwietl:
-- z tabeli Production.Product: name
-- oraz iloœæ recencji produku (tabela Production.ProductReview)
select	
	pp.ProductID
	,pp.Name
	,count(pp.ProductID) as [Liczba recenzji]
from Production.Product as pp
inner join Production.ProductReview as ppr on pp.ProductID = ppr.ProductID
group by pp.ProductID, pp.Name

-- 8. Ustal, którzy pracownicy pracowali na wiêkszej iloœci zmian. W tym celu po³¹cz tabele:
-- HumanResources.EmployeeDepartmentHistory z
-- Person.Person
-- wyœwietl:
-- imiê i nazwisko (FirstName i LastName)
-- oraz iloœæ dopasowanych rekordów
-- Wybierz tylko te wiersze, w których wyznaczona iloœæ COUNT(*) jest wiêksza ni¿ 1
select 
	pp.LastName
	,pp.FirstName
	,count(*) as [Liczba zmian]
from Person.Person as pp
inner join HumanResources.EmployeeDepartmentHistory as HRedh 
on pp.BusinessEntityID = HRedh.BusinessEntityID
group by pp.LastName, pp.FirstName
having count(*) > 1

