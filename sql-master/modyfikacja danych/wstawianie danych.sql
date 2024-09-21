use Sklep_Internetowy_Kurs_SQL
go

-- Dodaj siebie jako klienta
insert into Klienci (Imie, Nazwisko, Wiek)
values('Rados�aw', 'Polak', 22)

select *
from Klienci

-- Dodaj do sklepu nowy produkt z telefonem, kt�rego u�ywasz
select *
from Produkty

-- przypisanie tego id dla kt�rego nazwa kategorii to 'Telefony'
insert into Produkty (Nazwa, Cena, IdKategorii)
values ('Xiaomi Redmi', 700, (select kp.IdKategorieProduktow from KategorieProduktow as kp where kp.Nazwa = 'Telefony'))

select * from KategorieProduktow


-- aktualizacja danych
-- Usu� komentarz do zam�wienia online nr 211
update ZakupySklepOnline
set Komentarz = ''
where IdZakupySklepOnline = 211

select * from ZakupySklepOnline


-- Ustaw cen� iPhone X jako �redni� cen� wszystkich iPhone
update Produkty
set Cena = (select avg(cena) from Produkty as p where p.Nazwa like '%iPhone%')
where Nazwa like '%iPhone X%'

--------
select *
from Produkty
where nazwa like '%iPhone X%'
--------
select avg(cena) 
from Produkty as p 
where p.Nazwa like '%iPhone%'


