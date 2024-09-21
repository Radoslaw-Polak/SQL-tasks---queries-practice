use AdventureWorks2016
go

select
	SalesOrderID
	,TaxAmt
	,FLOOR(TaxAmt/1000) * 1000 as pointer
from Sales.SalesOrderHeader;

select CEILING(RAND()*49);

select
	TaxAmt
	,ROUND(TaxAmt, 0) as roundTaxAmt
	,ROUND(TaxAmt, -3) as thousands 
from Sales.SalesOrderHeader
