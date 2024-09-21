use AdventureWorks2016
go

select * from Sales.SalesOrderDetail

--z1
select UnitPrice, OrderQty, UnitPrice * OrderQty as SaleValue
from Sales.SalesOrderDetail

--z2
select UnitPrice, OrderQty, UnitPriceDiscount, (UnitPrice * OrderQty) * (1 - UnitPriceDiscount) as SaleValue
from Sales.SalesOrderDetail

--z3
select CardType, CardNumber, CardType + ' : ' + CardNumber
from Sales.CreditCard

--z4
select SalesOrderNumber, PurchaseOrderNumber
from Sales.SalesOrderHeader

--z5
select SalesOrderNumber, PurchaseOrderNumber, SalesOrderNumber + ' - ' + PurchaseOrderNumber
from Sales.SalesOrderHeader

-- lepiej u¿ywaæ concat
select SalesOrderNumber, PurchaseOrderNumber, concat(SalesOrderNumber, ' - ', PurchaseOrderNumber)
from Sales.SalesOrderHeader
