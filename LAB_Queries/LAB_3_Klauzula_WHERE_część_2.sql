use AdventureWorks2016
go

--z1
select * from HumanResources.Employee
where JobTitle like '%Specialist%'

--z2
select * from HumanResources.Employee
where JobTitle like '%Specialist%' and JobTitle like '%Marketing%'

--z3
select * from HumanResources.Employee
where JobTitle like '%Specialist%' or JobTitle like '%Marketing%'

--z4
select * from Production.Product
where [Name] like '%[0-9]%'

--z5
select * from Production.Product
where [Name] like '%[0-9][0-9]%'

--z6
select * from Production.Product
where [Name] like '%[0-9][0-9]%[^0-9]'

--z7
select * from Production.Product
where [Name] like '____'

