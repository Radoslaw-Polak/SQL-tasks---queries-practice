use AdventureWorks2016
go

-- 1. W aplikacji cz�sto masz si� pos�ugiwa�  informacjami o nazwie produktu, podkategorii i kategorii.
-- Napisz zapytanie, kt�re przy pomocy polecenia JOIN po�aczy ze sob� tabele:
-- Production.Product, 
-- Production.Subcategory i 
-- Production.Category. 
--Wy�wietli� nale�y: 
-- ProductId
-- ProductName
-- SubcategoryName
-- CategoryName
-- Kolumny z nazwami powinny zosta� zaaliasowane.
select
	pp.ProductID
	,pp.Name as ProductName
	,pps.Name as SubcategoryName
	,ppc.Name as CategoryName
from Production.Product as pp
inner join Production.ProductSubcategory as pps on pp.ProductSubcategoryID = pps.ProductSubcategoryID 
inner join Production.ProductCategory as ppc on pps.ProductCategoryID = ppc.ProductCategoryID

-- 2.  Napisz zapytanie, kt�re z tabeli Sales.SalesOrderDetail wy�wietli LineTotal
select 
	ssod.LineTotal
from Sales.SalesOrderDetail as ssod 

select 
	subquery.*
	,ssod.LineTotal 
from (
	select
		pp.ProductID
		,pp.Name as ProductName
		,pps.Name as SubcategoryName
		,ppc.Name as CategoryName
	from Production.Product as pp
	inner join Production.ProductSubcategory as pps on pp.ProductSubcategoryID = pps.ProductSubcategoryID 
	inner join Production.ProductCategory as ppc on pps.ProductCategoryID = ppc.ProductCategoryID
	) as subquery
inner join Sales.SalesOrderDetail as ssod on subquery.ProductID = ssod.ProductID

-- 4. Napisz zapytanie, kt�re z tabel:
-- Sales.SpecialOfferProduct
-- Sales.SpecialOffer
-- wy�wietli:
-- ProductId
-- Description
select 
	ssop.ProductID
	,sso.Description
from Sales.SpecialOfferProduct as ssop 
inner join Sales.SpecialOffer as sso on ssop.SpecialOfferID = sso.SpecialOfferID

-- 5. Do zapytania z pkt (4) do��cz zapytanie z pkt (1) tak aby do�aczane zapytanie by�o podzapytaniem. Wy�wietl:
-- ProductId,
-- Description
-- ProductName,
-- ProductSubcategory
-- ProductCategory
select
	s1.ProductID
	,s1.Description
	,s2.ProductName
	,s2.SubcategoryName
	,s2.CategoryName
from 
	(
	select 
		ssop.ProductID
		,sso.Description
	from Sales.SpecialOfferProduct as ssop 
	inner join Sales.SpecialOffer as sso on ssop.SpecialOfferID = sso.SpecialOfferID
	) as s1

	inner join 
	(
	select
		pp.ProductID
		,pp.Name as ProductName
		,pps.Name as SubcategoryName
		,ppc.Name as CategoryName
	from Production.Product as pp
	inner join Production.ProductSubcategory as pps on pp.ProductSubcategoryID = pps.ProductSubcategoryID 
	inner join Production.ProductCategory as ppc on pps.ProductCategoryID = ppc.ProductCategoryID
	) as s2 on s1.ProductID = s2.ProductID


