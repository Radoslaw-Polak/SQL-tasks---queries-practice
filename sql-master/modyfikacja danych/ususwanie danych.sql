use Sklep_Internetowy_Kurs_SQL
go

delete from ZakupySklepOnlineProdukt 
where IdZakup = 333

-- nie mo¿na usun¹æ tylko poni¿szym zapytaniem danego
-- rekordu zamówienia je¿eli w innych tabelach rekordy odwo³uj¹
-- siê do klucza obcego ( w tym przypadku rekordy w tabeli ZakupySklepOnlineProdukt
-- odnosz¹ siê do rekordu danego zamówienia w tabeli ZakupySklepOnline
delete from ZakupySklepOnline
where IdZakupySklepOnline = 333

select *
from ZakupySklepOnline

