use Sklep_Internetowy_Kurs_SQL
go

-- Ile sztuk poszczególnych zestawów Lego w sklepie stacjonarnym zosta³o kupionych
select 
	p.IdProdukty
	,p.Nazwa
	,sum(zssp.Ilosc) as [Liczba sztuk]
from ZakupySklepStacjonarnyProdukt as zssp
inner join Produkty as p on zssp.IdProduktu = p.IdProdukty
where p.Nazwa like '%Lego%'
group by p.IdProdukty, p.Nazwa

-- Który rodzaj dostawy by³ wybierany najczêœciej?
select top 1 
	rd.Nazwa
	,count(*) as [Ile razy wybrano]
from RodzajDostawy as rd
inner join ZakupySklepOnline as zso on zso.Dostawa = rd.IdRodzajDostawy
group by rd.Nazwa
order by [Ile razy wybrano] desc

-- Ile razy ka¿dy z klientów nie posiadaj¹cych karty sta³ego klienta robi¹ zakupy
select 
	k.IdKlienci
	,k.Imie
	,k.Nazwisko
	,count(*) as [Ile zrobionych zakupów]
from Klienci as k
left join KartaStalegoKlienta as ksk on k.IdKlienci = ksk.IdKlienta
inner join ZakupySklepOnline as zso on zso.IdKlienta = k.IdKlienci
-- inner join ZakupySklepStacjonarny as zss on zss.IdKlienta = k.IdKlienci
where ksk.IdKartaStalegoKlienta is null and zso.IdZakupySklepOnline is not null
group by k.IdKlienci, k.Imie, k.Nazwisko
order by k.IdKlienci

-- W której kategorii mamy najmniej produktów?
select top 1
	   kp.IdKategorieProduktow
	   ,kp.Nazwa
	   ,count(*) as [Ile produktów]
from KategorieProduktow as kp
inner join Produkty as p on kp.IdKategorieProduktow = p.IdKategorii
group by kp.IdKategorieProduktow, kp.Nazwa
order by [Ile produktów]

-- Jakie 3 produkty sprzedawa³y siê najlepiej w wakacje w sklepie stacjonarnym?
select top 3 
	p.IdProdukty
	,p.Nazwa
	,sum(zssp.Ilosc) as [Liczba sprzedanych]
from Produkty as p
inner join ZakupySklepStacjonarnyProdukt as zssp on p.IdProdukty = zssp.IdProduktu
inner join ZakupySklepStacjonarny as zss on zssp.IdZakup = zss.IdZakupySklepStacjonarny
where month(zss.DataZakupu) in (7, 8)
group by p.IdProdukty, p.Nazwa
order by [Liczba sprzedanych] desc

-- W którym dniu maja sprzeda³o siê najwiêcej produktów Star Wars w sklepie stacjonarnym?
select top 1
	day(zss.DataZakupu) as [Dzieñ maja]
	,count(*) as [Liczba sprzedanych produktów]
from Produkty as p
inner join ZakupySklepStacjonarnyProdukt as zssp on p.IdProdukty = zssp.IdProduktu
inner join ZakupySklepStacjonarny as zss on zssp.IdZakup = zss.IdZakupySklepStacjonarny
where month(zss.DataZakupu) = 5 and p.Nazwa like '%Star Wars%'
group by day(zss.DataZakupu)
order by [Liczba sprzedanych produktów] desc 

-- W którym dziale jest najni¿sza œrednia wyp³ata (pensja powiêkszona o premiê – premia 30 jako 30%)
select top 1
	d.NazwaDzialu
	,cast( avg(PensjaPodstawowa * (1 + premia/100.0))  as decimal(10, 2) ) as SredniaWyplata
from Pracownicy as p
inner join Dzialy as d on p.IdDzialu = d.IdDzialy
group by d.NazwaDzialu
order by SredniaWyplata 


-- Ile razy ka¿dego dnia lutego dokonywano zakupów online
select 
	day(zso.DataZakupu) as [Dzieñ lutego]
	,count(*) as [Liczba zakupów]
from ZakupySklepOnline as zso
where month(zso.DataZakupu) = 2
group by day(zso.DataZakupu)

-- W którym dniu grudnia dokonano najwiêcej zakupów w sklepie stacjonarnym wykorzystuj¹c promocjê
select top 1
	day(zss.DataZakupu) as [Dzieñ grudnia]
	,count(*) as [Liczba zakupów z promocj¹]
from PromocjaZakupowSklepStacjonarny as pzss
inner join ZakupySklepStacjonarny as zss on pzss.IdZakupu = zss.IdZakupySklepStacjonarny
where month(zss.DataZakupu) = 12 
group by day(zss.DataZakupu)
order by  [Liczba zakupów z promocj¹] desc

-- Których zestawów LEGO nie bêd¹cych Star Wars i nie kupionych na promocji sprzeda³o siê wiêcej ni¿ 30 w sklepie stacjonarnym
select 
	p.IdProdukty
	,p.Nazwa
	,sum(zssp.Ilosc) as [Liczba sprzedanych]
from ZakupySklepStacjonarny as zss
left join PromocjaZakupowSklepStacjonarny as pzss on zss.IdZakupySklepStacjonarny = pzss.IdZakupu
inner join ZakupySklepStacjonarnyProdukt as zssp on zss.IdZakupySklepStacjonarny = zssp.IdZakup
inner join Produkty as p on zssp.IdProduktu = p.IdProdukty
where pzss.IdPromocji is null and p.Nazwa like '%Lego%' and p.Nazwa not like '%Star Wars%'
group by p.IdProdukty, p.Nazwa
having sum(zssp.Ilosc) > 30
order by p.Nazwa
