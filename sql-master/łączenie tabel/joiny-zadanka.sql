use Sklep_Internetowy_Kurs_SQL
go

-- Poka¿ informacjê o produktach i nazwy kategorii produktów
select p.IdProdukty
	   ,p.Nazwa
	   ,p.Cena
	   ,kp.IdKategorieProduktow
	   ,kp.Nazwa
from Produkty as p
inner join KategorieProduktow as kp on p.IdKategorii = kp.IdKategorieProduktow

-- W jakim dziale pracuj¹ pracownicy?
select p.IdPracownicy
	   ,p.Imie
	   ,p.Nazwisko
	   ,d.NazwaDzialu
from Pracownicy as p
inner join Dzialy as d on p.IdDzialu = d.IdDzialy

-- Poka¿ klienta i numer jego karty sta³ego klienta
select k.IdKlienci as IdKlienta
	   ,k.Imie
	   ,k.Nazwisko
	   ,k.Wiek
	   ,ksk.NumerKarty as [Numer karty sta³ego klienta]
from Klienci as k
inner join KartaStalegoKlienta as ksk on k.IdKlienci = ksk.IdKlienta;

-- Poka¿ nazwê produktu oraz jego ceny i czas ich obowi¹zywania
select p.Nazwa
	   ,cp.Cena
	   ,cp.DataOd
	   ,cp.DataDo
from Produkty as p
inner join CenyProduktow as cp on p.IdProdukty = cp.IdProduktu;

-- Poka¿ wszystkich klientów oraz numery karty sta³ego klienta tylko dla tych, którzy j¹ posiadaj¹.
select k.IdKlienci
	   ,k.Imie
	   ,k.Nazwisko
	   ,ksk.NumerKarty as [Nr karty sta³ego klienta]
from Klienci as k
right join KartaStalegoKlienta as ksk on k.IdKlienci = ksk.IdKlienta;

-- Poka¿ wszystkie zakupy online oraz informacjê o przyczynie zwrotu dla zwróconych zamówieñ
select zso.IdKlienta
	   ,zso.DataZakupu
	   ,zso.IdKlienta
	   ,zso.IdZakupySklepOnline
	   ,zso.Komentarz
	   ,z.Przyczyna as [Przyczyna zwrotu]
from ZakupySklepOnline as zso
left join Zwroty as z on zso.IdZakupySklepOnline = z.IdZakupu;

-- £¥CZENIE WIELU TABEL
-- Poka¿ informacje o zakupach online (id zakupu, datê, nazwê, cenê i iloœæ kupionych produktów)
select zso.IdZakupySklepOnline
	   ,zso.DataZakupu
	   ,p.Nazwa
	   ,p.Cena
	   ,zsop.Ilosc
from ZakupySklepOnline as zso
inner join ZakupySklepOnlineProdukt as zsop on zso.IdZakupySklepOnline = zsop.IdZakup
inner join Produkty as p on zsop.IdProduktu = p.IdProdukty

-- Poka¿ imiê i nazwisko pracowników oraz nazwê dostawcy, którego obs³ugiwa³ danych pracownik
select distinct p.Imie
	   ,p.Nazwisko
	   ,dstwcy.Nazwa
from Pracownicy as p
inner join Dostawa as dstwy on p.IdPracownicy = dstwy.IdPracownicy
inner join Dostawcy as dstwcy on dstwy.IdDostawcy = dstwcy.IdDostawcy

-- Z jakich dzia³ów pracownicy przyjmowali zwroty?
select distinct d.IdDzialy
	   ,d.NazwaDzialu   
from Pracownicy as p
inner join Zwroty as z on z.IdPracownik = p.IdPracownicy
inner join Dzialy as d on p.IdDzialu = d.IdDzialy

-- Poka¿ jak¹ mamy bi¿uteriê
select p.IdProdukty
	   ,p.Nazwa
	   ,p.Cena
from Produkty p
inner join KategorieProduktow kp on p.IdKategorii = kp.IdKategorieProduktow
where kp.Nazwa = 'Bi¿uteria'

-- Poka¿ klientów nie posiadaj¹cych karty sta³ego klienta
select k.IdKlienci
	   ,k.Imie
	   ,k.Nazwisko
	   ,k.Wiek
from Klienci as k
left join KartaStalegoKlienta as ksk on k.IdKlienci = ksk.IdKlienta
where ksk.IdKartaStalegoKlienta is null

-- Jakie ceny mieliœmy w marcu dla telefonów?
select p.Cena
	   ,cp.Cena
from Produkty as p
inner join CenyProduktow as cp on p.IdProdukty = cp.IdProduktu
inner join KategorieProduktow as kp on kp.IdKategorieProduktow = p.IdKategorii
where month(cp.DataOd) <= 3 and month(cp.DataDo) >= 3 and kp.Nazwa = 'Telefony'

-- Poka¿ nazwy produktów kupionych w sklepie online w styczniu
select distinct p.Nazwa
from Produkty as p
inner join ZakupySklepOnlineProdukt as zsop on p.IdProdukty = zsop.IdProduktu
inner join ZakupySklepOnline as zso on zso.IdZakupySklepOnline = zsop.IdZakup
where month(zso.DataZakupu) = 1

-- Poka¿ mê¿czyzn i jeœli maj¹, to ich prze³o¿onych
select p1.IdPracownicy
	   ,p1.Imie as [Imie pracownika]
	   ,p1.Nazwisko as [Nazwisko pracownika]
	   ,p1.IdPrzelozonego 
	   ,p2.Imie as [Imie prze³o¿onego]
	   ,p2.Nazwisko as [Nazwisko prze³o¿onego]
from Pracownicy as p1
left join Pracownicy as p2 on p1.IdPrzelozonego = p2.IdPracownicy
where right(p1.Imie, 1) <> 'a'

-- Ilu klientów nie kupi³o nigdy nic w sklepie online
select count(*) as [Liczba klientów którzy nigdy nie kupili nic w sklepie online]
from ZakupySklepOnline as zso
right join Klienci as k on zso.IdKlienta = k.IdKlienci
where zso.IdZakupySklepOnline is null




