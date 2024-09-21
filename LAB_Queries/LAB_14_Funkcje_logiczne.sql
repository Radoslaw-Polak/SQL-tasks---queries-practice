use AdventureWorks2016
go

select *,
	iif(DATEDIFF(year, HireDate, GETDATE())>15, 'Old stager', 'Adept') as employeeOverview
from HumanResources.Employee;

select *,
	iif(DATEDIFF(year, HireDate, GETDATE())>16, 'Old stager', iif(DATEDIFF(year, HireDate, GETDATE())>13, 'Veteran', 'Adept')) as employeeOverview
from HumanResources.Employee;

select SalesOrderID
	   ,OrderDate
	   ,CHOOSE(datepart(dw, OrderDate)
	   ,'lunes'
	   ,'martes'
	   ,'miércoles'
	   ,'jueves'
	   ,'viernes'
	   ,'sábado'
	   ,'domingo') weekday_spanish
from Sales.SalesOrderHeader