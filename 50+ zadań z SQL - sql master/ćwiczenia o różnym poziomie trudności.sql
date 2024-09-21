use Filmy
go

-- Znajd� wszystkie filmy, kt�re maj� �redni� ocen� powy�ej 4
select 
	f.Tytul
	,f.TytulOryginalny
	,cast(avg(r.Ocena) as decimal(10, 2)) as SredniaOcena
from Film_Premiera as fp
inner join Recenzje as r on fp.IdFilm_Premiera = r.IdFilm_Premiera
inner join Filmy as f on fp.IdFilmu = f.IdFilmy
group by f.Tytul, f.TytulOryginalny
having avg(r.Ocena) > 4

-- Jaki jest �redni czas trwania film�w wydanych po roku 2000
select avg(CzasTrwania_min)
from Filmy 
where RokProdukcji > 2000

-- Znajd� 5 film�w z najwi�ksz� liczb� aktor�w
select top 5
	f.Tytul
	,f.TytulOryginalny
	,count(*) as LiczbaAktorow
from Filmy as f
inner join Film_Aktor as fa on f.IdFilmy = fa.IdFilmu
group by f.Tytul, f.TytulOryginalny
order by LiczbaAktorow desc

select top 5
	f.Tytul
	,f.TytulOryginalny
	-- ,count(*) as LiczbaAktorow
from Filmy as f
inner join Film_Aktor as fa on f.IdFilmy = fa.IdFilmu
group by f.Tytul, f.TytulOryginalny
order by count(*) desc

-- Znajd� filmy, kt�re nie maj� jeszcze recenzji
with cte as (
	select 
		f.IdFilmy
		,count(*) as LiczbaRecenzji
	from Filmy as f
	inner join Film_Premiera as fp on f.IdFilmy = fp.IdFilmu
	inner join Recenzje as r on fp.IdFilm_Premiera = r.IdFilm_Premiera
	group by f.IdFilmy
)

select 
	f.Tytul
	,f.TytulOryginalny
from Filmy as f 
where f.IdFilmy not in (select IdFilmy from cte)

-- Znajd� 5 najstarszych aktor�w, kt�rzy wyst�pili w komediach
select distinct top 5
	a.ImieNazwisko
	,DATEDIFF(yy, a.DataUrodzenia, GETDATE()) as Wiek
from Film_Aktor as fa
inner join Aktorzy as a on fa.IdAktora = a.IdAktorzy
inner join Film_Gatunek as fg on fa.IdFilmu = fg.IdFilmu
inner join Gatunek as g on fg.IdGatunku = g.IdGatunek
where g.Nazwa = 'komedia'
order by DATEDIFF(yy, a.DataUrodzenia, GETDATE()) desc

with cte2 as (
	select 
		f.IdFilmy
		,count(*) as LiczbaRecenzji
	from Filmy as f
	inner join Film_Premiera as fp on f.IdFilmy = fp.IdFilmu
	inner join Recenzje as r on fp.IdFilm_Premiera = r.IdFilm_Premiera
	group by f.IdFilmy
)

-- Znajd� wszystkie nazwy wydarze�, kt�re odby�y si� w Barze u Mietka, a ich filmy nie otrzyma�y �adnej recenzji
select w.Nazwa
from Wydarzenie as w
inner join Wydarzenie_Film as wf on w.IdWydarzenie = wf.IdWydarzenia
inner join Filmy as f on wf.IdFilmu = f.IdFilmy
where w.Miejsce = 'Bar u Mietka' and
f.IdFilmy not in (select IdFilmy from cte2)

-- Wy�wietl tytu�y film�w, kt�re nie s� powi�zane z �adnym filmem
select *
from FilmyPowiazane

select 
	f.IdFilmy
	,f.Tytul
	,f.TytulOryginalny
from Filmy as f
inner join FilmyPowiazane as fp on f.IdFilmy not in (fp.IdFilmu, fp.IdPowiazanegoFilmu)

SELECT Tytul
FROM Filmy f
    LEFT JOIN FilmyPowiazane fp 
        ON f.IdFilmy = fp.IdFilmu
WHERE fp.IdFilmyPowiazane IS NULL

-- Wy�wietl aktora, kt�ry gra� w najwi�kszej liczbie film�w o r�nych gatunkach
-- to chyba by�oby bardziej wydajne gdyby by�o wi�cej rekord�w
with cte3 as (
	select 
		a.ImieNazwisko
		,count(distinct fg.IdGatunku) as LiczbaGatunkow
	from Aktorzy as a
	inner join Film_Aktor as fa on a.IdAktorzy = fa.IdAktora
	inner join Film_Gatunek as fg on fa.IdFilmu = fg.IdFilmu
	group by a.ImieNazwisko
)

select 
	ImieNazwisko
	,LiczbaGatunkow
from cte3
where LiczbaGatunkow = (select max(LiczbaGatunkow) from cte3)

select top 1
	a.ImieNazwisko
	,count(distinct fg.IdGatunku) as LiczbaGatunkow
