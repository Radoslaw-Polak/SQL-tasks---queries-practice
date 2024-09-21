use AdventureWorks2016
go

-- 1. W aplikacji czêsto masz siê pos³ugiwaæ  informacjami o nazwie produktu, podkategorii i kategorii.
-- Napisz zapytanie, które przy pomocy polecenia JOIN po³aczy ze sob¹ tabele:
-- Production.Product, 
-- Production.Subcategory i 
-- Production.Category. 
--Wyœwietliæ nale¿y: 
-- ProductId
-- ProductName
-- SubcategoryName
-- CategoryName
-- Kolumny z nazwami powinny zostaæ zaaliasowane.
select
	pp.ProductID
	,pp.Name as ProductName
	,pps.Name as SubcategoryName
	,ppc.Name as CategoryName
from Production.Product as pp
inner join Production.ProductSubcategory as pps on pp.ProductSubcategoryID = pps.ProductSubcategoryID 
inner join Production.ProductCategory as ppc on pps.ProductCategoryID = ppc.ProductCategoryID

-- 2.  Napisz zapytanie, które z tabeli Sales.SalesOrderDetail wyœwietli LineTotal
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

-- 4. Napisz zapytanie, które z tabel:
-- Sales.SpecialOfferProduct
-- Sales.SpecialOffer
-- wyœwietli:
-- ProductId
-- Description
select 
	ssop.ProductID
	,sso.Description
from Sales.SpecialOfferProduct as ssop 
inner join Sales.SpecialOffer as sso on ssop.SpecialOfferID = sso.SpecialOfferID

-- 5. Do zapytania z pkt (4) do³¹cz zapytanie z pkt (1) tak aby do³aczane zapytanie by³o podzapytaniem. Wyœwietl:
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


