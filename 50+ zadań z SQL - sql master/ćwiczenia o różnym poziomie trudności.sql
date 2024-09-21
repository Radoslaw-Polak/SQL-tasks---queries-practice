use Filmy
go

-- ZnajdŸ wszystkie filmy, które maj¹ œredni¹ ocenê powy¿ej 4
select 
	f.Tytul
	,f.TytulOryginalny
	,cast(avg(r.Ocena) as decimal(10, 2)) as SredniaOcena
from Film_Premiera as fp
inner join Recenzje as r on fp.IdFilm_Premiera = r.IdFilm_Premiera
inner join Filmy as f on fp.IdFilmu = f.IdFilmy
group by f.Tytul, f.TytulOryginalny
having avg(r.Ocena) > 4

-- Jaki jest œredni czas trwania filmów wydanych po roku 2000
select avg(CzasTrwania_min)
from Filmy 
where RokProdukcji > 2000

-- ZnajdŸ 5 filmów z najwiêksz¹ liczb¹ aktorów
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

-- ZnajdŸ filmy, które nie maj¹ jeszcze recenzji
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

-- ZnajdŸ 5 najstarszych aktorów, którzy wyst¹pili w komediach
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

-- ZnajdŸ wszystkie nazwy wydarzeñ, które odby³y siê w Barze u Mietka, a ich filmy nie otrzyma³y ¿adnej recenzji
select w.Nazwa
from Wydarzenie as w
inner join Wydarzenie_Film as wf on w.IdWydarzenie = wf.IdWydarzenia
inner join Filmy as f on wf.IdFilmu = f.IdFilmy
where w.Miejsce = 'Bar u Mietka' and
f.IdFilmy not in (select IdFilmy from cte2)

-- Wyœwietl tytu³y filmów, które nie s¹ powi¹zane z ¿adnym filmem
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

-- Wyœwietl aktora, który gra³ w najwiêkszej liczbie filmów o ró¿nych gatunkach
-- to chyba by³oby bardziej wydajne gdyby by³o wiêcej rekordów
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

-- ZnajdŸ aktora, który wyst¹pi³ w najwiêkszej liczbie filmów, które mia³y
-- premierê w wiêcej ni¿ jednym kraju
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

-- Poka¿ familijne filmy wyprodukowane w USA
-- ok IdProdukcji to chyba IdKraju produkcji 
-- to wtedy chyba ma sens ³¹czenie po kolumnach Film_Produkcja as fp
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

-- Poka¿ aktorów graj¹cych w Shreku 2
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

-- Poka¿ filmy trwaj¹ce d³u¿ej ni¿ œredni czas trwania wszystkich filmów
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

-- Poka¿ tytu³y filmów, które zosta³y wyprodukowane w kraju, w którym
-- mia³y swoj¹ premierê
select distinct
	f.Tytul
	,f.TytulOryginalny
from Filmy as f
inner join Film_Produkcja as fpro on f.IdFilmy = fpro.IdFilmu
inner join Film_Premiera as fpre on f.IdFilmy = fpre.IdFilmu 
and fpro.IdProdukcji = fpre.IdKraju