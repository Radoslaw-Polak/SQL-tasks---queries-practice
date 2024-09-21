use Sklep_Internetowy_Kurs_SQL
go

-- UNION
select top 1
	p.IdPracownicy
	,p.Imie
	,p.Nazwisko
from Pracownicy as p
where right(p.Imie, 1) = 'a'

union

select top 1
	p.IdPracownicy
	,p.Imie
	,p.Nazwisko
from Pracownicy as p
where right(p.Imie, 1) <> 'a'

-- CASE
-- Pokaø imiÍ, nazwisko i p≥eÊ pracownika
select 
	p.Imie
	,p.Nazwisko
	,case 
		when right(p.Imie, 1) = 'a' then 'Kobieta'
		else 'MÍøczyzna'
	end as 'P≥eÊ'
from Pracownicy as p

-- Podstawy filtrowania
-- Pokaø produkty kosztujπce wiÍcej niø úrednia cena asortymentu
select *
from Produkty as p
where p.Cena > (select 
					avg(cena)
					from Produkty
					)
select 
avg(cena)
from Produkty

---------- ∆wiczenia -----------
-- Ile jest kobiet, a ile mÍøczyzn?
select (select count(*)
		from Pracownicy as p
		where right(p.Imie, 1) = 'a'
		) as Liczba_kobiet
		,(select count(*)
		from Pracownicy as p
		where right(p.Imie, 1) <> 'a'
		) as Liczba_mÍøczyzn

select count(*) as Liczba_kobiet
from Pracownicy as p
where right(p.Imie, 1) = 'a'
union
select count(*) as Liczba_mÍøczyzn
from Pracownicy as p
where right(p.Imie, 1) <> 'a'

select 
	subquery.Plec
	,count(*) as Liczba_osÛb
from (
	select case 
				when right(Imie, 1) = 'a' then 'Kobieta'
				else 'MÍøczyzna'
		   end as Plec
	from Pracownicy 
	) as subquery
group by subquery.Plec 

-- Podaj iloúÊ sprzedanego asortymentu w sklepie stacjonarnym z podzia≥em na miesiπce podajπc ich nazwy oraz zachowujπc kolejnoúÊ miesiÍcy
select 
	month(zss.DataZakupu) as Nr_miesiπca
	,datename(m, zss.DataZakupu) as Miesiπc
	,sum(zssp.Ilosc) as [IloúÊ sprzedanego asortymentu]
from ZakupySklepStacjonarny as zss
inner join ZakupySklepStacjonarnyProdukt as zssp on zss.IdZakupySklepStacjonarny = zssp.IdZakup
group by month(zss.DataZakupu),datename(m, zss.DataZakupu)
order by Nr_miesiπca


-- Ile razy wybrano dostawÍ Pocztπ Polskπ dla zakupÛw online w kaødej kategorii produktu
select 
	subquery.Nazwa
	,count(*) as [IloúÊ dostaw]	
from (
	select 
		zsop.IdZakup
		,kp.Nazwa
		,count(*) as cnt
	from ZakupySklepOnline as zso 
	inner join ZakupySklepOnlineProdukt as zsop on zso.IdZakupySklepOnline = zsop.IdZakup
	inner join Produkty as p on zsop.IdProduktu = p.IdProdukty
	inner join KategorieProduktow as kp on p.IdKategorii = kp.IdKategorieProduktow
	inner join RodzajDostawy as rd on zso.Dostawa = rd.IdRodzajDostawy
	where rd.Nazwa = 'Poczta Polska'
	group by zsop.IdZakup, kp.Nazwa 
	) as subquery
group by subquery.Nazwa

-------------------------------------------------
SELECT x.Nazwa, COUNT(*) AS Ilosc
FROM
    (SELECT kp.Nazwa
    FROM Produkty p
        INNER JOIN KategorieProduktow kp
            ON p.IdKategorii = kp.IdKategorieProduktow
        INNER JOIN ZakupySklepOnlineProdukt zp
            ON zp.IdProduktu = p.IdProdukty
        INNER JOIN ZakupySklepOnline z
            ON z.IdZakupySklepOnline = zp.IdZakup
        INNER JOIN RodzajDostawy rd
            ON rd.IdRodzajDostawy = z.Dostawa
    WHERE rd.Nazwa = 'Poczta Polska'
    GROUP BY kp.Nazwa, z.IdZakupySklepOnline) x
GROUP BY x.Nazwa

-- *Ile zarobiliúmy w wakacje na kaødym z produktÛw?
select *
from ZakupySklepOnline as zso
inner join ZakupySklepOnlineProdukt as zsop on zso.IdZakupySklepOnline = zsop.IdZakup

