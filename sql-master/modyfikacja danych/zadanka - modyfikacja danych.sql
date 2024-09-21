use Sklep_Internetowy_Kurs_SQL
go

-- Dodaj trzy dowolne okresy z cenami dla telefonu dodanego w powy¿szym zadaniu
select *
from Produkty

select *
from KategorieProduktow

select *
from CenyProduktow

insert into CenyProduktow (IdProduktu, Cena, DataOd, DataDo) values
( (select p.IdProdukty from Produkty as p where p.Nazwa = 'Xiaomi Redmi'), 900, '2019-05-01', '2020-01-01')
( (select p.IdProdukty from Produkty as p where p.Nazwa = 'Xiaomi Redmi'), 800, '2020-01-02', '2020-04-30'),
( (select p.IdProdukty from Produkty as p where p.Nazwa = 'Xiaomi Redmi'), 900, '2020-05-01', '2020-12-31')

-- Informacjê o produktach (Nazwa, Nazwa kategorii, Cena, Iloœæ dostarczonych przez dostawców sztuk) wstaw do nowej tabeli
select
	p.Nazwa as NazwaProduktu
	,kp.Nazwa as NazwaKategorii
	,p.Cena
	,isnull(sum(dp.Ilosc), 0) as [Ilosc dostarczonych]
into dbo.DostarczoneProdukty
from Produkty as p
inner join KategorieProduktow as kp on p.IdKategorii = kp.IdKategorieProduktow
left join DostawaProduktow as dp on p.IdProdukty = dp.IdProduktu 
group by p.Nazwa, kp.Nazwa, p.Cena

select *
from DostarczoneProdukty

-- Dodaj now¹ kategoriê produktów i dodaj do niej 2 nowe produkty
select *
from KategorieProduktow

insert into KategorieProduktow (Nazwa)
values('Gry')

select * from Produkty

insert into Produkty (Nazwa, Cena, IdKategorii) values
('GTA V', 200, (select IdKategorieProduktow from KategorieProduktow where Nazwa = 'Gry')),
('GTA San Andreas', 50, (select IdKategorieProduktow from KategorieProduktow where Nazwa = 'Gry'))

select * from Produkty where Nazwa like '%Lego%' and Nazwa not like '%Star Wars%'

-- Zwiêksz o 3% ceny wszystkich klocków lego nie bêd¹cych Star Wars
update Produkty
set Cena = 1.03 * Cena
where Nazwa like '%Lego%' and Nazwa not like '%Star Wars%'

select * from Produkty where Nazwa like '%Lego%' and Nazwa not like '%Star Wars%'

-- Obni¿ cenê o 50z³ telefonom kupowanym online w marcu, których sprzeda³y siê maksymalnie 2 sztuki 
select p.IdProdukty
	   ,p.Nazwa
	   ,p.Cena
	   ,sum(zsop.Ilosc) as [Ile sprzedano]
from ZakupySklepOnline as zso
inner join ZakupySklepOnlineProdukt as zsop on zso.IdZakupySklepOnline = zsop.IdZakup
inner join Produkty as p on zsop.IdProduktu = p.IdProdukty
inner join KategorieProduktow as kp on p.IdKategorii = kp.IdKategorieProduktow
where month(zso.DataZakupu) = 3 and kp.Nazwa = 'Telefony'
group by p.IdProdukty, p.Nazwa, p.Cena
having sum(zsop.Ilosc) <= 2

update Produkty 
set Cena = Cena - 50
where IdProdukty in (
	   select subquery.IdProdukty
	   from (
			select 
				p.IdProdukty
				,p.Nazwa
				,sum(zsop.Ilosc) as [Ile sprzedano]
			from ZakupySklepOnline as zso
			inner join ZakupySklepOnlineProdukt as zsop on zso.IdZakupySklepOnline = zsop.IdZakup
			inner join Produkty as p on zsop.IdProduktu = p.IdProdukty
			inner join KategorieProduktow as kp on p.IdKategorii = kp.IdKategorieProduktow
			where month(zso.DataZakupu) = 3 and kp.Nazwa = 'Telefony'
			group by p.IdProdukty, p.Nazwa
			having sum(zsop.Ilosc) <= 2 
	   ) as subquery )


