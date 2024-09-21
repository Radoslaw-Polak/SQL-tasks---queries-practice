use Sklep_Kurs_SQL
go

select *
from Produkty
where Cena between 1000 and 3000;

select *
from Pracownicy
where IdPrzelozonego is null;

select *
from Produkty
where Nazwa like '%Samsung%';

select *
from Produkty
where lower(Nazwa) like '%lego%';

select Nazwa
from Produkty
where Nazwa like 'hot wheels%'
order by Nazwa;

select top 3 *
from Produkty
order by Cena desc;

select *
from Pracownicy
where year(DataZatrudnienia) between 2010 and 2015; 

select *
from Pracownicy
where Imie in ('Anna', 'Tomasz', 'Kamila');

select *
from ZakupySklepOnline
where Komentarz <> '';

select *
from Pracownicy
where PensjaPodstawowa < 2000 and IdPrzelozonego is not null;

select Imie, Nazwisko, DataZatrudnienia
from Pracownicy
where Imie = 'Natalia' and Nazwisko = 'Rebuœ';

select *
from ZakupySklepOnline
where month(DataZakupu) = 3 and YEAR(DataZakupu) = 2020;

select *
from ZakupySklepOnline
where MONTH(DataZakupu) <= 6 and YEAR(DataZakupu) = 2020;

select *
from Dostawcy
where Miasto not like 'Wroc_aw';

select *
from Produkty
where Nazwa like '%star wars%';

select *
from Produkty
where Nazwa like 'nikon%body%';

select *
from Produkty
where Cena > 5000 and Nazwa like 'Canon%[0-9]D%'; 

select *
from Produkty
where Nazwa like '[^Lego]%star wars%';

select *
from Pracownicy
where DataZatrudnienia > '2010-01-01' and Imie like '%a';

select *
from Pracownicy
where year(DataZatrudnienia) between 2011 and 2016 and Imie not like '%a'; 

select Nazwa
from Produkty
where Cena < 100 and Nazwa not like '%lego%';

select *
from Pracownicy
order by DataZatrudnienia;

select Imie, Nazwisko
from Pracownicy
order by PensjaPodstawowa;

select *
from Pracownicy
where Imie = 'Anna'
order by Nazwisko desc;

select top 4 *
from Produkty
where IdKategorii = 2
order by Cena;

select top 2 *
from Produkty
where Nazwa like '%lego%'
order by Cena;

select top 1 *
from Produkty
where Nazwa like '%apple%'
order by Cena desc;

select top 3 *
from Produkty
where Nazwa like 'Nikon%D[0-9]%'
order by Cena desc;

select *
from Produkty
where Nazwa like '%star wars%'
order by Nazwa;