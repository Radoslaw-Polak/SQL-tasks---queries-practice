use AdventureWorks2016
go

-- 1. Z tabeli HumanResources.Employee wyœwietl LoginId oraz SickLeaveHours
select 
	LoginID
	,SickLeaveHours
from HumanResources.Employee as HRe

-- 2. W nowym zapytaniu wyœwietl œredni¹ iloœæ SickleaveHours
select avg(SickLeaveHours)
from HumanResources.Employee as HRe

-- 3. Napisz zapytanie w którym:
-- -wyœwietlone zostan¹ dane z pierwszego zapytania
-- -w dodatkowej kolumnie wyœwietl œredni¹ iloœæ SickleaveHours w postaci podzapytania
-- -zaaliasuj t¹ kolumnê jako AvgSickLeaveHours
select 
	LoginID
	,SickLeaveHours
	,(select avg(SickLeaveHours)
	from HumanResources.Employee as HRe) as AvgSickLeaveHours
from HumanResources.Employee as HRe

-- 4. Skopiuj poprzednie zapytanie. W nowej kolumnie wylicz
-- ró¿nicê miêdzy SickLeaveHours pracownika a wartoœci¹ œredni¹
-- ca³ej tabeli. Kolumnê zaaliasuj jako SickLeaveDiff
select 
	LoginID
	,SickLeaveHours
	,(select avg(SickLeaveHours)
	from HumanResources.Employee as HRe) as AvgSickLeaveHours
	,SickLeaveHours - (select avg(SickLeaveHours)
	from HumanResources.Employee as HRe) as DiffInSIckLeaveHours
from HumanResources.Employee as HRe

-- 5. Skopiuj poprzednie zapytanie. Dodaj klauzulê where, która
-- spowoduje wyœwietlenie tylko tych pracowników, którzy maj¹ liczbê
-- godzin SickLeaveHours wiêksz¹ ni¿ wartoœæ œredni¹. Uporz¹dkuj dane
-- wg kolumny SickLeaveDiff malej¹co
select 
	LoginID
	,SickLeaveHours
	,(select avg(SickLeaveHours) from HumanResources.Employee as HRe) as AvgSickLeaveHours
	,SickLeaveHours - (select avg(SickLeaveHours) from HumanResources.Employee as HRe) as DiffInSIckLeaveHours
from HumanResources.Employee as HRe
where SickLeaveHours > (select avg(SickLeaveHours) from HumanResources.Employee as HRe)
order by DiffInSIckLeaveHours desc

