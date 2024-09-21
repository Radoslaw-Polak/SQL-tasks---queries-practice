use AdventureWorks2016
go

-- Z tabeli Person.Address wy�wietl unikalne miasta  (City)
select distinct City
from Person.Address

-- Z tej samej tabeli wy�wietl unikalne kody pocztowe (PostalCode)
select distinct PostalCode
from Person.Address

-- Z tej samej tabeli wy�wietl unikalne kombinacje miast i kod�w pocztowych
select distinct city
		,PostalCode
from Person.Address
order by city

-- Z tabeli Sales.SalesPerson wy�wietl BusinessEntityId i Bonus dla 4 pracownik�w z najwi�kszym bonusem
select top 4 
	   BusinessEntityID
	   ,Bonus
from Sales.SalesPerson
order by bonus desc

-- Je�eli s� jeszcze inne rekordy o takiej warto�ci jak ostatnia zwr�cona w poprzednim zadaniu, to maj� si� one te� wy�wietli�
select top 4 with ties
	   BusinessEntityID
	   ,Bonus
from Sales.SalesPerson
order by bonus desc

-- Wy�wietl 20% rekord�w z najwy�szymi Bonusami
select top 20 percent *
from Sales.SalesPerson
order by Bonus desc

-- Je�eli warto�ci si� powtarzaj� to r�wnie� nale�y je pokaza�
select top(20) percent with ties *
from Sales.SalesPerson
order by Bonus desc