-- TUTAJ DOBRA ODPOWIEDè
-- Oddzielnie liczymy przychody dla poszczegÛlnych produktÛw dla sklepu online i stacjonarnego
-- A ostateczny wynik ≥πczy dwa wyøej wspomniane wyniki (tabele) z tabelπ Produkt (LEFT JOINEM), øeby w ostatecznym wyniku by≥y wszystkie produkty
-- i jeøeli dany produkt nie zosta≥ kupiony w sklepie online lub stacjonarnym to przychÛd bÍdzie NULL
-- Ostateczny ca≥kowity przychÛd jest sumπ tych 2 wartoúci ale trzeba obie zabezpieczyÊ funkcjπ ISNULL, øeby suma ca≥kowita nie by≥a nullem jeøeli np. produkt generowa≥ przychody
-- tylko w sklepie stacjonarnym a w sklepie online nie by≥ kupiony ani razu
select	
	p.IdProdukty
	,p.Nazwa
	,s1.przychod_zakupy_online as [PrzychÛd online]
	,s2.przychod_zakupy_stacjonarne as [PrzychÛd stacjonarny]
	,(isnull(s1.przychod_zakupy_online, 0) + isnull(s2.przychod_zakupy_stacjonarne, 0)) as [Ca≥kowity przychÛd]
from 
	produkty as p

	LEFT JOIN
	(select 
		p.IdProdukty
		,p.Nazwa
		,sum(zsop.Ilosc * p.Cena) as przychod_zakupy_online
	from Produkty as p
	inner join ZakupySklepOnlineProdukt as zsop on p.IdProdukty = zsop.IdProduktu
	inner join ZakupySklepOnline as zso on zsop.IdZakup = zso.IdZakupySklepOnline
	where month(zso.DataZakupu) in (7, 8)
	group by p.IdProdukty, p.Nazwa
	) as s1 -- zakupy online
	on p.IdProdukty = s1.IdProdukty

	LEFT JOIN
	(select 
		p.IdProdukty
		,p.Nazwa
		,sum(zssp.Ilosc * p.Cena) as przychod_zakupy_stacjonarne
	from Produkty as p
	inner join ZakupySklepStacjonarnyProdukt as zssp on p.IdProdukty = zssp.IdProduktu
	inner join ZakupySklepStacjonarny as zss on zssp.IdZakup = zss.IdZakupySklepStacjonarny
	where month(zss.DataZakupu) in (7, 8)
	group by p.IdProdukty, p.Nazwa) as s2 -- zakupy stacjonarne
	on p.IdProdukty = s2.IdProdukty
-----------------------------------------


select
	p.Nazwa
	,sum(p.Cena * zsop.Ilosc) suma_online
from Produkty as p
left join ZakupySklepOnlineProdukt as zsop on p.IdProdukty = zsop.IdProduktu
inner join ZakupySklepOnline as zso on zsop.IdZakup = zso.IdZakupySklepOnline
where  month(zso.DataZakupu) in (7, 8)
group by p.Nazwa

select
	p.Nazwa
	,sum(p.Cena * zssp.Ilosc) as suma_stacjonarny
from Produkty as p
inner join ZakupySklepStacjonarnyProdukt as zssp on p.IdProdukty = zssp.IdProduktu
inner join ZakupySklepStacjonarny as zss on zssp.IdZakup = zss.IdZakupySklepStacjonarny
where month(zss.DataZakupu) in (7, 8)
group by p.Nazwa

---------------------
-- * Jaki jest stan magazynowy produktÛw (zak≥adajπc, øe na otwarcie sklepu mieliúmy 111 sztuk kaødego produktu) ?
-- by≥o 111 wszystkich produktÛw na otwarciu sklepu
select 
	p.IdProdukty
	,p.Nazwa
	,s1.[Liczba sprzedanych online]
	,s2.[Liczba sprzedanych stacjonarnie]
	,s3.[Liczba dostarczonych produktÛw]
	,111 + isnull(s3.[Liczba dostarczonych produktÛw], 0) - isnull(s1.[Liczba sprzedanych online], 0) - isnull(s2.[Liczba sprzedanych stacjonarnie], 0) as [Stan magazynu]
from Produkty as p
	
	LEFT JOIN	
		(select 
			IdProduktu
			,sum(zsop.Ilosc) as [Liczba sprzedanych online]
		from ZakupySklepOnlineProdukt as zsop
		group by IdProduktu) as s1 
	on p.IdProdukty = s1.IdProduktu

	LEFT JOIN
		(select 
			IdProduktu
			,sum(zssp.Ilosc) as [Liczba sprzedanych stacjonarnie]
		from ZakupySklepStacjonarnyProdukt as zssp
		group by IdProduktu) as s2
	on p.IdProdukty = s2.IdProduktu
	
	LEFT JOIN
		(select 
			IdProduktu
			,sum(dp.Ilosc) as [Liczba dostarczonych produktÛw]
		from DostawaProduktow as dp
		group by IdProduktu) as s3
	on p.IdProdukty = s3.IdProduktu
order by p.IdProdukty
	
