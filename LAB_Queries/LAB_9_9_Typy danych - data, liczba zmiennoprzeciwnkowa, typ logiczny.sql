use AdventureWorks2016

DECLARE @f DECIMAL =1.1
SELECT @f/2 ,@f/4 ,@f/8 ,@f/16 ,@f/32 ,@f/64 ,@f/128 ,@f/256 ,@f/512 ,@f/1024 ,@f/2048 ,@f/4096 ,@f/8192 ,@f/16384 ,@f/32768 
GO

DECLARE @f real=1.1
SELECT @f/2 ,@f/4 ,@f/8 ,@f/16 ,@f/32 ,@f/64 ,@f/128 ,@f/256 ,@f/512 ,@f/1024 ,@f/2048 ,@f/4096 ,@f/8192 ,@f/16384 ,@f/32768 
GO

DECLARE @f float=1.1
SELECT @f/2 ,@f/4 ,@f/8 ,@f/16 ,@f/32 ,@f/64 ,@f/128 ,@f/256 ,@f/512 ,@f/1024 ,@f/2048 ,@f/4096 ,@f/8192 ,@f/16384 ,@f/32768 
GO

DECLARE @f money=1.1
SELECT @f/2 ,@f/4 ,@f/8 ,@f/16 ,@f/32 ,@f/64 ,@f/128 ,@f/256 ,@f/512 ,@f/1024 ,@f/2048 ,@f/4096 ,@f/8192 ,@f/16384 ,@f/32768 
GO

declare @f float=-1
select
@f +1
,@f + 0.5 +0.5
,@f+0.5+0.25+0.25
,@f+0.1+0.1+0.1+0.1+0.1+0.1+0.1+0.1+0.1+0.1

declare @d2 datetime2 = SYSDATETIME()
declare @time time = SYSDATETIME()
declare @datetime datetime = GetDate()

select 
	@d2
	,@time
	,@datetime

select *
from Sales.SalesOrderHeader