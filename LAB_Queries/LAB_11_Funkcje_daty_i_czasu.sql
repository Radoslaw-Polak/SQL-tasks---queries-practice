use AdventureWorks2016
go

select GETDATE();

select 
	   SalesOrderID
	   ,OrderDate
	   ,YEAR(OrderDate) as year
	   ,MONTH(OrderDate) as month
	   ,DAY(OrderDate) as day
	   ,DATEPART(wk, OrderDate) as weekday
	   ,DATEPART(dw, OrderDate) as no_weekday
from Sales.SalesOrderHeader;
	   
select 
	   SalesOrderID
	   ,OrderDate
	   ,YEAR(OrderDate) as year
	   ,datename(M, OrderDate) as month
	   ,DAY(OrderDate) as day
	   ,DATENAME(dw, OrderDate) as weekday
	   ,DATEPART(dw, OrderDate) as no_weekday
from Sales.SalesOrderHeader;

set datefirst 1
select DATENAME(DW, '2001-09-23');

select 
	LoginID
	,BirthDate
	,DATEFROMPARTS(YEAR(GETDATE()), MONTH(BirthDate), 1) as first_day_of_month
	,EOMONTH(DATEFROMPARTS(YEAR(GETDATE()), month(BirthDate), day(BirthDate))) as last_day_of_month
from HumanResources.Employee;

select
	SalesOrderID
	,OrderDate
	,DueDate
	,DATEDIFF(D, OrderDate, DueDate) as OrderCompletionTime
from Sales.SalesOrderHeader

declare @my_birth_date date = '2001-09-23'
declare @age_years float = datediff(YEAR, '2001-09-23', getdate())
declare @age_days float = datediff(DAY, '2001-09-23', getdate())

select @age_years
	   ,@age_days

declare @dayOfBirth date = 
	(select 
		BirthDate
	from HumanResources.Employee
	where LoginID = 'adventure-works\diane1'
	);

select @dayOfBirth;

select *
from HumanResources.Employee
where abs(YEAR(@dayOfBirth) - YEAR(BirthDate)) <= 1;

