use AdventureWorks2016
go

-- z1
select 
	CardNumber
	, SUBSTRING(CardNumber, 1, 3)
from Sales.CreditCard

--z2
select
	AddressLine1
	,SUBSTRING(AddressLine1, 1, (CHARINDEX(' ',AddressLine1)))
from Person.Address

--z3
select 
	OrderDate
	,FORMAT(OrderDate, 'MM/yyyy')
from Sales.SalesOrderHeader

--z4
select
	OrderQty * UnitPrice
	,format(OrderQty * UnitPrice, '0.00 $')
from Sales.SalesOrderDetail

--z5
select
	ProductNumber
	,REPLACE(ProductNumber, '-', ' ')
from Production.Product

--z6
select
	TotalDue
	,concat(Replicate('*', 15-len(format(TotalDue, '0.0'))), format(TotalDue, '0.0'), '**')
from Sales.SalesOrderHeader
