use Sklep_Kurs_SQL
go

select Imie
	   ,Nazwisko
	   ,ISNULL(pesel, 'Brak peselu') as Pesel
from Pracownicy
where LEN(pesel) = 11 or PESEL is null;

select *
from Pracownicy
where cast(LEFT(pesel, 2) as int) between 80 and 89;
-- where left(pesel, 2) = '8'

select Imie
	   ,Nazwisko
	   ,LEFT(Imie, 1) + LEFT(Nazwisko, 1) as Inicja³y
from Pracownicy;

set datefirst 1
select *
	   ,DATENAME(W, DataZakupu) as dzien_tyg
from ZakupySklepOnline
where DATEPART(W, DataZakupu) in (6, 7);

select *
from Pracownicy
where substring(pesel, 4, 1) = '7';

select REPLACE(Nazwa, 'Samsung S', 'Samsung Galaxy S')
from Produkty
where Nazwa like '%Samsung S%';

select *
from Pracownicy
where month(DataZatrudnienia) between 4 and 6 and right(Imie, 1) <> 'a';
-- DATEPART(QQ, DataZatrudnienia) = 2 - okreœlenie kwarta³u na podstawie daty

select IdProdukty
	   ,replace(replace(replace(replace(replace(replace(replace(REPLACE(Nazwa, 'ó', 'o'), '³', 'l'), 'ñ', 'n'), 'œ', 's'), 'Ÿ', 'z'), '¿', 'z'), 'ê', 'e'), '¹', 'a') as Nazwa
	   ,Cena
	   ,IdKategorii
from Produkty;

select *
from Pracownicy
where cast(substring(pesel, 10, 1) as int) %2 = 0 
and len(pesel) = 11;

select replace(Nazwa, 'Samsung', 'Samsung Galaxy') as Nazwa
from Produkty
where Nazwa like 'Samsung%';

select upper(concat(Imie, ' ', Nazwisko)) as ID
from Pracownicy;

select PESEL
	   ,Imie
	   ,Nazwisko
	   ,concat(left(Imie, 1), '.', Nazwisko, '@sklep.pl') as email
from Pracownicy;

set datefirst 1
select *
from Pracownicy
where datepart(dw, DataZatrudnienia) in (6, 7);

select *
	   ,cast(PensjaPodstawowa * (1 + Premia/100.0) as decimal(8, 2)) as Wyp³ata
from Pracownicy;

select *
	   ,0.77 * Cena as Netto
from Produkty;

select *
	   ,datename(w, DataZakupu) as [Dzieñ tygodnia] 
from ZakupySklepOnline
where DATEPART(WK, '2020-03-15') - DATEPART(WK, DataZakupu) = 1;