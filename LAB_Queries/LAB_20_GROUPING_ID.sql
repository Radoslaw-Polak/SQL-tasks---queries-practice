use AdventureWorks2016
go

-- W przyk�adach z poprzedniej lekcji, usu� klauzul� WHERE  dodaj wywo�ania GROUPPING_ID w taki spos�b, �e:
-- - po ka�dej kolumnie (opr�cz podsumowywanej warto�ci) ma si�  pojawi� liczba wskazuj�ca na to czy warto��
-- jest warto�ci� pochodz�c� z tabeli czy jest dodana przez agregacj�

-- - w ostatniej kolumnie ma si� nale�� liczba, kt�ra zinterpretowana jako suma pot�g dw�jki pozwoli rozpozna�,
-- kt�re warto�ci s� dodane do zbioru poprzez agregacj�


-- Napisz zapytanie do tabeli Sales.SalesOrderHeader. Wyfiltruj rekordy, kt�re:
-- -Dat� zam�wienia (OrderDate) maj� mi�dzy 2012-01-01 a 2012-03-31
-- -SalesPersonId ma mie� warto�� (czyli nie jest null)
-- -TerritoryID  ma mie� warto�� (czyli nie jest null)
select month(OrderDate) as OrderMonth, GROUPING_ID(month(OrderDate)) as AggregatedByMonth
	   ,SalesPersonID, GROUPING_ID(SalesPersonID) as [Is SalesPersonId aggregated]
	   ,TerritoryID, grouping_id(TerritoryID) as [Is TerritoryID aggregated]
	   ,cast(sum(SubTotal) as decimal(11, 2)) as SubTotalSum
	   ,GROUPING_ID(month(OrderDate), SalesPersonID, TerritoryID) as [Aggregation mask]
from Sales.SalesOrderHeader
where OrderDate between '2012-01-01' and '2012-03-31'
-- and SalesPersonID is not null and TerritoryID is not null
group by month(OrderDate), TerritoryID, SalesPersonID

-- Zmie� zapytanie tak, aby wy�wietlane by�y tak�e podsumowania dla:
-- -Miesi�c i SalesPersonId
-- -Miesi�c
-- -Og�em
select month(OrderDate) as OrderMonth, GROUPING_ID(month(OrderDate)) as AggregatedByMonth
	   ,SalesPersonID, GROUPING_ID(SalesPersonID) as [Is SalesPersonID aggregated]
	   ,TerritoryID, grouping_id(TerritoryID) [Is TerritoryID aggregated]
	   ,cast(sum(SubTotal) as decimal(11, 2)) as SubTotalSum
	   ,GROUPING_ID(month(OrderDate), SalesPersonID, TerritoryID) as [Aggregation mask]
from Sales.SalesOrderHeader
where OrderDate between '2012-01-01' and '2012-03-31'
-- and SalesPersonID is not null and TerritoryID is not null
group by rollup(month(OrderDate), SalesPersonID, TerritoryID)

-- Zmie� zapytanie tak aby widoczne by�y tak�e sumy dla:
-- -Miesi�c i TerritoryId
-- -SalesPersonId i TerritoryId
-- -SalesPersonId
-- -TerritoryId
select month(OrderDate) as OrderMonth, GROUPING_ID(month(OrderDate)) as AggregatedByMonth
	   ,SalesPersonID, GROUPING_ID(SalesPersonID) as [Is SalesPersonID aggregated]
	   ,TerritoryID, grouping_id(TerritoryID) [Is TerritoryID aggregated]
	   ,cast(sum(SubTotal) as decimal(11, 2)) as SubTotalSum
	   ,GROUPING_ID(month(OrderDate), SalesPersonID, TerritoryID) as [Aggregation mask]
from Sales.SalesOrderHeader
where OrderDate between '2012-01-01' and '2012-03-31'
-- and SalesPersonID is not null and TerritoryID is not null
group by cube(month(OrderDate), SalesPersonID, TerritoryID)

-- Zmie� zapytanie tak, aby wy�wietli�y si� tylko sumy:
-- -miesi�ca 
-- -miesi�ca, SalesPersonId, TerritoryId
select month(OrderDate) as OrderMonth, GROUPING_ID(month(OrderDate)) as AggregatedByMonth
	   ,SalesPersonID, GROUPING_ID(SalesPersonID) as [Is SalesPersonId aggregated]
	   ,TerritoryID, grouping_id(TerritoryID) as [Is TerritoryID aggregated]
	   ,cast(sum(SubTotal) as decimal(11, 2)) as SubTotalSum
	   ,GROUPING_ID(month(OrderDate), SalesPersonID, TerritoryID) as [Aggregation mask]
from Sales.SalesOrderHeader
where OrderDate between '2012-01-01' and '2012-03-31'
-- and SalesPersonID is not null and TerritoryID is not null
group by grouping sets ( (month(OrderDate)), (month(OrderDate), SalesPersonID, TerritoryID) ) 