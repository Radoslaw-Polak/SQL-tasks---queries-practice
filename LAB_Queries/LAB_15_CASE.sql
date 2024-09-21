-- W tabeli Person.PhoneNumberType znajduj� si� opisy rodzaj�w telefon�w. Na potrzeby raportu nale�y:
-- -wy�wietli�  'mobile phone' gdy nazwa to 'cell'
-- -wy�wietli� 'Stationary' gdy nazwa to 'Home' lub 'Work'
-- -w pozosta�ych przypadkach wy�wietli� 'Other'

use AdventureWorks2016
go

select *
	   ,case
			when name = 'Cell' then 'mobile phone'
			when name in ('Work', 'Home') then 'Stationary'
			else 'Other'
	   end as result
from person.PhoneNumberType;

select *
	   ,case name
			when 'Cell' then 'mobile phone'
			when 'Home' then 'Stationary'
			when 'Work' then 'Stationary'
			else 'Other'
	   end as result
from person.PhoneNumberType;

select ProductID	
	   ,Name
	   ,Size
	   ,case Size
			when 'S' then 'SMALL'
			when 'M' then 'MEDIUM'
			when 'L' then 'LARGE'
			when 'XL' then 'EXTRA LARGE'
		end as size_full
from Production.Product
