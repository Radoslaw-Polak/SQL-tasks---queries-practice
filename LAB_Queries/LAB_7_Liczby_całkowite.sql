use AdventureWorks2016
go

--z1. Zadeklaruj zmienn� @t typu TINYINT
declare @t tinyint

--2. Wylicz ile to jest 2*2*2*2*2*2*2*2. Wynik zapisz w zmiennej @t. Uda�o si�? 
set @t = POWER(2, 8)
print @t

--3. A co je�li od iloczynu odejmiesz 1? Wy�wietl wynik
set @t = POWER(2, 8) - 1 -- 255, dzia�a, bo taki jest rozmiar typy tinyint
print @t

--4. Zadeklaruj zmienna @s typu SMALLINT
--5. Wylicz ile to jest 128*256. Wynik zapisz w zmiennej @s. Uda�o si�? Wy�wietl wynik
declare @s smallint
set @s = 128 * 256
print @s

declare @s smallint
set @s = 128 * 256 - 1
print @s

/*
select 
	DepartmentID
	, (describe DepartmentID) as ID_DataType
from HumanResources.Department
*/

--typ kolumny DepartmentID z tabeli HumanResources.Department (smallint, not null), 0 - 32767
--typ kolumny BusinessEntityID z tabeli HumanResources.Employee (int, not null), 0 - 2147483647
--typ kolumny ShiftID z tabeli HumanResources.Department (tiny, not null), 0 - 255 
