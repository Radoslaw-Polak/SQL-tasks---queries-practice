use AdventureWorks2016
go

-- 1. Trzeba sprawdzi� czy w tabeli Production.UnitMeasure znajduj� si� jednostki miary,
-- kt�re nie s� u�ywane przez �aden rekord w Production.Product. Korzystaj�c z jednego z
-- przedstawionych w tej lekcji s��w napisz zapytanie, kt�re wy�wietli rekordy z Production.UnitMeasure
-- nieu�ywane w tabeli Production.Product ani w kolumnie SizeUnitMeasureCode ani w WeightUnitMeasureCode.
select *
from Production.UnitMeasure
select *
from Production.Product
------------------------------------------
-- unit code z tabeli UnitMeasure mo�e by� albo w kolumnie SizeUnitMeasureCode albo w kolumnie WeightUnitMeasureCode w tabeli Production.Product
select *
from Production.UnitMeasure as Pum
where 
	not exists (select * from Production.Product as pp
	where Pum.UnitMeasureCode in (pp.SizeUnitMeasureCode, pp.WeightUnitMeasureCode))

-- 2. Zmodyfikuj polecenie z punktu (1), tak aby wy�wietli� te jednostki miary kt�re s� wykorzystywane w Production.Product
select *
from Production.UnitMeasure as Pum
where 
	exists (select * from Production.Product as pp where Pum.UnitMeasureCode in (pp.SizeUnitMeasureCode, pp.WeightUnitMeasureCode))

-- 3. Wy�wietl z tabeli Production.Product te rekordy, gdzie ListPrice jest wi�ksze ni� ListPrice ka�dego produktu z kategorii 1
-- tutaj po prostu warunek dla id podkategorii dla danego produktu
select *
from Production.Product as pp
where pp.ListPrice > all(select ListPrice from Production.Product as pp
						 where pp.ProductSubcategoryID = 1)

-- tutaj dla kategorii st�d potrzebne by�y joiny
select *
from Production.Product as pp
where pp.ListPrice > all(select 
							ListPrice 
					  from Production.Product as pp 
					  inner join Production.ProductSubcategory as pps on pp.ProductSubcategoryID = pps.ProductSubcategoryID
					  inner join Production.ProductCategory as ppc on pps.ProductCategoryID = ppc.ProductCategoryID
					  where ppc.ProductCategoryID = 1)

-- 4. Wy�wietl z tabeli Production.Product te rekordy, gdzie ListPrice jest wi�ksze ni� ListPrice dla chocia� jednego produktu z kategorii 1
-- tutaj po prostu warunek dla id podkategorii dla danego produktu
select *
from Production.Product as pp
where pp.ListPrice > all(select ListPrice from Production.Product as pp
						 where pp.ProductSubcategoryID = 1)
------------------------------------------------------------
-- tutaj dla kategorii st�d potrzebne by�y joiny
select *
from Production.Product as pp
where pp.ListPrice >  any( -- albo some()
					  select 
							ListPrice 
					  from Production.Product as pp 
					  inner join Production.ProductSubcategory as pps on pp.ProductSubcategoryID = pps.ProductSubcategoryID
					  inner join Production.ProductCategory as ppc on pps.ProductCategoryID = ppc.ProductCategoryID
					  where ppc.ProductCategoryID = 1)

	

