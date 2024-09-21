use Sklep_Internetowy_Kurs_SQL

create trigger DodatnieProduktu on produkty
instead of insert 
as 
begin
	if exists (select * from Produkty where Nazwa = (select i.nazwa from inserted as i))
		begin
			select 'Produkt ju¿ istnieje'		
		end
	else
		begin
			insert into Produkty(Nazwa, Cena, IdKategorii)
			select i.Nazwa, i.Cena, i.IdKategorii from inserted as i
			select 'Dodano nowy produkt'
		end
end