from Aktorzy as a
inner join Film_Aktor as fa on a.IdAktorzy = fa.IdAktora
inner join Film_Gatunek as fg on fa.IdFilmu = fg.IdFilmu
group by a.ImieNazwisko
order by LiczbaGatunkow desc
--------------------------------------------------
SELECT TOP 1 a.ImieNazwisko, 
    COUNT(DISTINCT fg.IdGatunku) as LiczbaGatunkow
FROM Aktorzy a
    INNER JOIN Film_Aktor fa 
        ON a.IdAktorzy = fa.IdAktora
    INNER JOIN Film_Gatunek fg 
        ON fa.IdFilmu = fg.IdFilmu
GROUP BY a.ImieNazwisko
ORDER BY LiczbaGatunkow DESC

-- Znajd� aktora, kt�ry wyst�pi� w najwi�kszej liczbie film�w, kt�re mia�y
-- premier� w wi�cej ni� jednym kraju
with cte4 as (
	select 
		f.IdFilmy
		,count(distinct fp.IdKraju) as LiczbaKrajow
	from Filmy as f
	inner join Film_Premiera as fp on f.IdFilmy = fp.IdFilmu
	group by f.IdFilmy
)

select top 1
	a.ImieNazwisko
	,count(distinct cte4.IdFilmy) as LiczbaFilmow
from Aktorzy as a
inner join Film_Aktor as fa on a.IdAktorzy = fa.IdAktora
inner join cte4 on fa.IdFilmu = cte4.IdFilmy
where cte4.LiczbaKrajow > 1
group by a.ImieNazwisko
order by LiczbaFilmow desc

SELECT TOP 1 a.ImieNazwisko, 
    COUNT(DISTINCT fa.IdFilmu) AS LiczbaFilmow
FROM Aktorzy A
    INNER JOIN Film_Aktor fa 
        ON a.IdAktorzy = fa.IdAktora
WHERE fa.IdFilmu IN (
    SELECT fp.IdFilmu
    FROM Film_Premiera fp
    GROUP BY fp.IdFilmu
    HAVING COUNT(DISTINCT fp.IdKraju) > 1
)
GROUP BY a.ImieNazwisko
ORDER BY COUNT(DISTINCT fa.IdFilmu) DESC

-- Poka� familijne filmy wyprodukowane w USA
-- ok IdProdukcji to chyba IdKraju produkcji 
-- to wtedy chyba ma sens ��czenie po kolumnach Film_Produkcja as fp
-- fp.IdProdukcji = k.IdKraje
select 
	f.Tytul
	,f.TytulOryginalny
from Filmy as f
inner join Film_Gatunek as fg on f.IdFilmy = fg.IdFilmu
inner join Gatunek as g on fg.IdGatunku = g.IdGatunek
inner join Film_Produkcja as fp on f.IdFilmy = fp.IdFilmu
inner join Kraje as k on fp.IdProdukcji = k.IdKraje
where g.Nazwa = 'Familijny' and k.Kraj = 'USA'

SELECT f.Tytul
FROM Filmy f
    INNER JOIN Film_Produkcja fp 
        ON f.IdFilmy = fp.IdFilmu
    INNER JOIN Kraje k
        ON k.IdKraje = fp.IdProdukcji
    INNER JOIN Film_Gatunek fg 
        ON f.IdFilmy = fg.IdFilmu
    INNER JOIN Gatunek g
        ON g.IdGatunek = fg.IdGatunku
WHERE k.Kraj = 'USA' AND g.Nazwa = 'Familijny'

-- Poka� aktor�w graj�cych w Shreku 2
select 
	a.ImieNazwisko
from Aktorzy as a
inner join Film_Aktor as fa on a.IdAktorzy = fa.IdAktora
inner join Filmy as f on fa.IdFilmu = f.IdFilmy
where f.Tytul = 'Shrek 2'

SELECT a.ImieNazwisko
FROM Aktorzy a
    INNER JOIN Film_Aktor fa 
        ON a.IdAktorzy = fa.IdAktora
    INNER JOIN Filmy f 
        ON fa.IdFilmu = f.IdFilmy
WHERE f.Tytul = 'Shrek 2'

-- Poka� filmy trwaj�ce d�u�ej ni� �redni czas trwania wszystkich film�w
with cte5 as (
	select avg(f.CzasTrwania_min) as SredniCzas
	from Filmy as f
)
-- 133
-- select SredniCzas from cte5
select 
	f.Tytul
	,f.TytulOryginalny
	,f.RokProdukcji
	,f.CzasTrwania_min
from Filmy as f
where f.CzasTrwania_min > (select SredniCzas from cte5)

SELECT f.Tytul, f.CzasTrwania_min
FROM Filmy f
WHERE f.CzasTrwania_min > (SELECT AVG(CzasTrwania_min) FROM Filmy)

-- Poka� tytu�y film�w, kt�re zosta�y wyprodukowane w kraju, w kt�rym
-- mia�y swoj� premier�
select distinct
	f.Tytul
	,f.TytulOryginalny
from Filmy as f
inner join Film_Produkcja as fpro on f.IdFilmy = fpro.IdFilmu
inner join Film_Premiera as fpre on f.IdFilmy = fpre.IdFilmu 
and fpro.IdProdukcji = fpre.IdKraju