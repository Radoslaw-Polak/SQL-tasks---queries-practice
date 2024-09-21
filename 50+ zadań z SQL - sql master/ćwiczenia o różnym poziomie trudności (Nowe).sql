use filmy
go

-- Wyœwietl tytu³y dramatów
select 
	f.Tytul
	,f.TytulOryginalny
from Filmy as f
inner join Film_Gatunek as fg on f.IdFilmy = fg.IdFilmu
inner join Gatunek as g on fg.IdGatunku = g.IdGatunek
where g.Nazwa = 'Dramat'

-- Poka¿ aktorów urodzonych w obecnym pó³roczu (zapytanie powinno byæ uniwersalne i dzia³aæ dla daty uruchomienia zapytania)
select 
	   IdAktorzy
	   ,ImieNazwisko
	   ,case
			when (month(DataUrodzenia) between 1 and 6) and (month(getdate()) between 1 and 6) then DataUrodzenia
			when (month(DataUrodzenia) between 7 and 12) and (month(getdate()) between 7 and 12) then DataUrodzenia
	   end as HalfYearDateOfBirth
from Aktorzy
where (case
			when (month(DataUrodzenia) between 1 and 6) and (month(getdate()) between 1 and 6) then DataUrodzenia
			when (month(DataUrodzenia) between 7 and 12) and (month(getdate()) between 7 and 12) then DataUrodzenia
	  end) is not null

SELECT *
FROM Aktorzy
WHERE (MONTH(GETDATE()) <= 6 AND MONTH(DataUrodzenia) <= 6) 
    OR (MONTH(GETDATE()) >= 7 AND MONTH(DataUrodzenia) >= 7)

-- ZnajdŸ filmy, które mia³y premierê tylko w jednym kraju
select 
	f.Tytul
	,f.TytulOryginalny
from Filmy as f
inner join Film_Premiera as fp on f.IdFilmy = fp.IdFilmu
inner join Kraje as k on fp.IdKraju = k.IdKraje
group by f.Tytul, f.TytulOryginalny
having count(*) = 1

SELECT f.Tytul
FROM Filmy f
    INNER JOIN Film_Premiera fp
        ON fp.IdFilmu = f.IdFilmy
GROUP BY f.Tytul
HAVING COUNT(*) = 1

-- Kto jest najm³odszym aktorem graj¹cym w Fajerwerkach pró¿noœci?
select top 1
	a.DataUrodzenia
	,a.ImieNazwisko
from Filmy as f 
inner join Film_Aktor as fa on f.IdFilmy = fa.IdFilmu
inner join Aktorzy as a on fa.IdAktora = a.IdAktorzy
where f.Tytul = 'Fajerwerki pró¿noœci'
order by a.DataUrodzenia desc

-- Wyœwietl filmy maj¹ce premierê w Polsce, które jednoczeœnie nie mia³y œwiatowej premiery
with cte as (
	select 
		f.*
		,k.*	
    from Filmy as f
    inner join Film_Premiera as fp on f.IdFilmy = fp.IdFilmu
    inner join Kraje as k on fp.IdKraju = k.IdKraje
)

select 
	c.Tytul
	,c.TytulOryginalny
from cte c
where c.Kraj = 'Polska' and c.IdFilmy not in (select IdFilmy
										      from cte
											  where Kraj = 'œwiat')

-- ZnajdŸ aktorów, którzy zagrali w wiêcej ni¿ jednym filmie
select 
	ImieNazwisko
from Aktorzy as a
inner join Film_Aktor as fa on a.IdAktorzy = fa.IdAktora
group by ImieNazwisko
having count(*) > 1

select 
	left(ImieNazwisko, charindex(' ', ImieNazwisko, 0)-1) as Imie
	,right(ImieNazwisko, len(ImieNazwisko) - charindex(' ', ImieNazwisko, 0)) as Nazwisko
from Aktorzy as a

