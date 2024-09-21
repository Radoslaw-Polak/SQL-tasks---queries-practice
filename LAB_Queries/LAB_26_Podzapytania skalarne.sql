use AdventureWorks2016
go

-- 1. Z tabeli HumanResources.Employee wy�wietl LoginId oraz SickLeaveHours
select 
	LoginID
	,SickLeaveHours
from HumanResources.Employee as HRe

-- 2. W nowym zapytaniu wy�wietl �redni� ilo�� SickleaveHours
select avg(SickLeaveHours)
from HumanResources.Employee as HRe

-- 3. Napisz zapytanie w kt�rym:
-- -wy�wietlone zostan� dane z pierwszego zapytania
-- -w dodatkowej kolumnie wy�wietl �redni� ilo�� SickleaveHours w postaci podzapytania
-- -zaaliasuj t� kolumn� jako AvgSickLeaveHours
select 
	LoginID
	,SickLeaveHours
	,(select avg(SickLeaveHours)
	from HumanResources.Employee as HRe) as AvgSickLeaveHours
from HumanResources.Employee as HRe

-- 4. Skopiuj poprzednie zapytanie. W nowej kolumnie wylicz
-- r�nic� mi�dzy SickLeaveHours pracownika a warto�ci� �redni�
-- ca�ej tabeli. Kolumn� zaaliasuj jako SickLeaveDiff
select 
	LoginID
	,SickLeaveHours
	,(select avg(SickLeaveHours)
	from HumanResources.Employee as HRe) as AvgSickLeaveHours
	,SickLeaveHours - (select avg(SickLeaveHours)
	from HumanResources.Employee as HRe) as DiffInSIckLeaveHours
from HumanResources.Employee as HRe

-- 5. Skopiuj poprzednie zapytanie. Dodaj klauzul� where, kt�ra
-- spowoduje wy�wietlenie tylko tych pracownik�w, kt�rzy maj� liczb�
-- godzin SickLeaveHours wi�ksz� ni� warto�� �redni�. Uporz�dkuj dane
-- wg kolumny SickLeaveDiff malej�co
select 
	LoginID
	,SickLeaveHours
	,(select avg(SickLeaveHours) from HumanResources.Employee as HRe) as AvgSickLeaveHours
	,SickLeaveHours - (select avg(SickLeaveHours) from HumanResources.Employee as HRe) as DiffInSIckLeaveHours
from HumanResources.Employee as HRe
where SickLeaveHours > (select avg(SickLeaveHours) from HumanResources.Employee as HRe)
order by DiffInSIckLeaveHours desc

