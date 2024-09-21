use Filmy
go

select * from filmy
select * from aktorzy

select 
	kraj
from kraje

select COUNT(*) as IloscWydarzen
from Wydarzenie

-- Poka� �redni� ocen
select cast(avg(Ocena) as decimal(10, 2)) as SredniaOcena
from Recenzje

-- Poka� tytu�y film�w trwaj�cych co najmniej dwie godziny
select *
from Filmy
where CzasTrwania_min >= 120

-- Poka� aktor�w urodzonych po 1960 roku
select *
from Aktorzy 
where year(DataUrodzenia) > 1960

-- Ilu jest aktor�w urodzonych w kwietniu?
select count(*) as AktorzyUrodzeniWKwietniu
from Aktorzy
where month(DataUrodzenia) = 4

-- Ile film�w zosta�o wyprodukowanych w 2002 roku?
select count(*) as Ile
from Filmy
where RokProdukcji = 2002

-- Ilu aktor�w urodzi�o si� w latach 70-tych?
select count(*) as AktorzyUrodzeniWLatach70
from Aktorzy
where YEAR(DataUrodzenia) between 1970 and 1979

-- Poka� tytu�y 3 najnowszych film�w
select top 3 Tytul, TytulOryginalny
from Filmy
order by RokProdukcji desc

-- Poka� dw�ch najm�odszych aktor�w
select top 2 *
from Aktorzy
order by DATEDIFF(DD, DataUrodzenia, GETDATE()) 

-- Poka� filmy, kt�rych tytu�y zaczynaj� si� na liter� S
select *
from Filmy
where left(Tytul, 1) = 'S'

-- Poka� filmy wyprodukowane po roku 2000 trwaj�ce mniej ni� 2 godziny
select *
from Filmy
where RokProdukcji > 2000 and CzasTrwania_min < 120

-- Ile film�w by�o wyprodukowanych w ka�dym roku?
select
	RokProdukcji
	,count(*) as IleFilmowNaRok
from Filmy 
group by RokProdukcji




