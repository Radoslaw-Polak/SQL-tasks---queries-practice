use AdventureWorks2016
go

-- 1. Kierownik zastanawia siê, jak przydzieliæ pracowników do ró¿nych zmian. Postanawia rozpocz¹æ
-- od wypisania wszystkich mo¿liwych kombinacji z ka¿dym pracownikiem na ka¿dej zmianie. 
-- Napisz polecenie, które wyœwietli imiê i nazwisko pracownika (FirstName i LastName z tabeli Person.Person)
-- i nazwê zmiany (name z tabeli HumanResources.Shift)
select 
	p.FirstName
	,p.LastName
	,HRs.Name
from HumanResources.Employee as HRe
inner join Person.Person as p on HRe.BusinessEntityID = p.BusinessEntityID
cross join HumanResources.Shift as HRs

-- 2. Wyœwietl unikalne nazwy kolorów z tabeli Production.Product
select 
	distinct pp.Color
from Production.Product as pp 

-- 3. Wyœwietl unikalne nazwy klas z tabeli Production.Product
select 
	distinct pp.Class
from Production.Product as pp 

-- 4. Dyrektor firmy zastanawia siê jakie klasy produktów i kolorów
-- nale¿y produkowaæ. Na pocz¹tek chce otrzymaæ kombinacjê wszystkich
-- aktualnych klas i kolorów. W oparciu o poprzednie zapytania utwórz
-- nowe, które po³aczy ka¿dy kolor z ka¿d¹ klas¹. 
select distinct
	pp1.Class
	,pp2.Color
from Production.Product as pp1
cross join Production.Product as pp2
where pp1.Class is not null and pp2.Color is not null

-- 5. Budujemy tabelê kompetencji pracowników. Ka¿dy pracownik ma mieæ swojego
-- zastêpcê (w parach). Zaczynamy od stworzenia listy na podstawie Sales.SalesPerson,
-- która poka¿e imiê i nazwisko pracownika i imiê i nazwisko jego potencjalnego zastêpcy.
-- Wyœwietlaj¹c wyniki do³¹cz do tabeli Sales.SalesPerson tabelê Person.Person, sk¹d mo¿na
-- pobraæ FirstName i LastName. Musisz to zrobiæ 2 razy - raz aby uzyskaæ imiê i nazwisko 
-- pracownika i raz aby uzyskaæ imiê i nazwisko zastêpcy,
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

-- 6. Zmieñ zapytanie z poprzedniego zadania tak, aby wyœwietlane pary by³y unikalne. Jeœli X zastêpuje Y, to nie pokazuj rekordu Y zastêpuje X
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