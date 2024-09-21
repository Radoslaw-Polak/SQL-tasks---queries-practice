use AdventureWorks2016
go

--1. Z tabeli HumanResources.Department wyœwietl nazwê. Zwróæ uwagê na nazwê pierwszego i ostatniego departamentu
select name
from HumanResources.Department

--2. Napisz skrypt, w którym:
-- zadeklarujesz zmienn¹ napisow¹ ,UNICODE, o maksymalnej d³ugoœci 1000 znaków
-- przypisz do niej pusty napis
-- poleceniem SELECT pobierz do tej zmiennej nazwê departamentu z rekordu z DepartamentID=1
-- Wyœwietl t¹ zmienn¹
-- Wyœwietl d³ugoœæ napisu (w literkach) i iloœæ konsumowanej przez ni¹ pamiêci

declare @string1 nvarchar(1000)
set @string1 = ''
print @string1

select @string1 = Name
from HumanResources.Department
where DepartmentID = 1
print @string1 


select len(@string1), datalength(@string1)
from HumanResources.Department


--3. Skopiuj poprzednie polecenie i zmieñ je tak, ¿e polecenie SELECT nie bêdzie zawieraæ 
--klauzuli WHERE. Nazwa którego departamentu jest teraz wartoœci¹ zmiennej?

declare @string2 nvarchar(1000)
set @string2 = ''
print @string2

select @string2 = Name
from HumanResources.Department
print @string2

--4. Aktualizuj¹c w SELECT zmienn¹ testow¹ zmieñ wyra¿enie na @s1+='/'+Name
-- SprawdŸ zawartoœæ zmiennej tekstowej wyœwietlaj¹c j¹
declare @string1 nvarchar(1000)
set @string1 = ''
print @string1

select @string1 += '/' + Name
from HumanResources.Department
print @string1

--5. SprawdŸ jaki typ jest u¿ywany w poni¿szych polach tabel i oceñ jak d³ugi napis mo¿na umieœciæ w 
-- zmiennej i ile pamiêci on zajmuje:
-- HumanResources.Department - kolumna Name (nvarchar(50))
-- HumanResources.Employes - kolumna MartialStatus (nchar(1))
-- Production.Product - kolumna Color (nvarchar(15))


