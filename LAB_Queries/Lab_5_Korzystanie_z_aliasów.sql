use AdventureWorks2016
go

--v1
SELECT UnitPrice*OrderQty as Total 
FROM Sales.SalesOrderDetail

SELECT UnitPrice, UnitPriceDiscount, (UnitPrice-UnitPriceDiscount)*OrderQty as TotalWithDiscount 
FROM Sales.SalesOrderDetail 

SELECT Cardtype + ':' + CardNumber as 'CardType and CardNumber' 
FROM Sales.CreditCard

SELECT 
 SalesOrderNumber
 ,PurchaseOrderNumber 
 ,SalesOrderNumber + '-' + PurchaseOrderNumber as 'Sales And Purchase Order Number'
FROM Sales.SalesOrderHeader

--v2
SELECT 
 SalesOrderNumber
 ,ProductID
 ,UnitPrice
 ,TaxAmt
FROM Sales.SalesOrderHeader 
JOIN Sales.SalesOrderDetail ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID

--skrócenie powy¿szego zapytania dodaj¹c aliasy
SELECT 
 SalesOrderNumber
 ,ProductID
 ,UnitPrice
 ,TaxAmt
FROM Sales.SalesOrderHeader as ssoh
JOIN Sales.SalesOrderDetail as ssod ON ssoh.SalesOrderID = ssod.SalesOrderID

--v3
SELECT 
 sod.ProductID
 ,sod.SalesOrderID
 ,sod.OrderQty * sod.UnitPrice AS Total
FROM Sales.SalesOrderDetail sod 
WHERE sod.OrderQty * sod.UnitPrice  > 10000

