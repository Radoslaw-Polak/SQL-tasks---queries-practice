use Sklep_Internetowy_Kurs_SQL
go

delete from ZakupySklepOnlineProdukt 
where IdZakup = 333

-- nie mo�na usun�� tylko poni�szym zapytaniem danego
-- rekordu zam�wienia je�eli w innych tabelach rekordy odwo�uj�
-- si� do klucza obcego ( w tym przypadku rekordy w tabeli ZakupySklepOnlineProdukt
-- odnosz� si� do rekordu danego zam�wienia w tabeli ZakupySklepOnline
delete from ZakupySklepOnline
where IdZakupySklepOnline = 333

select *
from ZakupySklepOnline

