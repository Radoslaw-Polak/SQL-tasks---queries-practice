use Sklep_Kurs_SQL
go

--funkcje tekstowe
select Imie
	   ,Nazwisko
	   ,'19' + LEFT(PESEL, 2) as rok_urodzenia
from Pracownicy
where LEN(pesel) = 11

select concat('Pani ',Imie,' ',Nazwisko)
from Pracownicy
where RIGHT(Imie, 1) = 'a'

--funkcje matematyczne
select ROUND(PI(),4)

--funkcje daty i czasu
select *
from ZakupySklepOnline
where datepart(HH, DataZakupu) between '00' and '05'

select DATEDIFF(WK,'2001-09-23', GETDATE())

--funkcje konwersji
select Nazwa
	   ,cast(Cena as decimal(10, 2)) as kwota
from Produkty
