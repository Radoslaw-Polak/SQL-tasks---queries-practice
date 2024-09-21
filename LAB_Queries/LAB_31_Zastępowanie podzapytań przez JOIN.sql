use AdventureWorks2016
go

-- 1. Poni¿sze zapytania odpowiada na pytanie "Jakie produkty maj¹ taki sam kolor, co produkt 322".
-- Zapisz to zapytanie nie korzytaj¹c z podzapytañ
-- SUBQUERY
SELECT p.* FROM Production.Product p
WHERE
p.Color = (SELECT Color FROM Production.Product WHERE ProductID=322)

-- JOIN
select 
	pp1.* 
from Production.Product as pp1
inner join Production.Product as pp2 on pp1.Color = pp2.Color
where pp2.ProductID = 322

-- 2. Poni¿sze zapytanie odpowiada na pytanie "Jak nazywa siê pracownik". 
-- Zamieñ je na postaæ bez podzapytañ.
-- SUBQUERY
SELECT
 e.LoginID
 ,(SELECT p.LastName+' '+p.FirstName 
   FROM Person.Person p WHERE p.BusinessEntityID = e.BusinessEntityID) AS Name
FROM HumanResources.Employee e

-- JOIN
select
	HRe.LoginID
	,pp.BusinessEntityID
	,pp.FirstName
	,pp.LastName
from HumanResources.Employee as HRe
inner join Person.Person as pp on HRe.BusinessEntityID = pp.BusinessEntityID
order by pp.LastName

-- 3. Poni¿sze zapytanie odpowiada na pytanie "Jakie jednostki miary nie s¹ wykorzystywane przez produkty".
-- Zapisz je nie wykorzystuj¹c podzapytañ
-- SUBQUERY
SELECT 
*
FROM Production.UnitMeasure um
WHERE
 NOT EXISTS(
 SELECT * FROM Production.Product p 
 WHERE um.UnitMeasureCode = p.SizeUnitMeasureCode 
       OR um.UnitMeasureCode =p.WeightUnitMeasureCode
 )

-- JOIN
select 
	Pum.*
from Production.UnitMeasure as Pum
left join Production.Product as pp on Pum.UnitMeasureCode in (pp.SizeUnitMeasureCode, pp.WeightUnitMeasureCode)
where pp.SizeUnitMeasureCode is null and pp.WeightUnitMeasureCode is null
order by Pum.UnitMeasureCode

-- odpowiedz
SELECT
*
FROM Production.UnitMeasure um
LEFT JOIN Production.Product pSize ON um.UnitMeasureCode = pSize.SizeUnitMeasureCode
LEFT JOIN Production.Product pWeight ON um.UnitMeasureCode = pWeight.WeightUnitMeasureCode
WHERE 
pSize.ProductID IS NULL AND pWeight.ProductID IS NULL
order by UnitMeasureCode

-- 4. Poni¿sze zapytanie odpowiada na pytanie "Jakie jednostki miary s¹ wykorzystywane przez produkty".
-- Zapisz je nie wykorzystuj¹c podzapytañ
-- SUBQUERY
SELECT 
um.*
FROM Production.UnitMeasure um
WHERE
 EXISTS( 
 SELECT * FROM Production.Product p 
 WHERE um.UnitMeasureCode = p.SizeUnitMeasureCode 
   OR um.UnitMeasureCode =p.WeightUnitMeasureCode
 )

-- JOIN
select distinct
	Pum.*
from Production.UnitMeasure as Pum
inner join Production.Product as pp on Pum.UnitMeasureCode in (pp.SizeUnitMeasureCode, pp.WeightUnitMeasureCode)

-- odpowiedz
SELECT
DISTINCT um.*
FROM Production.UnitMeasure um
LEFT JOIN Production.Product pSize ON um.UnitMeasureCode = pSize.SizeUnitMeasureCode
LEFT JOIN Production.Product pWeight ON um.UnitMeasureCode = pWeight.WeightUnitMeasureCode
WHERE 
pSize.ProductID IS NOT NULL OR pWeight.ProductID IS NOT  NULL

