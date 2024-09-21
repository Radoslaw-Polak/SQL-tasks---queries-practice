use AdventureWorks2016
go

-- Z tabeli Person.Address wyœwietl unikalne miasta  (City)
select distinct City
from Person.Address

-- Z tej samej tabeli wyœwietl unikalne kody pocztowe (PostalCode)
select distinct PostalCode
from Person.Address

-- Z tej samej tabeli wyœwietl unikalne kombinacje miast i kodów pocztowych
select distinct city
		,PostalCode
from Person.Address
order by city

-- Z tabeli Sales.SalesPerson wyœwietl BusinessEntityId i Bonus dla 4 pracowników z najwiêkszym bonusem
select top 4 
	   BusinessEntityID
	   ,Bonus
from Sales.SalesPerson
order by bonus desc

-- Je¿eli s¹ jeszcze inne rekordy o takiej wartoœci jak ostatnia zwrócona w poprzednim zadaniu, to maj¹ siê one te¿ wyœwietliæ
select top 4 with ties
	   BusinessEntityID
	   ,Bonus
from Sales.SalesPerson
order by bonus desc

-- Wyœwietl 20% rekordów z najwy¿szymi Bonusami
select top 20 percent *
from Sales.SalesPerson
order by Bonus desc

-- Je¿eli wartoœci siê powtarzaj¹ to równie¿ nale¿y je pokazaæ
select top(20) percent with ties *
from Sales.SalesPerson
order by Bonus desc

