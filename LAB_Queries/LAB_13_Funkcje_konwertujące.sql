use AdventureWorks2016
go

-- 1
select *
from HumanResources.Shift;

select
	'Shift ' + cast(ShiftID as char(1)) + ' starts at ' + CAST(starttime as varchar(5)) as test
from HumanResources.Shift

-- 2
select
	LoginID
	,convert(varchar(10), HireDate, 104) as formattedHireDate
from HumanResources.Employee

--3
declare @my_birth_date char(30) = '23 wrzesien 2001'
select PARSE(@my_birth_date as date using 'pl-PL')

--4
select PARSE('12 lipusa 2001' as date using 'pl-PL')

--5
select TRY_PARSE('12 lipusa 2001' as date using 'pl-PL')