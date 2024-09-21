use Sklep_Internetowy_Kurs_SQL
go

-- liczba dzia��w
select count(*)
from Dzialy;

-- maksymalna pensja w�r�d kobiet
select max(PensjaPodstawowa)
from Pracownicy
where RIGHT(Imie, 1) = 'a';

-- liczba podw�adnych ka�dego z prze�o�onych
select IdPrzelozonego
	   ,COUNT(*) as [Liczba podw�adnych]
from Pracownicy
where IdPrzelozonego is not null
group by IdPrzelozonego;

-- liczba produkt�w dla ka�dej z kategorii
select IdKategorii
	   ,count(*) as [Liczba produkt�w]
from Produkty
group by IdKategorii;

-- �rednia pensja dla ka�dego dzia�u
select IdDzialu
	   ,cast(avg(PensjaPodstawowa) as decimal(10, 2)) as [�rednia pensja]
from Pracownicy
group by IdDzialu;

--Ile zakup�w stacjonarnych by�o w poszczeg�lnym miesi�cu
select month(DataZakupu) as [Miesi�c]
	   ,count(*) as [Liczba zakup�w]
from ZakupySklepStacjonarny
group by month(DataZakupu)
order by [Miesi�c];

--Ile zakup�w online by�o w poszczeg�lnym dniu miesi�ca
select month(DataZakupu) as [Miesi�c]
	   ,day(DataZakupu) as [Dzie�]
	   ,count(*) as [Liczba zakup�w]
from ZakupySklepOnline
group by month(DataZakupu), day(DataZakupu)
order by [Miesi�c];

-- Pogrupowanie liczby klient� w zale�no�ci od wieku
select Wiek
	   ,count(*) as [Liczba klient�w]
from Klienci
group by Wiek

-- W jakim wieku mamy wi�cej ni� 5 klient�w?
select Wiek
	   ,count(*) as [Liczba klient�w]
from Klienci
group by Wiek
having count(*) > 5;

-- Poka� dzia�y w kt�rych zarabia si� �rednio wi�cej ni� 2800z�
select IdDzialu
	   ,cast(avg(PensjaPodstawowa) as decimal(10, 2)) as [�rednia pensja]
from Pracownicy
group by IdDzialu
having avg(PensjaPodstawowa) > 2800;

-- Ilu jest pracownik�w posiadaj�cych prze�o�onego?
select count(*)
from Pracownicy
where IdPrzelozonego is not null;

-- Poka� najta�sz� opcje dostawy poza odbiorem osobistym
select IdRodzajDostawy
	   ,Nazwa
	   ,Cena
from RodzajDostawy
where Cena = (select min(Cena) 
			  from RodzajDostawy
			  where Nazwa <> 'Odbi�r osobisty');
-- LUB
SELECT TOP 1 *
FROM RodzajDostawy
WHERE Nazwa <> 'Odbi�r osobisty'
ORDER BY Cena;

-- Ilu pracownik�w jest przypisanych do danego prze�o�onego? � wyklucz tych bez prze�o�onego
select IdPrzelozonego
	   ,count(*) as [Liczba pracownik�w]
from Pracownicy
where IdPrzelozonego is not null
group by IdPrzelozonego;

-- Poka� dni maja w kt�rych by�o sprzeda�y w sklepie stacjonarnym co najmniej 5
select day(DataZakupu) as [Dzie�]
	 --  ,count(*) as [Ilo�� sprzeda�y]
from ZakupySklepStacjonarny 
where month(DataZakupu) = 5
group by day(DataZakupu)
having count(*) >= 5;

-- W kt�rym dziale s� najwy�sze �rednie zarobki?
select top 1 IdDzialu
	   ,cast(avg(PensjaPodstawowa) as decimal(10, 2)) as [�rednie zarobki]
from Pracownicy
group by IdDzialu
order by [�rednie zarobki] desc;

-- Poka� kwarta� w kt�rym mieli�my najwi�cej zakup�w online
select top 1 DATEPART(QUARTER, DataZakupu) as Kwarta�
	   ,count(*) as [Liczba zakup�w]
from ZakupySklepOnline
group by DATEPART(QUARTER, DataZakupu)
order by [Liczba zakup�w] desc;

-- W kt�rym dziale m�czy�ni maj� najni�sze �rednie zarobki?
select top 1 IdDzialu
	   ,cast(avg(PensjaPodstawowa) as decimal(10, 2)) as [�rednie zarobki]
from Pracownicy
where right(Imie, 1) <> 'a'
group by IdDzialu
order by [�rednie zarobki];

-- Za kt�r� dostaw� zap�acili�my najwi�cej?
select top 1 NumerDostawy
	   ,sum(Ilosc * CenaZaSztuke) as Kwota_dostawy
from DostawaProduktow
group by NumerDostawy
order by Kwota_dostawy desc;

-- Znajd� produkty, kt�rym cena zmieni�a si� wi�cej ni� raz w ci�gu miesi�ca
SELECT IdProduktu, MONTH(DataOd), COUNT(*)
FROM CenyProduktow
GROUP BY IdProduktu, MONTH(DataOd)
HAVING COUNT(*) > 1;



