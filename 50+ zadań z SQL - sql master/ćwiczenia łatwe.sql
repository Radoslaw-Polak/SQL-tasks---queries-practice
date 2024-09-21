use Filmy
go

select * from filmy
select * from aktorzy

select 
	kraj
from kraje

select COUNT(*) as IloscWydarzen
from Wydarzenie

-- Poka¿ œredni¹ ocen
select cast(avg(Ocena) as decimal(10, 2)) as SredniaOcena
from Recenzje

-- Poka¿ tytu³y filmów trwaj¹cych co najmniej dwie godziny
select *
from Filmy
where CzasTrwania_min >= 120

-- Poka¿ aktorów urodzonych po 1960 roku
select *
from Aktorzy 
where year(DataUrodzenia) > 1960

-- Ilu jest aktorów urodzonych w kwietniu?
select count(*) as AktorzyUrodzeniWKwietniu
from Aktorzy
where month(DataUrodzenia) = 4

-- Ile filmów zosta³o wyprodukowanych w 2002 roku?
select count(*) as Ile
from Filmy
where RokProdukcji = 2002

-- Ilu aktorów urodzi³o siê w latach 70-tych?
select count(*) as AktorzyUrodzeniWLatach70
from Aktorzy
where YEAR(DataUrodzenia) between 1970 and 1979

-- Poka¿ tytu³y 3 najnowszych filmów
select top 3 Tytul, TytulOryginalny
from Filmy
order by RokProdukcji desc

-- Poka¿ dwóch najm³odszych aktorów
select top 2 *
from Aktorzy
order by DATEDIFF(DD, DataUrodzenia, GETDATE()) 

-- Poka¿ filmy, których tytu³y zaczynaj¹ siê na literê S
select *
from Filmy
where left(Tytul, 1) = 'S'

-- Poka¿ filmy wyprodukowane po roku 2000 trwaj¹ce mniej ni¿ 2 godziny
select *
from Filmy
where RokProdukcji > 2000 and CzasTrwania_min < 120

-- Ile filmów by³o wyprodukowanych w ka¿dym roku?
select
	RokProdukcji
	,count(*) as IleFilmowNaRok
from Filmy 
group by RokProdukcji




