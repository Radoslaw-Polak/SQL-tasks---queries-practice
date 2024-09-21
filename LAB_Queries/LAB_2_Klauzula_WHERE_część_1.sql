USE AdventureWorks2016
GO

-- z1
select *from HumanResources.Employee

--z2
select *from HumanResources.Employee
where BirthDate > '1980-01-01'

--z3
select *from HumanResources.Employee
where  year(BirthDate) = 1980

--z4
select *from HumanResources.Employee
where  year(BirthDate) = 1980 and Gender = 'M'


--z5
select 
	JobTitle
	,BirthDate
	,Gender 
	,VacationHours
from HumanResources.Employee
where 
	(VacationHours between 90 and 99 and Gender = 'M')
	or
	(VacationHours between 80 and 89 and Gender = 'F')


--z6
select JobTitle, BirthDate, Gender, VacationHours
from HumanResources.Employee
where 
	(VacationHours between 90 and 99 and Gender = 'M'
	or
	VacationHours between 80 and 89 and Gender = 'F')
	and
	BirthDate > '1990-01-01'


--z7
select* from HumanResources.Employee
where 
	JobTitle in ('Marketing Specialist', 'Control Specialist',
				 'Benefits Specialist', 'Accounts Receivable Specialist')
