use Sklep_Internetowy_Kurs_SQL
go

-- transakcje
begin tran
	insert into Produkty(Nazwa, Cena, IdKategorii)
	values ('Siemens M50', 149, 9)

	select count(*) as IloscWTransakcji from Produkty

	rollback tran

select count(*) as IloscPoRollbacku from Produkty


-- zmienne
declare @mojaZmienna int = 5

select @mojaZmienna as MojaZmienna

select @@IDENTITY as Identyfikator

select @@ROWCOUNT as IloscWierszy

select *
from Produkty as p
left join Komentarze as k on p.IdProdukty = k.IdProduktu

BEGIN TRAN
	declare @uzytkownik varchar(50) = 'Krystian Bro¿ek'
	declare @data datetime = GETDATE()
	declare @nazwaKategorii varchar(50) = 'Telefony'

	declare @kategoria int = (select IdKategorieProduktow from KategorieProduktow where Nazwa = @nazwaKategorii)
	declare @iloscInsertow int = 0

	insert into Produkty(Nazwa, Cena, DataUtworzenia, UzytkownikTworzacy, IdKategorii)
	values ('Motorola Moto G6', 799, @data, @uzytkownik, @kategoria)
	select @iloscInsertow = @iloscInsertow + @@ROWCOUNT

	insert into Produkty(Nazwa, Cena, DataUtworzenia, UzytkownikTworzacy, IdKategorii)
	values ('Motorola Moto Z3', 1299, @data, @uzytkownik, @kategoria)
	select @iloscInsertow = @iloscInsertow + @@ROWCOUNT

	insert into Produkty(Nazwa, Cena, DataUtworzenia, UzytkownikTworzacy, IdKategorii)
	values ('Xiaomi Mi 6', 199, @data, @uzytkownik, @kategoria),
		('Bro¿kofon 3000', 7799, @data, @uzytkownik, @kategoria)
	select @iloscInsertow = @iloscInsertow + @@ROWCOUNT

if @iloscInsertow <> 4
	begin
		select 'Iloœæ nowych wierszy jest inna od za³o¿onej iloœci'
		rollback tran
    end
else
	begin
		commit tran
	end
	
select *
from Produkty
