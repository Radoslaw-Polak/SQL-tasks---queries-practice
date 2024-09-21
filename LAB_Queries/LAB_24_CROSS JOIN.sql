use AdventureWorks2016
go

-- 1. Kierownik zastanawia si�, jak przydzieli� pracownik�w do r�nych zmian. Postanawia rozpocz��
-- od wypisania wszystkich mo�liwych kombinacji z ka�dym pracownikiem na ka�dej zmianie. 
-- Napisz polecenie, kt�re wy�wietli imi� i nazwisko pracownika (FirstName i LastName z tabeli Person.Person)
-- i nazw� zmiany (name z tabeli HumanResources.Shift)
select 
	p.FirstName
	,p.LastName
	,HRs.Name
from HumanResources.Employee as HRe
inner join Person.Person as p on HRe.BusinessEntityID = p.BusinessEntityID
cross join HumanResources.Shift as HRs

-- 2. Wy�wietl unikalne nazwy kolor�w z tabeli Production.Product
select 
	distinct pp.Color
from Production.Product as pp 

-- 3. Wy�wietl unikalne nazwy klas z tabeli Production.Product
select 
	distinct pp.Class
from Production.Product as pp 

-- 4. Dyrektor firmy zastanawia si� jakie klasy produkt�w i kolor�w
-- nale�y produkowa�. Na pocz�tek chce otrzyma� kombinacj� wszystkich
-- aktualnych klas i kolor�w. W oparciu o poprzednie zapytania utw�rz
-- nowe, kt�re po�aczy ka�dy kolor z ka�d� klas�. 
select distinct
	pp1.Class
	,pp2.Color
from Production.Product as pp1
cross join Production.Product as pp2
where pp1.Class is not null and pp2.Color is not null

-- 5. Budujemy tabel� kompetencji pracownik�w. Ka�dy pracownik ma mie� swojego
-- zast�pc� (w parach). Zaczynamy od stworzenia listy na podstawie Sales.SalesPerson,
-- kt�ra poka�e imi� i nazwisko pracownika i imi� i nazwisko jego potencjalnego zast�pcy.
-- Wy�wietlaj�c wyniki do��cz do tabeli Sales.SalesPerson tabel� Person.Person, sk�d mo�na
-- pobra� FirstName i LastName. Musisz to zrobi� 2 razy - raz aby uzyska� imi� i nazwisko 
-- pracownika i raz aby uzyska� imi� i nazwisko zast�pcy,
select 
	pp1.FirstName
	,pp1.LastName
	,pp2.FirstName
	,pp2.LastName
from Sales.SalesPerson as ssp1
inner join Person.Person as pp1 on ssp1.BusinessEntityID = pp1.BusinessEntityID
cross join Sales.SalesPerson as ssp2
inner join Person.Person as pp2 on ssp2.BusinessEntityID = pp2.BusinessEntityID
-- where pp1.FirstName <> pp2.FirstName and pp1.LastName = pp2.LastName

-- 6. Zmie� zapytanie z poprzedniego zadania tak, aby wy�wietlane pary by�y unikalne. Je�li X zast�puje Y, to nie pokazuj rekordu Y zast�puje X
select distinct
	pp1.FirstName
	,pp1.LastName
	,pp2.FirstName
	,pp2.LastName
from Sales.SalesPerson as ssp1
inner join Person.Person as pp1 on ssp1.BusinessEntityID = pp1.BusinessEntityID
cross join Sales.SalesPerson as ssp2
inner join Person.Person as pp2 on ssp2.BusinessEntityID = pp2.BusinessEntityID
--where pp1.FirstName <> pp2.FirstName and pp1.LastName = pp2.LastName