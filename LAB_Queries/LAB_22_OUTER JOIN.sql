use AdventureWorks2016
go

-- 1. Wy�wietl:
-- z tabeli Person.Person: LastName i FirstName
-- z tabeli Person.PersonPhone: PhoneNumber
-- wy�wietlaj r�wnie� te osoby, kt�re nie poda�y numeru telefonu (je�li takie s�)
select
	p.LastName
	,p.FirstName
	,pp.PhoneNumber
from Person.Person as p
left join Person.PersonPhone as pp on p.BusinessEntityID = pp.BusinessEntityID 

-- 2. Zmodyfikuj poprzednie polecenie tak,
-- aby wy�wietlone zosta�y tylko te osoby,
-- kt�re nie poda�y numeru telefonu (je�li takie s�)
select
	p.LastName
	,p.FirstName
	,pp.PhoneNumber
from Person.Person as p
left join Person.PersonPhone as pp on p.BusinessEntityID = pp.BusinessEntityID
where pp.PhoneNumber is null

-- 3. Wy�wietl:
-- z tabeli Production.Product: Name
-- z tabeli Production.ProductDocument: DocumentNode
-- uwzgl�dnij w tym r�wnie� te produkty, kt�re nie maj� "pasuj�cego rekordu"
select
	p.Name
	,pd.DocumentNode
from Production.Product as p
left join Production.ProductDocument as pd on p.ProductID = pd.ProductID

-- 4. Zmodyfikuj poprzednie polecenie tak,
-- aby wy�wietlone zosta�y tylko te produkty,
-- kt�re nie maj� 'pasuj�cego' rekordu w tabeli
-- dokument�w
select
	p.Name
	,pd.DocumentNode
from Production.Product as p
left join Production.ProductDocument as pd on p.ProductID = pd.ProductID 
where pd.ProductID is null

-- 5. (*Wymagane dwukrotne do��czenie tej samej tabeli z r�nymi aliasami!)
-- W tym zadaniu szukamy, czy s� takie jednostki miary, kt�re nie s� wykorzystywane
-- w tabeli produkt�w, bo np. chcemy usun�� niepotrzebne jednostki miary z tabeli
-- wy�wietl:
-- z tabeli Production.UnitMeasure: Name, UnitMeasureCode
select 
	um.Name
	,um.UnitMeasureCode 
	,case
		when pSizeUnit.SizeUnitMeasureCode is not null then 'Is used as a size'
		when pWeightUnit.WeightUnitMeasureCode is not null then 'Is used as a weight'
	end as [Used as]
from Production.UnitMeasure as um 
left join Production.Product as pSizeUnit on um.UnitMeasureCode = pSizeUnit.SizeUnitMeasureCode 
left join Production.Product as pWeightUnit on um.UnitMeasureCode = pWeightUnit.WeightUnitMeasureCode 

-- 6. Zmodyfikuj poprzednie polecenie tak, aby wy�wietlone zosta�y tylko te jednostki miary,
-- kt�re nie s� u�ywane ani do okre�lenia rozmiaru produktu, ani do okre�lnenia wagi
select 
	um.Name
	,um.UnitMeasureCode 
	,case
		when pSizeUnit.SizeUnitMeasureCode is not null then 'Is used as a size'
		when pWeightUnit.WeightUnitMeasureCode is not null then 'Is used as a weight'
	end as [Used as]
from Production.UnitMeasure as um 
left join Production.Product as pSizeUnit on um.UnitMeasureCode = pSizeUnit.SizeUnitMeasureCode 
left join Production.Product as pWeightUnit on um.UnitMeasureCode = pWeightUnit.WeightUnitMeasureCode 
where pSizeUnit.SizeUnitMeasureCode is null and pWeightUnit.WeightUnitMeasureCode is null
