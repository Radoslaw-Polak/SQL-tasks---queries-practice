use AdventureWorks2016
go

-- Wy�wietl rekordy z tabeli Person.Person, gdzie nie podano drugiego imienia (MiddleName)
select *
from Person.Person
where MiddleName is null;

-- Wy�wietl rekordy z tabeli Person.Person, gdzie drugie imi� jest podane
select *
from Person.Person
where MiddleName is not null;

-- Wy�wietl z tabeli Person.Person:
-- -FirstName
-- -MiddleName
-- -LastName
-- -napis z po��czenia ze sob� FirstName ' ' MiddleName ' ' i  LastName
select FirstName
	   ,MiddleName
	   ,LastName
	   ,concat(FirstName, ' ', MiddleName + ' ', LastName) as FullName
from Person.Person

-- Je�li jeszcze tego nie zrobi�e� dodaj wyra�enie, kt�re obs�u�y sytuacj�, gdy MiddleName jest NULL.
-- W takim przypadku chcemy prezentowa� tylko FirstName ' ' i LastName
select FirstName
	   ,MiddleName
	   ,LastName
	   ,concat(FirstName, ' ', isnull(MiddleName + ' ', ''), LastName) as FullName
from Person.Person

-- Firma podpisuje umow� z firm� kuriersk�. Cena us�ugi ma zale�e� od rozmiaru w drugiej kolejno�ci ci�aru, a gdy te nie s� znane od warto�ci wysy�anego przedmiotu.
-- Napisz zapytanie, kt�re wy�wietli z tabeli Production.Product:
-- - productId
-- - Name
-- - size, weight i listprice
-- - i kolumn� wyliczan�, kt�ra poka�e size (je�li jest NOT NULL), lub weight (je�li jest NOT NULL) lub listprice w przeciwnym razie
select ProductID
	   ,Name
	   ,Size, Weight, ListPrice
	   ,coalesce(Size, cast(Weight as varchar(10)), cast(ListPrice as varchar(11)), 'Reach for more info')
from Production.Product;

-- Firma kurierska oczekuje aby informacja w ostatniej kolumnie by�a dodatkowo oznaczona:
-- -je�li zawiera informacje o rozmiarze, to ma by� poprzedzona napisem S:
-- -je�li zawiera informacje o ci�arze, to ma by� poprzedzone napisem W:
-- -w przeciwnym razie ma si� pojawia� L:

select ProductID
	   ,Name
	   ,Size, Weight, ListPrice
	   ,coalesce('S: ' + Size, 'W: ' + cast(Weight as varchar(10)), 'L: ' + cast(ListPrice as varchar(11)), 'Reach for more info')
from Production.Product;
