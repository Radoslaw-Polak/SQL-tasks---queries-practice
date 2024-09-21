use filmy
go

-- W jakich filmach gra³ Tom Hanks?
select f.RokProdukcji
	   ,f.Tytul
	   ,f.TytulOryginalny
	   ,f.CzasTrwania_min
from Filmy as f
inner join Film_Aktor as fa on f.IdFilmy = fa.IdFilmu
inner join Aktorzy as a on fa.IdAktora = a.IdAktorzy
where a.ImieNazwisko = 'Tom Hanks'

-- W ilu filmach gra³ ka¿dy aktor?
select a.IdAktorzy
	   ,a.ImieNazwisko
	   ,count(*) as LiczbaFilmow
from Film_Aktor as fa
right join Aktorzy as a on fa.IdAktora = a.IdAktorzy
group by a.IdAktorzy, a.ImieNazwisko
order by a.ImieNazwisko

-- Którzy aktorzy grali w przynajmniej dwóch filmach?
select a.IdAktorzy
	   ,a.ImieNazwisko
	   ,count(*) as LiczbaFilmow
from Film_Aktor as fa
right join Aktorzy as a on fa.IdAktora = a.IdAktorzy
group by a.IdAktorzy, a.ImieNazwisko
having count(*) >= 2

-- Poka¿ œredni¹ ocenê ka¿dego filmu
select 
	f.Tytul
	,f.TytulOryginalny
	,f.RokProdukcji
	,f.CzasTrwania_min
	,cast(avg(r.Ocena) as decimal(10, 2)) as SredniaOcena
from Recenzje as r
inner join Film_Premiera as fp on r.IdFilm_Premiera = fp.IdFilm_Premiera
inner join Filmy as f on fp.IdFilmu = f.IdFilmy
group by f.Tytul, f.TytulOryginalny, f.RokProdukcji, f.CzasTrwania_min

-- Ile jest filmów familijnych?
select 
	g.Nazwa
	,count(*) LiczbaFilmow
from Film_Gatunek as fg
inner join Gatunek as g on fg.IdGatunku = g.IdGatunek
where g.Nazwa = 'Familijny'
group by g.Nazwa

-- W filmach z jakiego gatunku gra³ Morgan Freeman?
select distinct
	g.Nazwa
from Filmy as f
inner join Film_Gatunek as fg on f.IdFilmy = fg.IdFilmu
inner join Gatunek as g on fg.IdGatunku = g.IdGatunek
inner join Film_Aktor as fa on f.IdFilmy = fa.IdFilmu
inner join Aktorzy as a on fa.IdAktora = a.IdAktorzy
where a.ImieNazwisko = 'Morgan Freeman'

-- W którym kraju wyprodukowano najwiêcej filmów?
select top 1
	k.Kraj
	,count(*) as LiczbaFilmow
from Film_Premiera as fp
inner join Kraje as k on fp.IdKraju = k.IdKraje
inner join Filmy f on f.IdFilmy = fp.IdFilmu
where k.Kraj <> 'œwiat'
group by k.Kraj
order by LiczbaFilmow desc

-- Ile osób wziê³o udzia³ w poszczególnym wydarzeniu?
select 
	w.Nazwa
	,count(*) as [Liczba uczestników]
from Wydarzenie as w
inner join Wydarzenie_Uczestnicy as wu on w.IdWydarzenie = wu.IdWydarzenia
group by w.IdWydarzenie, w.Nazwa

-- Kto nie wzi¹³ udzia³u w ¿adnym wydarzeniu?
select 
	o.Imiê
	,o.Nazwisko
from Osoby as o
left join Wydarzenie_Uczestnicy as wu on o.IdOsoby = wu.IdUczestnika
-- where wu.IdWydarzenia is null

-- Który gatunek by³ najczêœciej produkowany w Polsce?
select top 1
	g.Nazwa
	,count(*) as [Ilosc wyprodukowanych filmow]
from Gatunek as g
inner join Film_Gatunek as fg on g.IdGatunek = fg.IdGatunku
inner join Filmy as f on fg.IdFilmu = f.IdFilmy
inner join Film_Premiera as fp on f.IdFilmy = fp.IdFilmu
inner join Kraje as k on fp.IdKraju = k.IdKraje
where k.Kraj = 'Polska'
group by g.Nazwa
order by [Ilosc wyprodukowanych filmow] desc
