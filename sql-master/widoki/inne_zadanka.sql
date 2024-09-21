use Sklep_Internetowy_Kurs_SQL
go

-- Stwórz widok prezentuj¹cy iloœæ sprzedanych sztuk w sklepie online ka¿dego z produktów
create view v_IloscSprzedanychOnline as (
select 
	p.IdProdukty
	,p.Nazwa
	,isnull(sum(zsop.Ilosc), 0) as [Iloœæ sprzedanych]
from ZakupySklepOnlineProdukt as zsop
right join Produkty as p on zsop.IdProduktu = p.IdProdukty
group by p.IdProdukty, p.Nazwa
)

select * from v_IloscSprzedanychOnline

-- Stwórz widok prezentuj¹cy iloœæ sprzedanych sztuk w sklepie stacjonarnym ka¿dego z produktów
create view v_IloscSprzedanychStacjonarnie as (
select 
	p.IdProdukty
	,p.Nazwa
	,isnull(sum(zssp.Ilosc), 0) as [Iloœæ sprzedanych]
from ZakupySklepStacjonarnyProdukt as zssp
right join Produkty as p on zssp.IdProduktu = p.IdProdukty
group by p.IdProdukty, p.Nazwa
)

select * from v_IloscSprzedanychStacjonarnie

-- Stwórz widok prezentuj¹cy iloœæ dostarczonych sztuk ka¿dego z produktów
create view v_IloscDostarczonychProduktow as (
select 
	p.IdProdukty
	,p.Nazwa
	,isnull(sum(dp.Ilosc), 0) as [Iloœæ dostarczonych]
from Produkty as p
left join DostawaProduktow as dp on p.IdProdukty = dp.IdProduktu
group by p.IdProdukty, p.Nazwa
)

select *
from v_IloscDostarczonychProduktow as vIDP
order by vIDP.Nazwa


-- Wykorzystuj¹c trzy poprzednio utworzone widoki wyœwietl stany magazynowe produktów zak³adaj¹c, ¿e stan pocz¹tkowy to 111 produktów
select 
	vISO.IdProdukty
	,vISO.Nazwa
	,(111 + vIDP.[Iloœæ dostarczonych] - (vISO.[Iloœæ sprzedanych] + vISS.[Iloœæ sprzedanych])) as [Stan magazynowy]
from v_IloscSprzedanychOnline as vISO
inner join v_IloscSprzedanychStacjonarnie as vISS on vISO.IdProdukty = vISS.IdProdukty
inner join v_IloscDostarczonychProduktow as vIDP on vIDP.IdProdukty = vISO.IdProdukty
order by vISO.Nazwa

-- Stwórz widok z produktami wyœwietlaj¹cy ceny z momentu wywo³ania zapytania, jeœli nie
-- znalaz³o ceny, wyœwietl cenê z tabeli z produktami
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

-- Korzystaj¹c z widoku z poprzedniego zadania stwórz widok z kwotami za sprzeda¿ produktów online
create view v_CalkowitaSprzedazProduktow as (
select 
	vACP.IdProdukty
	,vACP.Nazwa
	,isnull(sum(zsop.Ilosc * vACP.[Aktualna cena]), 0) as [Ca³kowita sprzeda¿]
from ZakupySklepOnlineProdukt as zsop
inner join v_AktualneCenyProduktow as vACP on zsop.IdProduktu = vACP.IdProdukty
group by vACP.IdProdukty, vACP.Nazwa
)

select *
from v_CalkowitaSprzedazProduktow


-- ZnajdŸ produkty kosztuj¹ce wiêcej ni¿ œrednia cena w swojej kategorii. Stwórz potrzebny widok, nie korzystaj z zapytañ zagnie¿d¿onych
create view v_ŒredniaCenaWKategorii as (
select 
	   kp.IdKategorieProduktow
	   ,kp.Nazwa
	   ,avg(p.Cena) as [Œrednia cena]
from Produkty as p
inner join KategorieProduktow as kp on p.IdKategorii = kp.IdKategorieProduktow
group by kp.IdKategorieProduktow, kp.Nazwa
)

select 
	p.*
	,vSCK.Nazwa
	,vSCK.[Œrednia cena]
from Produkty as p
inner join v_ŒredniaCenaWKategorii as vSCK on p.IdKategorii = vSCK.IdKategorieProduktow
where p.Cena > vSCK.[Œrednia cena]

-- Stwórz widok ze œredni¹ cen¹ produktów i nastêpnie z jego pomoc¹ znajdŸ wszystkie produkty kosztuj¹ce mniej ni¿ œrednia cena produków
create view v_srednia_cena as (
select
	avg(p.Cena) as [Œrednia cena]
from Produkty as p
)

select *
from Produkty as p
where p.Cena < (select [Œrednia cena] from v_srednia_cena)

select *
from Produkty as p
cross join v_srednia_cena
where p.Cena < v_srednia_cena.[Œrednia cena]

-- Stwórz widok wyœwietlaj¹cy numer miesi¹ca i polsk¹ nazwê miesi¹ca
create view v_Miesi¹ce as (
select 1 as [Nr miesi¹ca], 'Styczeñ' as [Nazwa miesi¹ca]
union
select 2 as [Nr miesi¹ca], 'Luty' as [Nazwa miesi¹ca]
union
select 3 as [Nr miesi¹ca], 'Marzec' as [Nazwa miesi¹ca]
union
select 4 as [Nr miesi¹ca], 'Kwiecieñ' as [Nazwa miesi¹ca]
union
select 5 as [Nr miesi¹ca], 'Maj' as [Nazwa miesi¹ca]
union
select 6 as [Nr miesi¹ca], 'Czerwiec' as [Nazwa miesi¹ca]
union
select 7 as [Nr miesi¹ca], 'Lipiec' as [Nazwa miesi¹ca]
union
select 8 as [Nr miesi¹ca], 'Sierpieñ' as [Nazwa miesi¹ca]
union
select 9 as [Nr miesi¹ca], 'Wrzesieñ' as [Nazwa miesi¹ca]
union
select 10 as [Nr miesi¹ca], 'PaŸdziernik' as [Nazwa miesi¹ca]
union
select 11 as [Nr miesi¹ca], 'Listopad' as [Nazwa miesi¹ca]
union
select 12 as [Nr miesi¹ca], 'Grudzieñ' as [Nazwa miesi¹ca]
)

select * from v_Miesi¹ce

-- Wykorzystuj¹c widok z miesi¹cami poka¿ ile w danym miesi¹cu sprzedaliœmy sztuk ka¿dego z produktów w sklepie online.
-- Posortuj wyniki wg miesi¹ca i malej¹co wg iloœci
select 
	vM.[Nazwa miesi¹ca]
	,p.Nazwa
	,sum(zsop.Ilosc) as [Iloœæ sprzedanych]
from ZakupySklepOnlineProdukt as zsop
inner join ZakupySklepOnline as zso on zsop.IdZakup = zso.IdZakupySklepOnline
inner join v_Miesi¹ce as vM on month(zso.DataZakupu) = vM.[Nr miesi¹ca]
inner join Produkty as p on zsop.IdProduktu = p.IdProdukty
group by vm.[Nr miesi¹ca], vm.[Nazwa miesi¹ca], p.Nazwa
order by vm.[Nr miesi¹ca], [Iloœæ sprzedanych] desc
