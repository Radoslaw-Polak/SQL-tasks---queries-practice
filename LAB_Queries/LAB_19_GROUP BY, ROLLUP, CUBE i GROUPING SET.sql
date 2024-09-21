use AdventureWorks2016
go

-- roll up, uogólnianie grup od prawej do lewej
select 
	p.Color
	,p.Size
	--,p.Class
	,avg(p.ListPrice) as AveragePrice
from Production.Product as p
where p.Color is not null and p.Size is not null and p.Class is not null
group by rollup (p.Color, p.Size)

-- uogólnienie dla wszystkich grup (wartoœci z poszczególnych kolumn)
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

-- Napisz zapytanie do tabeli Sales.SalesOrderHeader. Wyfiltruj rekordy, które:
-- -Datê zamówienia (OrderDate) maj¹ miêdzy 2012-01-01 a 2012-03-31
-- -SalesPersonId ma mieæ wartoœæ (czyli nie jest null)
-- -TerritoryID  ma mieæ wartoœæ (czyli nie jest null)

select month(OrderDate) as OrderMonth
	   ,SalesPersonID
	   ,TerritoryID
	   ,cast(sum(SubTotal) as decimal(11, 2)) as SubTotalSum
from Sales.SalesOrderHeader
where OrderDate between '2012-01-01' and '2012-03-31'
and SalesPersonID is not null and TerritoryID is not null
group by month(OrderDate), TerritoryID, SalesPersonID

-- Zmieñ zapytanie tak, aby wyœwietlane by³y tak¿e podsumowania dla:
-- -Miesi¹c i SalesPersonId
-- -Miesi¹c
-- -Ogó³em
select month(OrderDate) as OrderMonth
	   ,SalesPersonID
	   ,TerritoryID
	   ,cast(sum(SubTotal) as decimal(11, 2)) as SubTotalSum
from Sales.SalesOrderHeader
where OrderDate between '2012-01-01' and '2012-03-31'
and SalesPersonID is not null and TerritoryID is not null
group by rollup(month(OrderDate), SalesPersonID, TerritoryID)

-- Zmieñ zapytanie tak aby widoczne by³y tak¿e sumy dla:
-- -Miesi¹c i TerritoryId
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

-- Zmieñ zapytanie tak, aby wyœwietli³y siê tylko sumy:
-- -miesi¹ca 
-- -miesi¹ca, SalesPersonId, TerritoryId
select month(OrderDate) as OrderMonth
	   ,SalesPersonID
	   ,TerritoryID
	   ,cast(sum(SubTotal) as decimal(11, 2)) as SubTotalSum
from Sales.SalesOrderHeader
where OrderDate between '2012-01-01' and '2012-03-31'
and SalesPersonID is not null and TerritoryID is not null
group by grouping sets ( (month(OrderDate)), (month(OrderDate), SalesPersonID, TerritoryID) ) 