-- Jaki jest najd³u¿szy film, w którym wyst¹pi³ Tom Hanks?
-- To rozwi¹zanie z cte nie wymaga sortowania co mo¿e byæ chyba bardziej wydajne na ogó³
with cte1 as (
	select
		f.*
	from Filmy as f 
	inner join Film_Aktor as fa on f.IdFilmy = fa.IdFilmu
	inner join Aktorzy as a on fa.IdAktora = a.IdAktorzy
	where a.ImieNazwisko = 'Tom Hanks'
)

select
	c1.*
from cte1 c1
where c1.CzasTrwania_min = (select max(CzasTrwania_min) from cte1)

-- tutaj rozwi¹zanie z sortowaniem
select top 1
	f.*
from Filmy as f 
inner join Film_Aktor as fa on f.IdFilmy = fa.IdFilmu
inner join Aktorzy as a on fa.IdAktora = a.IdAktorzy
where a.ImieNazwisko = 'Tom Hanks'
order by f.CzasTrwania_min desc

-- Poka¿ tytu³y filmów, które mia³y premierê póŸniej ni¿ pierwsze wydarzenie w Barze u Mietka
with cte as (
	select 
		min(w.Data) as minDate
    from Filmy as f 
	inner join Wydarzenie_Film as wf on f.IdFilmy = wf.IdFilmu
	inner join Wydarzenie as w on wf.IdWydarzenia = w.IdWydarzenie
	where w.Miejsce = 'Bar u Mietka'
)

select distinct
	f.Tytul
	,f.TytulOryginalny
	,fp.DataPremiery
	,k.Kraj as [Kraj premiery]
from Filmy as f 
inner join Film_Premiera as fp on f.IdFilmy = fp.IdFilmu
inner join cte as c on fp.DataPremiery > c.minDate
inner join Kraje as k on fp.IdKraju = k.IdKraje

SELECT DISTINCT f.Tytul
FROM Filmy f
INNER JOIN Film_Premiera fp ON f.IdFilmy = fp.IdFilmu
WHERE fp.DataPremiery > (
    SELECT MIN(w.Data)
    FROM Wydarzenie w
    INNER JOIN Wydarzenie_Film wf ON w.IdWydarzenie = wf.IdWydarzenia
    WHERE w.Miejsce = 'Bar u Mietka'
)

-- Wyœwietl aktorów graj¹cych w dramatach, ale jednoczeœnie nie graj¹cych w Skazani na Shawshank
-- aktorzy graj¹cy w Skazani na Shawshank
with cte2 as (
	select 
		a.IdAktorzy
		,a.ImieNazwisko
	from Filmy as f
	inner join Film_Aktor as fa on f.IdFilmy = fa.IdFilmu
	inner join Aktorzy as a on fa.IdAktora = a.IdAktorzy
	where f.Tytul = 'Skazani na Shawshank'
)

-- wynik ostateczny
select distinct
	a.ImieNazwisko
from Filmy as f
inner join Film_Aktor as fa on f.IdFilmy = fa.IdFilmu
inner join Aktorzy as a on fa.IdAktora = a.IdAktorzy
inner join Film_Gatunek as fg on fg.IdFilmu = f.IdFilmy
inner join Gatunek as g on fg.IdGatunku = g.IdGatunek
where g.Nazwa = 'Dramat' and
	a.IdAktorzy not in (select IdAktorzy from cte2)

-- on troche zle zrobi³ bo w wyniku dosta³ Morgana Freemana który gra³ w Skazani na Shawshank
SELECT DISTINCT a.ImieNazwisko 
FROM Aktorzy a
    INNER JOIN Film_Aktor fa 
        ON a.IdAktorzy = fa.IdAktora
    INNER JOIN Film_Gatunek fg 
        ON fa.IdFilmu = fg.IdFilmu
    INNER JOIN Gatunek g 
        ON fg.IdGatunku = g.IdGatunek
WHERE g.Nazwa = 'Dramat' 
    AND fa.IdFilmu NOT IN (
        SELECT IdFilmy
        FROM Filmy
        WHERE Tytul = 'Skazani na Shawshank')

-- ZnajdŸ film z najwiêksz¹ liczb¹ aktorów
-- Rozwi¹zanie z ORDER BY i TOP 1
select top 1
	f.Tytul
	,f.TytulOryginalny
