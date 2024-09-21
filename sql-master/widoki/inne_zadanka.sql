use Sklep_Internetowy_Kurs_SQL
go

-- Stw�rz widok prezentuj�cy ilo�� sprzedanych sztuk w sklepie online ka�dego z produkt�w
create view v_IloscSprzedanychOnline as (
select 
	p.IdProdukty
	,p.Nazwa
	,isnull(sum(zsop.Ilosc), 0) as [Ilo�� sprzedanych]
from ZakupySklepOnlineProdukt as zsop
right join Produkty as p on zsop.IdProduktu = p.IdProdukty
group by p.IdProdukty, p.Nazwa
)

select * from v_IloscSprzedanychOnline

-- Stw�rz widok prezentuj�cy ilo�� sprzedanych sztuk w sklepie stacjonarnym ka�dego z produkt�w
create view v_IloscSprzedanychStacjonarnie as (
select 
	p.IdProdukty
	,p.Nazwa
	,isnull(sum(zssp.Ilosc), 0) as [Ilo�� sprzedanych]
from ZakupySklepStacjonarnyProdukt as zssp
right join Produkty as p on zssp.IdProduktu = p.IdProdukty
group by p.IdProdukty, p.Nazwa
)

select * from v_IloscSprzedanychStacjonarnie

-- Stw�rz widok prezentuj�cy ilo�� dostarczonych sztuk ka�dego z produkt�w
create view v_IloscDostarczonychProduktow as (
select 
	p.IdProdukty
	,p.Nazwa
	,isnull(sum(dp.Ilosc), 0) as [Ilo�� dostarczonych]
from Produkty as p
left join DostawaProduktow as dp on p.IdProdukty = dp.IdProduktu
group by p.IdProdukty, p.Nazwa
)

select *
from v_IloscDostarczonychProduktow as vIDP
order by vIDP.Nazwa


-- Wykorzystuj�c trzy poprzednio utworzone widoki wy�wietl stany magazynowe produkt�w zak�adaj�c, �e stan pocz�tkowy to 111 produkt�w
select 
	vISO.IdProdukty
	,vISO.Nazwa
	,(111 + vIDP.[Ilo�� dostarczonych] - (vISO.[Ilo�� sprzedanych] + vISS.[Ilo�� sprzedanych])) as [Stan magazynowy]
from v_IloscSprzedanychOnline as vISO
inner join v_IloscSprzedanychStacjonarnie as vISS on vISO.IdProdukty = vISS.IdProdukty
inner join v_IloscDostarczonychProduktow as vIDP on vIDP.IdProdukty = vISO.IdProdukty
order by vISO.Nazwa

-- Stw�rz widok z produktami wy�wietlaj�cy ceny z momentu wywo�ania zapytania, je�li nie
-- znalaz�o ceny, wy�wietl cen� z tabeli z produktami
create view v_AktualneCenyProduktow as (
select 
	p.IdProdukty
	,p.Nazwa
	,isnull(cp.Cena, p.Cena) as [Aktualna cena]
from Produkty as p
left join CenyProduktow as cp on p.IdProdukty = cp.IdProduktu
where getdate() between cp.DataOd and cp.DataDo or cp.IdCenyProduktow is null
)

insert into CenyProduktow (IdProduktu, Cena, DataOd, DataDo) values
((select IdProdukty from Produkty where Nazwa = 'Xiaomi Redmi'), 800, GETDATE(), '2024-10-01 00:00:00.000'),
((select IdProdukty from Produkty where Nazwa = 'GTA V'), 180, GETDATE(), '2024-11-10 00:00:00.000'),
((select IdProdukty from Produkty where Nazwa = 'GTA San Andreas'), 40, GETDATE(), '2024-10-31 00:00:00.000')

select *
from v_AktualneCenyProduktow

-- Korzystaj�c z widoku z poprzedniego zadania stw�rz widok z kwotami za sprzeda� produkt�w online
create view v_CalkowitaSprzedazProduktow as (
select 
	vACP.IdProdukty
	,vACP.Nazwa
	,isnull(sum(zsop.Ilosc * vACP.[Aktualna cena]), 0) as [Ca�kowita sprzeda�]
from ZakupySklepOnlineProdukt as zsop
inner join v_AktualneCenyProduktow as vACP on zsop.IdProduktu = vACP.IdProdukty
group by vACP.IdProdukty, vACP.Nazwa
)

