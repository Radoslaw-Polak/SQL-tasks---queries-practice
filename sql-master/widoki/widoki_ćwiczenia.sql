use Sklep_Internetowy_Kurs_SQL
go

-- Stwórz widok prezentuj¹cy iloœæ sprzedanych sztuk w ka¿dej z kategorii w sklepie online
create view v_Kategoria_SprzedaneSztuki
as (
	select 
		kp.IdKategorieProduktow
		,kp.Nazwa
		,sum(*) as [Iloœæ sprzedanych]
	from ZakupySklepOnlineProdukt as zsop 
	inner join Produkty as p on zsop.IdProduktu = p.IdProdukty
	inner join KategorieProduktow as kp on p.IdKategorii = kp.IdKategorieProduktow
    group by kp.IdKategorieProduktow, kp.Nazwa
)

select *
from v_Kategoria_SprzedaneSztuki
order by IdKategorieProduktow

-- nie dzia³a
alter view v_Kategoria_SprzedaneSztuki
as (
	select 
		kp.IdKategorieProduktow
		,kp.Nazwa
		,sum(zsop.Ilosc) as [Iloœæ sprzedanych]
	from ZakupySklepOnlineProdukt as zsop 
	inner join Produkty as p on zsop.IdProduktu = p.IdProdukty
	inner join KategorieProduktow as kp on p.IdKategorii = kp.IdKategorieProduktow
    group by kp.IdKategorieProduktow, kp.Nazwa
	order by kp.IdKategorieProduktow
)

