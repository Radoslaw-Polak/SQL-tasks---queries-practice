use AdventureWorks2016
go
-- 1. Wy�wietl:
-- z tabeli Person.Person: FirstName i LastName
-- z tabeli Sales.SalesPerson: Bonus
-- kolumn� ��cz�c� jest BusinessEntityId
select 
	FirstName
	,LastName
	,Bonus
from Person.Person as p
inner join Sales.SalesPerson as s on p.BusinessEntityID = s.BusinessEntityID

-- 2. Wy�wietl:
-- z tabeli Sales.SalesOrderHeader: SalesOrderId, OrderDate i SalesOrderNumber
-- z tabeli SalesOrderDetail: ProductId, OrderQty, UnitPrice
-- kolumn� ��cz�c� jest SalesOrderId
select
	ssoh.SalesOrderID
	,OrderDate
	,SalesOrderNumber
	,ProductID
	,OrderQty
	,UnitPrice
from Sales.SalesOrderHeader as ssoh
inner join Sales.SalesOrderDetail as ssod on ssoh.SalesOrderID = ssod.SalesOrderID

-- 3. Wy�wietl:
-- z tabeli Production.Product: Name
-- z tabeli Sales.SalesOrderDetails: warto�� zam�wienia z rabatem (UnitPrice - UnitPriceDiscount)*OrderQty
-- kolumna ��cz�ca to ProductId
select 
	Name
	,(UnitPrice - UnitPriceDiscount) * OrderQty
from Production.Product as pp
inner join Sales.SalesOrderDetail as ssod on pp.ProductID = ssod.ProductID

-- 4. Bazuj�c na poprzednim zapytaniu wyznacz jaka jest ca�kowita warto�� sprzeda�y okre�lonych produkt�w, tzn. w wyniku masz zobaczy�:
-- nazw� produktu
-- ca�kowit� warto�� sprzeda�y tego produktu
-- wynik posortuj wg wysoko�ci sprzeda�y malej�co
select 
	pp.ProductID
	,pp.Name
	,cast( sum( (UnitPrice - UnitPriceDiscount) * OrderQty ) as decimal(10, 2) ) as [TotalSales]
from Production.Product as pp
inner join Sales.SalesOrderDetail as ssod on pp.ProductID = ssod.ProductID
group by pp.ProductID, pp.Name
order by TotalSales desc

-- 5. Wy�wietl
-- z tabeli Production.Category: Name
-- z tabeli Production.SubCategory: Name
-- zaaliasuj kolumny, aby by�o wiadomo, co w nich si� znajduje
select 
	productCat.Name as [Category name]
	,productSubcat.Name as [Subcategory name]
from Production.ProductCategory as productCat
inner join Production.ProductSubcategory as productSubcat on productCat.ProductCategoryID = productSubcat.ProductCategoryID

-- 6.Na podstawie poprzedniego zapytania przygotuj nast�pne, kt�re poka�e ile podkategorii ma ka�da kategoria. Wy�wietl:
-- nazw� kategorii
-- ilo�� podkategorii
-- posortuj wg nazwy kategorii
select 
	productCat.Name as [Category name]
	,count(productCat.ProductCategoryID) as [Liczba podkategorii]
from Production.ProductCategory as productCat
inner join Production.ProductSubcategory as productSubcat on productCat.ProductCategoryID = productSubcat.ProductCategoryID
group by productCat.Name
order by productCat.Name

-- 7. Wy�wietl:
-- z tabeli Production.Product: name
-- oraz ilo�� recencji produku (tabela Production.ProductReview)
select	
	pp.ProductID
	,pp.Name
	,count(pp.ProductID) as [Liczba recenzji]
from Production.Product as pp
inner join Production.ProductReview as ppr on pp.ProductID = ppr.ProductID
group by pp.ProductID, pp.Name

-- 8. Ustal, kt�rzy pracownicy pracowali na wi�kszej ilo�ci zmian. W tym celu po��cz tabele:
-- HumanResources.EmployeeDepartmentHistory z
-- Person.Person
-- wy�wietl:
-- imi� i nazwisko (FirstName i LastName)
-- oraz ilo�� dopasowanych rekord�w
-- Wybierz tylko te wiersze, w kt�rych wyznaczona ilo�� COUNT(*) jest wi�ksza ni� 1
select 
	pp.LastName
	,pp.FirstName
	,count(*) as [Liczba zmian]
from Person.Person as pp
inner join HumanResources.EmployeeDepartmentHistory as HRedh 
on pp.BusinessEntityID = HRedh.BusinessEntityID
group by pp.LastName, pp.FirstName
having count(*) > 1

