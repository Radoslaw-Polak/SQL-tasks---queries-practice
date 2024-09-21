-- Komunikat: Dodano produkt
insert into Produkty(Nazwa, Cena, IdKategorii)
values ('Motorola X1', 1999, 9)

select *
from Produkty
where nazwa like 'Motorola%'

-- Komunikat: Produkt ju¿ istnieje
insert into Produkty(Nazwa, Cena, IdKategorii)
values ('Motorola X1', 1999, 9)