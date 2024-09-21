use AdventureWorks2016
go

-- roll up, uog�lnianie grup od prawej do lewej
select 
	p.Color
	,p.Size
	--,p.Class
	,avg(p.ListPrice) as AveragePrice
from Production.Product as p
where p.Color is not null and p.Size is not null and p.Class is not null
group by rollup (p.Color, p.Size)

-- uog�lnienie dla wszystkich grup (warto�ci z poszczeg�lnych kolumn)
select 
	p.Color
	,p.Size
	,p.Class
	,avg(p.ListPrice) as AveragePrice
from Production.Product as p
where p.Color is not null and p.Size is not null and p.Class is not null
group by cube (p.Color, p.Size, p.Class)

-- grouping sets
select 
	p.Color
	,p.Size
	,p.Class
	,avg(p.ListPrice) as AveragePrice
from Production.Product as p
where p.Color is not null and p.Size is not null and p.Class is not null
group by grouping sets ((p.Color), (p.Size), (p.Color, p.Size, p.Class))

select 
	p.Color
	,p.Size
	,p.Class
	,avg(p.ListPrice) as AveragePrice
from Production.Product as p
where p.Color is not null and p.Size is not null and p.Class is not null
group by grouping sets (p.Color, p.Size, p.Class)

-- Napisz zapytanie do tabeli Sales.SalesOrderHeader. Wyfiltruj rekordy, kt�re:
-- -Dat� zam�wienia (OrderDate) maj� mi�dzy 2012-01-01 a 2012-03-31
-- -SalesPersonId ma mie� warto�� (czyli nie jest null)
-- -TerritoryID  ma mie� warto�� (czyli nie jest null)

select month(OrderDate) as OrderMonth
	   ,SalesPersonID
	   ,TerritoryID
	   ,cast(sum(SubTotal) as decimal(11, 2)) as SubTotalSum
from Sales.SalesOrderHeader
where OrderDate between '2012-01-01' and '2012-03-31'
and SalesPersonID is not null and TerritoryID is not null
group by month(OrderDate), TerritoryID, SalesPersonID

-- Zmie� zapytanie tak, aby wy�wietlane by�y tak�e podsumowania dla:
-- -Miesi�c i SalesPersonId
-- -Miesi�c
-- -Og�em
select month(OrderDate) as OrderMonth
	   ,SalesPersonID
	   ,TerritoryID
	   ,cast(sum(SubTotal) as decimal(11, 2)) as SubTotalSum
from Sales.SalesOrderHeader
where OrderDate between '2012-01-01' and '2012-03-31'
and SalesPersonID is not null and TerritoryID is not null
group by rollup(month(OrderDate), SalesPersonID, TerritoryID)

-- Zmie� zapytanie tak aby widoczne by�y tak�e sumy dla:
-- -Miesi�c i TerritoryId
-- -SalesPersonId i TerritoryId
-- -SalesPersonId
-- -TerritoryId
select month(OrderDate) as OrderMonth
	   ,SalesPersonID
	   ,TerritoryID
	   ,cast(sum(SubTotal) as decimal(11, 2)) as SubTotalSum
from Sales.SalesOrderHeader
where OrderDate between '2012-01-01' and '2012-03-31'
and SalesPersonID is not null and TerritoryID is not null
group by cube(month(OrderDate), SalesPersonID, TerritoryID)

-- Zmie� zapytanie tak, aby wy�wietli�y si� tylko sumy:
-- -miesi�ca 
-- -miesi�ca, SalesPersonId, TerritoryId
select month(OrderDate) as OrderMonth
	   ,SalesPersonID
	   ,TerritoryID
	   ,cast(sum(SubTotal) as decimal(11, 2)) as SubTotalSum
from Sales.SalesOrderHeader
where OrderDate between '2012-01-01' and '2012-03-31'
and SalesPersonID is not null and TerritoryID is not null
group by grouping sets ( (month(OrderDate)), (month(OrderDate), SalesPersonID, TerritoryID) ) 