from Filmy as f 
inner join Film_Aktor as fa on f.IdFilmy = fa.IdFilmu
-- inner join Aktorzy as a on fa.IdAktora = a.IdAktorzy
group by f.Tytul, f.TytulOryginalny
order by count(*) desc

-- Rozwi¹zanie z wykorzystaniem cte, zastanawia³em siê czy nie bêdzie to wydajniejsze ni¿ uzywanie sortowania i TOP 1
with cte3 as 
(
	select
		f.Tytul
		,f.TytulOryginalny
		,count(*) as [Liczba aktorów]
	from Filmy as f 
	inner join Film_Aktor as fa on f.IdFilmy = fa.IdFilmu
	-- inner join Aktorzy as a on fa.IdAktora = a.IdAktorzy
	group by f.Tytul, f.TytulOryginalny
), cte4 as 
(
	select
		max([Liczba aktorów]) as maxLiczbaAktorow
	from cte3 
)

select 
	c3.Tytul
	,c3.TytulOryginalny
from cte3 as c3
inner join cte4 as c4 on c3.[Liczba aktorów] = c4.maxLiczbaAktorow

-- Kto gra³ w filmach Catch Me If You Can i The Bonfire of the Vanities?
-- troche przekombinowa³em z tymi podzapytaniami
with cte5 as (
	select
		f.*
		,a.*
	from Filmy as f
	inner join Film_Aktor as fa on f.IdFilmy = fa.IdFilmu
	inner join Aktorzy as a on fa.IdAktora = a.IdAktorzy
	where f.TytulOryginalny = 'Catch Me If You Can' 
), cte6 as (
	select
		a.*
	from Filmy as f
	inner join Film_Aktor as fa on f.IdFilmy = fa.IdFilmu
	inner join Aktorzy as a on fa.IdAktora = a.IdAktorzy
	where f.TytulOryginalny = 'The Bonfire of the Vanities' 
)

select 
	c5.ImieNazwisko
	,c5.DataUrodzenia
from cte5 as c5
inner join cte6 as c6 on c5.IdAktorzy = c6.IdAktorzy

-- Faktycznie lepszym rozwi¹zaniem jest pogrupowanie
SELECT a.ImieNazwisko
FROM Aktorzy a
    INNER JOIN Film_Aktor fa
        ON fa.IdAktora = a.IdAktorzy
    INNER JOIN Filmy f
        ON f.IdFilmy = fa.IdFilmu
WHERE TytulOryginalny IN ('Catch Me If You Can', 'The Bonfire of the Vanities')
GROUP BY a.ImieNazwisko
HAVING COUNT(*) > 1 -- czyli dla ka¿dego aktora zliczamy tylko te rekordy, gdzie tytu³ filmu by³ albo ten albo tamten

-- Jaki by³ najd³u¿szy film zagrany podczas wydarzenia?
select top 1
	f.Tytul
	,f.TytulOryginalny
	,f.CzasTrwania_min
from Filmy as f 
inner join Wydarzenie_Film as wf on f.IdFilmy = wf.IdFilmu 
order by f.CzasTrwania_min desc

-- Jakie filmy mia³y swoj¹ premierê po ostatniej premierze Shreka 2?
with lastShrek2Premiere as (
	select 
		max(fp.DataPremiery) as ostatniaDataPremiery
	from Filmy as f
	inner join Film_Premiera as fp on f.IdFilmy = fp.IdFilmu
	where f.Tytul = 'Shrek 2'
)

select 
	f.Tytul
	,f.TytulOryginalny
	,fp.DataPremiery
from Filmy as f
inner join Film_Premiera as fp on f.IdFilmy = fp.IdFilmu
inner join lastShrek2Premiere as lS2p on fp.DataPremiery > lS2p.ostatniaDataPremiery

SELECT DISTINCT f.Tytul
FROM filmy f
    INNER JOIN film_premiera fp 
        ON f.IdFilmy = fp.IdFilmu
WHERE fp.DataPremiery > 
    (SELECT MAX(fp.DataPremiery)
    FROM filmy f
        INNER JOIN film_premiera fp
            ON f.IdFilmy = fp.IdFilmu
    WHERE f.Tytul = 'Shrek 2')
