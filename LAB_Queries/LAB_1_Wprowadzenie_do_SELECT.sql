USE AdventureWorks2016
GO

--select *from production.product
--GO

/*
select 
	ProductID
	,Name
	,ListPrice
	,Color
from production.product
GO
*/

select 
	ProductID
	,Name
	,ListPrice
	,Color
from production.product
where Color='blue'
GO

select 
	ProductID
	,Name
	,ListPrice
	--,Color
from production.product
where Color='blue'

use tempdb
go

select*
from AdventureWorks2016.Production.ScrapReason
go

