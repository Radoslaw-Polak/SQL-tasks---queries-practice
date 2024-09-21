use Sklep_Internetowy_Kurs_SQL
go

-- Stw�rz widok prezentuj�cy ilo�� sprzedanych sztuk w ka�dej z kategorii w sklepie online
create view v_Kategoria_SprzedaneSztuki
as (
	select 
		kp.IdKategorieProduktow
		,kp.Nazwa
		,sum(*) as [Ilo�� sprzedanych]
	from ZakupySklepOnlineProdukt as zsop 
	inner join Produkty as p on zsop.IdProduktu = p.IdProdukty
	inner join KategorieProduktow as kp on p.IdKategorii = kp.IdKategorieProduktow
    group by kp.IdKategorieProduktow, kp.Nazwa
)

select *
from v_Kategoria_SprzedaneSztuki
order by IdKategorieProduktow

-- nie dzia�a
alter view v_Kategoria_SprzedaneSztuki
as (
	select 
		kp.IdKategorieProduktow
		,kp.Nazwa
		,sum(zsop.Ilosc) as [Ilo�� sprzedanych]
	from ZakupySklepOnlineProdukt as zsop 
	inner join Produkty as p on zsop.IdProduktu = p.IdProdukty
	inner join KategorieProduktow as kp on p.IdKategorii = kp.IdKategorieProduktow
    group by kp.IdKategorieProduktow, kp.Nazwa
	order by kp.IdKategorieProduktow
)

