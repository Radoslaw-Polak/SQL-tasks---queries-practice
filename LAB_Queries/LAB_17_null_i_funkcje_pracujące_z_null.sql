use AdventureWorks2016
go

-- Wyœwietl rekordy z tabeli Person.Person, gdzie nie podano drugiego imienia (MiddleName)
select *
from Person.Person
where MiddleName is null;

-- Wyœwietl rekordy z tabeli Person.Person, gdzie drugie imiê jest podane
select *
from Person.Person
where MiddleName is not null;

-- Wyœwietl z tabeli Person.Person:
-- -FirstName
-- -MiddleName
-- -LastName
-- -napis z po³¹czenia ze sob¹ FirstName ' ' MiddleName ' ' i  LastName
select FirstName
	   ,MiddleName
	   ,LastName
	   ,concat(FirstName, ' ', MiddleName + ' ', LastName) as FullName
from Person.Person

-- Jeœli jeszcze tego nie zrobi³eœ dodaj wyra¿enie, które obs³u¿y sytuacjê, gdy MiddleName jest NULL.
-- W takim przypadku chcemy prezentowaæ tylko FirstName ' ' i LastName
select FirstName
	   ,MiddleName
	   ,LastName
	   ,concat(FirstName, ' ', isnull(MiddleName + ' ', ''), LastName) as FullName
from Person.Person

-- Firma podpisuje umowê z firm¹ kuriersk¹. Cena us³ugi ma zale¿eñ od rozmiaru w drugiej kolejnoœci ciê¿aru, a gdy te nie s¹ znane od wartoœci wysy³anego przedmiotu.
-- Napisz zapytanie, które wyœwietli z tabeli Production.Product:
-- - productId
-- - Name
-- - size, weight i listprice
-- - i kolumnê wyliczan¹, która poka¿e size (jeœli jest NOT NULL), lub weight (jeœli jest NOT NULL) lub listprice w przeciwnym razie
select ProductID
	   ,Name
	   ,Size, Weight, ListPrice
	   ,coalesce(Size, cast(Weight as varchar(10)), cast(ListPrice as varchar(11)), 'Reach for more info')
from Production.Product;

-- Firma kurierska oczekuje aby informacja w ostatniej kolumnie by³a dodatkowo oznaczona:
-- -jeœli zawiera informacje o rozmiarze, to ma byæ poprzedzona napisem S:
-- -jeœli zawiera informacje o ciê¿arze, to ma byæ poprzedzone napisem W:
-- -w przeciwnym razie ma siê pojawiaæ L:

select ProductID
	   ,Name
	   ,Size, Weight, ListPrice
	   ,coalesce('S: ' + Size, 'W: ' + cast(Weight as varchar(10)), 'L: ' + cast(ListPrice as varchar(11)), 'Reach for more info')
from Production.Product;
