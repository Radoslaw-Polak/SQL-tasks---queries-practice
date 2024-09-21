use Sklep_Internetowy_Kurs_SQL
go

-- liczba dzia³ów
select count(*)
from Dzialy;

-- maksymalna pensja wœród kobiet
select max(PensjaPodstawowa)
from Pracownicy
where RIGHT(Imie, 1) = 'a';

-- liczba podw³adnych ka¿dego z prze³o¿onych
select IdPrzelozonego
	   ,COUNT(*) as [Liczba podw³adnych]
from Pracownicy
where IdPrzelozonego is not null
group by IdPrzelozonego;

-- liczba produktów dla ka¿dej z kategorii
select IdKategorii
	   ,count(*) as [Liczba produktów]
from Produkty
group by IdKategorii;

-- œrednia pensja dla ka¿dego dzia³u
select IdDzialu
	   ,cast(avg(PensjaPodstawowa) as decimal(10, 2)) as [Œrednia pensja]
from Pracownicy
group by IdDzialu;

--Ile zakupów stacjonarnych by³o w poszczególnym miesi¹cu
select month(DataZakupu) as [Miesi¹c]
	   ,count(*) as [Liczba zakupów]
from ZakupySklepStacjonarny
group by month(DataZakupu)
order by [Miesi¹c];

--Ile zakupów online by³o w poszczególnym dniu miesi¹ca
select month(DataZakupu) as [Miesi¹c]
	   ,day(DataZakupu) as [Dzieñ]
	   ,count(*) as [Liczba zakupów]
from ZakupySklepOnline
group by month(DataZakupu), day(DataZakupu)
order by [Miesi¹c];

-- Pogrupowanie liczby klientó w zale¿noœci od wieku
select Wiek
	   ,count(*) as [Liczba klientów]
from Klienci
group by Wiek

-- W jakim wieku mamy wiêcej ni¿ 5 klientów?
select Wiek
	   ,count(*) as [Liczba klientów]
from Klienci
group by Wiek
having count(*) > 5;

-- Poka¿ dzia³y w których zarabia siê œrednio wiêcej ni¿ 2800z³
select IdDzialu
	   ,cast(avg(PensjaPodstawowa) as decimal(10, 2)) as [Œrednia pensja]
from Pracownicy
group by IdDzialu
having avg(PensjaPodstawowa) > 2800;

-- Ilu jest pracowników posiadaj¹cych prze³o¿onego?
select count(*)
from Pracownicy
where IdPrzelozonego is not null;

-- Poka¿ najtañsz¹ opcje dostawy poza odbiorem osobistym
select IdRodzajDostawy
	   ,Nazwa
	   ,Cena
from RodzajDostawy
where Cena = (select min(Cena) 
			  from RodzajDostawy
			  where Nazwa <> 'Odbiór osobisty');
-- LUB
SELECT TOP 1 *
FROM RodzajDostawy
WHERE Nazwa <> 'Odbiór osobisty'
ORDER BY Cena;

-- Ilu pracowników jest przypisanych do danego prze³o¿onego? – wyklucz tych bez prze³o¿onego
select IdPrzelozonego
	   ,count(*) as [Liczba pracowników]
from Pracownicy
where IdPrzelozonego is not null
group by IdPrzelozonego;

-- Poka¿ dni maja w których by³o sprzeda¿y w sklepie stacjonarnym co najmniej 5
select day(DataZakupu) as [Dzieñ]
	 --  ,count(*) as [Iloœæ sprzeda¿y]
from ZakupySklepStacjonarny 
where month(DataZakupu) = 5
group by day(DataZakupu)
having count(*) >= 5;

-- W którym dziale s¹ najwy¿sze œrednie zarobki?
select top 1 IdDzialu
	   ,cast(avg(PensjaPodstawowa) as decimal(10, 2)) as [Œrednie zarobki]
from Pracownicy
group by IdDzialu
order by [Œrednie zarobki] desc;

-- Poka¿ kwarta³ w którym mieliœmy najwiêcej zakupów online
select top 1 DATEPART(QUARTER, DataZakupu) as Kwarta³
	   ,count(*) as [Liczba zakupów]
from ZakupySklepOnline
group by DATEPART(QUARTER, DataZakupu)
order by [Liczba zakupów] desc;

-- W którym dziale mê¿czyŸni maj¹ najni¿sze œrednie zarobki?
select top 1 IdDzialu
	   ,cast(avg(PensjaPodstawowa) as decimal(10, 2)) as [Œrednie zarobki]
from Pracownicy
where right(Imie, 1) <> 'a'
group by IdDzialu
order by [Œrednie zarobki];

-- Za któr¹ dostawê zap³aciliœmy najwiêcej?
select top 1 NumerDostawy
	   ,sum(Ilosc * CenaZaSztuke) as Kwota_dostawy
from DostawaProduktow
group by NumerDostawy
order by Kwota_dostawy desc;

-- ZnajdŸ produkty, którym cena zmieni³a siê wiêcej ni¿ raz w ci¹gu miesi¹ca
SELECT IdProduktu, MONTH(DataOd), COUNT(*)
FROM CenyProduktow
GROUP BY IdProduktu, MONTH(DataOd)
HAVING COUNT(*) > 1;



