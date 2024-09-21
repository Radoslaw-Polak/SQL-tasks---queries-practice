use Sklep_Internetowy_Kurs_SQL
go

-- Ile produkt�w mamy w danej kategorii
select kp.Nazwa
	   ,count(*) as [Ilo�� produkt�w]
from KategorieProduktow as kp
inner join Produkty as p on kp.IdKategorieProduktow = p.IdKategorii
group by kp.Nazwa

-- Ile razy wybrano dany rodzaj dostawy
select rd.Nazwa
       ,count(*) as [Ile razy wybrano]
from ZakupySklepOnline as zso
inner join RodzajDostawy as rd on zso.Dostawa = rd.IdRodzajDostawy
group by rd.Nazwa

-- Ile pracownicy przyj�li zwrot�w
select p.IdPracownicy
	   ,p.Imie
	   ,p.Nazwisko
	   ,count(*) as [Przyj�te zwroty]
from Pracownicy as p
inner join Zwroty z on p.IdPracownicy = z.IdPracownik
group by p.IdPracownicy, p.Imie, p.Nazwisko

-- Ile by�o promocyjnych zam�wie� online dla ka�dej z promocji
select p.IdPromocje
	   ,p.NazwaPromocji
	   ,count(*) as [Promocyjne zam�wienia]
from Promocje as p
inner join PromocjaZamowienieOnline as pzo on p.IdPromocje = pzo.IdPromocji
group by p.IdPromocje, p.NazwaPromocji

-- Ile sztuk ka�dego produktu zosta�o kupionych w sklepie stacjonarnym
select p.IdProdukty
	   ,p.Nazwa
	   ,p.Cena
	   ,p.IdKategorii
	   ,kp.Nazwa as [Nazwa kategorii]
	   ,SUM(zssp.Ilosc) as [Liczba sprzedanych produkt�w]
from ZakupySklepStacjonarnyProdukt as zssp 
inner join Produkty as p on zssp.IdProduktu = p.IdProdukty
inner join KategorieProduktow as kp on p.IdKategorii = kp.IdKategorieProduktow
group by p.IdProdukty, p.Nazwa, p.Cena, p.IdKategorii, kp.Nazwa
order by p.Nazwa 

-- Jaka jest �rednia cena ka�dej kategorii produkt�w
select 
	kp.IdKategorieProduktow
	,kp.Nazwa
	,cast( avg(cast(p.Cena as decimal(10,2))) as decimal(10,2)) as [�rednia cena]
from Produkty as p
inner join KategorieProduktow as kp on p.IdKategorii = kp.IdKategorieProduktow
group by kp.IdKategorieProduktow, kp.Nazwa

-- Jaka jest warto�� ka�dego z zam�wie� online
select  
	IdZakupySklepOnline
	,zso.DataZakupu
	,cast( sum(cast(zsop.Ilosc * p.Cena as decimal(10, 2))) as decimal(10, 2) ) as [Warto�� zam�wienia]
from ZakupySklepOnline zso
inner join ZakupySklepOnlineProdukt as zsop on zso.IdZakupySklepOnline = zsop.IdZakup
inner join Produkty as p on zsop.IdProduktu = p.IdProdukty
group by zso.IdZakupySklepOnline, zso.DataZakupu

-- Poka� informacj� o zakupach online (numer zam�wienia, dat�, kwot� do zap�aty, rodzaj dostawy)
select  
	IdZakupySklepOnline
	,zso.DataZakupu
	,cast( (cast(sum(zsop.Ilosc * p.Cena) as decimal(10,2)) + rd.Cena) as decimal(10, 2) ) as [Kwota]
	,rd.Nazwa as [Cena dostawy]
from ZakupySklepOnline zso
inner join ZakupySklepOnlineProdukt as zsop on zso.IdZakupySklepOnline = zsop.IdZakup
inner join Produkty as p on zsop.IdProduktu = p.IdProdukty
inner join RodzajDostawy as rd on rd.IdRodzajDostawy = zso.Dostawa
group by zso.IdZakupySklepOnline, zso.DataZakupu, rd.Nazwa, rd.Cena

-- Jaka jest �rednia pensja w ka�dym z dzia��w?
select 
	d.IdDzialy
	,d.NazwaDzialu
	,cast( avg(p.PensjaPodstawowa) as decimal(10,2) ) as [�rednia pensja]
from Pracownicy as p
inner join Dzialy as d on p.IdDzialu = d.IdDzialy
group by d.IdDzialy, d.NazwaDzialu
