use AdventureWorks2016
go

--1. Z tabeli HumanResources.Department wy�wietl nazw�. Zwr�� uwag� na nazw� pierwszego i ostatniego departamentu
select name
from HumanResources.Department

--2. Napisz skrypt, w kt�rym:
-- zadeklarujesz zmienn� napisow� ,UNICODE, o maksymalnej d�ugo�ci 1000 znak�w
-- przypisz do niej pusty napis
-- poleceniem SELECT pobierz do tej zmiennej nazw� departamentu z rekordu z DepartamentID=1
-- Wy�wietl t� zmienn�
-- Wy�wietl d�ugo�� napisu (w literkach) i ilo�� konsumowanej przez ni� pami�ci

declare @string1 nvarchar(1000)
set @string1 = ''
print @string1

select @string1 = Name
from HumanResources.Department
where DepartmentID = 1
print @string1 


select len(@string1), datalength(@string1)
from HumanResources.Department


--3. Skopiuj poprzednie polecenie i zmie� je tak, �e polecenie SELECT nie b�dzie zawiera� 
--klauzuli WHERE. Nazwa kt�rego departamentu jest teraz warto�ci� zmiennej?

declare @string2 nvarchar(1000)
set @string2 = ''
print @string2

select @string2 = Name
from HumanResources.Department
print @string2

--4. Aktualizuj�c w SELECT zmienn� testow� zmie� wyra�enie na @s1+='/'+Name
-- Sprawd� zawarto�� zmiennej tekstowej wy�wietlaj�c j�
declare @string1 nvarchar(1000)
set @string1 = ''
print @string1

select @string1 += '/' + Name
from HumanResources.Department
print @string1

--5. Sprawd� jaki typ jest u�ywany w poni�szych polach tabel i oce� jak d�ugi napis mo�na umie�ci� w 
-- zmiennej i ile pami�ci on zajmuje:
-- HumanResources.Department - kolumna Name (nvarchar(50))
-- HumanResources.Employes - kolumna MartialStatus (nchar(1))
-- Production.Product - kolumna Color (nvarchar(15))


