use AdventureWorks2016
go

-- W przyk³adach z poprzedniej lekcji, usuñ klauzulê WHERE  dodaj wywo³ania GROUPPING_ID w taki sposób, ¿e:
-- - po ka¿dej kolumnie (oprócz podsumowywanej wartoœci) ma siê  pojawiæ liczba wskazuj¹ca na to czy wartoœæ
-- jest wartoœci¹ pochodz¹c¹ z tabeli czy jest dodana przez agregacjê

-- - w ostatniej kolumnie ma siê naleŸæ liczba, która zinterpretowana jako suma potêg dwójki pozwoli rozpoznaæ,
-- które wartoœci s¹ dodane do zbioru poprzez agregacjê


-- Napisz zapytanie do tabeli Sales.SalesOrderHeader. Wyfiltruj rekordy, które:
-- -Datê zamówienia (OrderDate) maj¹ miêdzy 2012-01-01 a 2012-03-31
-- -SalesPersonId ma mieæ wartoœæ (czyli nie jest null)
-- -TerritoryID  ma mieæ wartoœæ (czyli nie jest null)
select month(OrderDate) as OrderMonth, GROUPING_ID(month(OrderDate)) as AggregatedByMonth
	   ,SalesPersonID, GROUPING_ID(SalesPersonID) as [Is SalesPersonId aggregated]
	   ,TerritoryID, grouping_id(TerritoryID) as [Is TerritoryID aggregated]
	   ,cast(sum(SubTotal) as decimal(11, 2)) as SubTotalSum
	   ,GROUPING_ID(month(OrderDate), SalesPersonID, TerritoryID) as [Aggregation mask]
from Sales.SalesOrderHeader
where OrderDate between '2012-01-01' and '2012-03-31'
-- and SalesPersonID is not null and TerritoryID is not null
group by month(OrderDate), TerritoryID, SalesPersonID

-- Zmieñ zapytanie tak, aby wyœwietlane by³y tak¿e podsumowania dla:
-- -Miesi¹c i SalesPersonId
-- -Miesi¹c
-- -Ogó³em
select month(OrderDate) as OrderMonth, GROUPING_ID(month(OrderDate)) as AggregatedByMonth
	   ,SalesPersonID, GROUPING_ID(SalesPersonID) as [Is SalesPersonID aggregated]
	   ,TerritoryID, grouping_id(TerritoryID) [Is TerritoryID aggregated]
	   ,cast(sum(SubTotal) as decimal(11, 2)) as SubTotalSum
	   ,GROUPING_ID(month(OrderDate), SalesPersonID, TerritoryID) as [Aggregation mask]
from Sales.SalesOrderHeader
where OrderDate between '2012-01-01' and '2012-03-31'
-- and SalesPersonID is not null and TerritoryID is not null
group by rollup(month(OrderDate), SalesPersonID, TerritoryID)

-- Zmieñ zapytanie tak aby widoczne by³y tak¿e sumy dla:
-- -Miesi¹c i TerritoryId
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

-- Zmieñ zapytanie tak, aby wyœwietli³y siê tylko sumy:
-- -miesi¹ca 
-- -miesi¹ca, SalesPersonId, TerritoryId
select month(OrderDate) as OrderMonth, GROUPING_ID(month(OrderDate)) as AggregatedByMonth
	   ,SalesPersonID, GROUPING_ID(SalesPersonID) as [Is SalesPersonId aggregated]
	   ,TerritoryID, grouping_id(TerritoryID) as [Is TerritoryID aggregated]
	   ,cast(sum(SubTotal) as decimal(11, 2)) as SubTotalSum
	   ,GROUPING_ID(month(OrderDate), SalesPersonID, TerritoryID) as [Aggregation mask]
from Sales.SalesOrderHeader
where OrderDate between '2012-01-01' and '2012-03-31'
-- and SalesPersonID is not null and TerritoryID is not null
group by grouping sets ( (month(OrderDate)), (month(OrderDate), SalesPersonID, TerritoryID) ) 