select *
from v_CalkowitaSprzedazProduktow


-- Znajd� produkty kosztuj�ce wi�cej ni� �rednia cena w swojej kategorii. Stw�rz potrzebny widok, nie korzystaj z zapyta� zagnie�d�onych
create view v_�redniaCenaWKategorii as (
select 
	   kp.IdKategorieProduktow
	   ,kp.Nazwa
	   ,avg(p.Cena) as [�rednia cena]
from Produkty as p
inner join KategorieProduktow as kp on p.IdKategorii = kp.IdKategorieProduktow
group by kp.IdKategorieProduktow, kp.Nazwa
)

select 
	p.*
	,vSCK.Nazwa
	,vSCK.[�rednia cena]
from Produkty as p
inner join v_�redniaCenaWKategorii as vSCK on p.IdKategorii = vSCK.IdKategorieProduktow
where p.Cena > vSCK.[�rednia cena]

-- Stw�rz widok ze �redni� cen� produkt�w i nast�pnie z jego pomoc� znajd� wszystkie produkty kosztuj�ce mniej ni� �rednia cena produk�w
create view v_srednia_cena as (
select
	avg(p.Cena) as [�rednia cena]
from Produkty as p
)

select *
from Produkty as p
where p.Cena < (select [�rednia cena] from v_srednia_cena)

select *
from Produkty as p
cross join v_srednia_cena
where p.Cena < v_srednia_cena.[�rednia cena]

-- Stw�rz widok wy�wietlaj�cy numer miesi�ca i polsk� nazw� miesi�ca
create view v_Miesi�ce as (
select 1 as [Nr miesi�ca], 'Stycze�' as [Nazwa miesi�ca]
union
select 2 as [Nr miesi�ca], 'Luty' as [Nazwa miesi�ca]
union
select 3 as [Nr miesi�ca], 'Marzec' as [Nazwa miesi�ca]
union
select 4 as [Nr miesi�ca], 'Kwiecie�' as [Nazwa miesi�ca]
union
select 5 as [Nr miesi�ca], 'Maj' as [Nazwa miesi�ca]
union
select 6 as [Nr miesi�ca], 'Czerwiec' as [Nazwa miesi�ca]
union
select 7 as [Nr miesi�ca], 'Lipiec' as [Nazwa miesi�ca]
union
select 8 as [Nr miesi�ca], 'Sierpie�' as [Nazwa miesi�ca]
union
select 9 as [Nr miesi�ca], 'Wrzesie�' as [Nazwa miesi�ca]
union
select 10 as [Nr miesi�ca], 'Pa�dziernik' as [Nazwa miesi�ca]
union
select 11 as [Nr miesi�ca], 'Listopad' as [Nazwa miesi�ca]
union
select 12 as [Nr miesi�ca], 'Grudzie�' as [Nazwa miesi�ca]
)

select * from v_Miesi�ce

-- Wykorzystuj�c widok z miesi�cami poka� ile w danym miesi�cu sprzedali�my sztuk ka�dego z produkt�w w sklepie online.
-- Posortuj wyniki wg miesi�ca i malej�co wg ilo�ci
select 
	vM.[Nazwa miesi�ca]
	,p.Nazwa
	,sum(zsop.Ilosc) as [Ilo�� sprzedanych]
from ZakupySklepOnlineProdukt as zsop
inner join ZakupySklepOnline as zso on zsop.IdZakup = zso.IdZakupySklepOnline
inner join v_Miesi�ce as vM on month(zso.DataZakupu) = vM.[Nr miesi�ca]
inner join Produkty as p on zsop.IdProduktu = p.IdProdukty
group by vm.[Nr miesi�ca], vm.[Nazwa miesi�ca], p.Nazwa
order by vm.[Nr miesi�ca], [Ilo�� sprzedanych] desc
