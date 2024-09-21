use AdventureWorks2016
go

-- 1. Wyœwietl:
-- z tabeli Person.Person: LastName i FirstName
-- z tabeli Person.PersonPhone: PhoneNumber
-- wyœwietlaj równie¿ te osoby, które nie poda³y numeru telefonu (jeœli takie s¹)
select
	p.LastName
	,p.FirstName
	,pp.PhoneNumber
from Person.Person as p
left join Person.PersonPhone as pp on p.BusinessEntityID = pp.BusinessEntityID 

-- 2. Zmodyfikuj poprzednie polecenie tak,
-- aby wyœwietlone zosta³y tylko te osoby,
-- które nie poda³y numeru telefonu (jeœli takie s¹)
select
	p.LastName
	,p.FirstName
	,pp.PhoneNumber
from Person.Person as p
left join Person.PersonPhone as pp on p.BusinessEntityID = pp.BusinessEntityID
where pp.PhoneNumber is null

-- 3. Wyœwietl:
-- z tabeli Production.Product: Name
-- z tabeli Production.ProductDocument: DocumentNode
-- uwzglêdnij w tym równie¿ te produkty, które nie maj¹ "pasuj¹cego rekordu"
select
	p.Name
	,pd.DocumentNode
from Production.Product as p
left join Production.ProductDocument as pd on p.ProductID = pd.ProductID

-- 4. Zmodyfikuj poprzednie polecenie tak,
-- aby wyœwietlone zosta³y tylko te produkty,
-- które nie maj¹ 'pasuj¹cego' rekordu w tabeli
-- dokumentów
select
	p.Name
	,pd.DocumentNode
from Production.Product as p
left join Production.ProductDocument as pd on p.ProductID = pd.ProductID 
where pd.ProductID is null

-- 5. (*Wymagane dwukrotne do³¹czenie tej samej tabeli z ró¿nymi aliasami!)
-- W tym zadaniu szukamy, czy s¹ takie jednostki miary, które nie s¹ wykorzystywane
-- w tabeli produktów, bo np. chcemy usun¹æ niepotrzebne jednostki miary z tabeli
-- wyœwietl:
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

-- 6. Zmodyfikuj poprzednie polecenie tak, aby wyœwietlone zosta³y tylko te jednostki miary,
-- które nie s¹ u¿ywane ani do okreœlenia rozmiaru produktu, ani do okreœlnenia wagi
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
