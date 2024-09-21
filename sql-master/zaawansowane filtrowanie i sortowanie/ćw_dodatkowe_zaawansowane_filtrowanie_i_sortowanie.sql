use Sklep_Kurs_SQL
go

select top 3 *
from Pracownicy
where Imie like '%a' and PensjaPodstawowa >= 3000;

select top 1 *
from Produkty
where Nazwa like 'Nikon%body%'
order by Cena;

select *
from Produkty
where Nazwa like '%[^0-9][5-8][0-8][0-9]W%';

select Imie
	   ,Nazwisko
from Pracownicy
where Imie not like '%a' and (PensjaPodstawowa > 3000 or Premia >= 20);

select top 1 *
from Produkty
where Nazwa not like '%body%' and Nazwa like '%Canon%'
order by Cena desc

select *
from Produkty
where (Nazwa not like '%lego%' or Nazwa like '%star wars%') and Cena between 50 and 100

select *
from Produkty
where Nazwa like '%mikrofalowa%[^0-9][8][5-9][0-9]W%'
or Nazwa like '%mikrofalowa%[^0-9][9][0-9][0-9]W%'


