use AdventureWorks2016
go
--------------------------------------------------------------------------------
-- funkcje agreguj�ce: GROUP BY, HAVING
-- je�eli wywo�ujemy count(*) to liczymy wszystkie rekordy a je�eli wywo�ujemy
-- count na konkretnej kolumnie np. 
-- count(id) to liczymy wszystkie wiersze gdzie ta warto�� jest nieNULLOWA
--------------------------------------------------------------------------------

-- Pracujemy na tabeli Person.Person
-- -oblicz ilo�� rekord�w
-- -oblicz ile os�b poda�o swoje drugie imi� (kolumna MiddleName)
-- -oblicz ile os�b poda�o swoje pierwsze imi� (kolumna FirstName)
-- -oblicz ile os�b wyrazi�o zgod� na otrzymywanie maili (kolumna EmailPromotion ma by� r�wna 1)
select count(*) as records_num
	   ,count(MiddleName) as middle_name_num
	   ,count(FirstName) as first_name_num
	   ,count(EmailPromotion) as email_promotion_num
from Person.Person
where EmailPromotion = 1;


-- Pracujemy na tabeli Sales.SalesOrderDetail
-- -wyznacz ca�kowit� wielko�� sprzeda�y bez uwzgl�dnienia rabat�w - suma UnitPrice * OrderQty
-- -wyznacz ca�kowit� wielko�� sprzeda�y z uwzgl�dnieniiem rabat�w - suma (UnitPrice-UnitPriceDiscount) * OrderQty
select cast( sum(UnitPrice * OrderQty) as decimal(14, 2)) as total_sales
	   ,cast(sum( (UnitPrice - UnitPriceDiscount) * OrderQty ) as decimal(14, 2)) as total_sales_with_discount
from Sales.SalesOrderDetail;


-- Pracujemy na tabeli Production.Product.
-- - dla rekord�w z podkategorii 14
-- - wylicz minimaln� cen�, maksymaln� cen�, �redni� cen� i odchylenie standardowe dla ceny (u�yj funkcji STDEV)
select cast( min(ListPrice) as decimal(10, 2) ) as min_
	   ,cast( max(ListPrice) as decimal(10, 2) ) as max_
	   ,cast (avg(ListPrice) as decimal(10,2) ) as avg_
	   ,cast( stdev(ListPrice) as decimal(10, 2) ) as stdev_
from Production.Product
where ProductSubcategoryID = 14;

-- Pracujemy na tabeli Sales.SalesOrderHeader.
-- -wyznacz ilo�� zam�wie� zrealizowanych przez poszczeg�lnych pracownik�w (kolumna SalesPersonId)

--Wynik poprzedniego polecenia posortuj wg wyliczonej ilo�ci malej�co

-- Wynik poprzedniego polecenia ogranicz do zam�wie� z 2012 roku

-- Wynik poprzedniego polecenia ogranicz tak, aby prezentowani byli te rekordy, gdzie wyznaczona suma jest wi�ksza od 100000

select count(SalesPersonID) as sales_per_employee
from Sales.SalesOrderHeader
-- where year(OrderDate) = 2012
group by SalesPersonID
-- having count(SalesPersonID) > 100000
order by sales_per_employee desc;


-- Pracujemy na tabeli Sales.SalesOrderHeader. 
-- Policz ile zam�wie� by�o dostarczanych z wykorzystaniem r�nych metod dostawy (kolumna ShipMethodId)

select ShipMethodId
	   ,count(ShipMethodId) as orders_num
from Sales.SalesOrderHeader
group by ShipMethodId

-- Pracujemy na tabeli Production.Product
-- Napisz zapytanie, kt�re wy�wietla:
-- -ProductID
-- -Name
-- -StandardCost
-- -ListPrice
-- -r�nic� mi�dzy ListPrice a StandardCost. Zaaliasuj j� "Profit"
-- -w wyniku opu�� te produkty kt�re maj� ListPrice lub StandardCost <=0

select ProductID
	   ,Name
	   ,StandardCost
	   ,ListPrice
	   ,ListPrice - StandardCost as Profit
from Production.Product
where ListPrice > 0  and StandardCost > 0;

-- Bazuj�c na poprzednim zapytaniu, spr�bujemy wyznaczy� jakie kategorie produkt�w s� najbardziej zyskowne.
-- Dla ka�dej podkategorii wyznacz �redni, minimalny i maksymalny profit. Uporz�dkuj wynik w kolejno�ci �redniego profitu malej�co

select ProductID
	   ,Name
	   ,StandardCost
	   ,ListPrice
	   ,ListPrice - StandardCost as Profit
from Production.Product
where ListPrice > 0  and StandardCost > 0;

select ProductSubcategoryID
	   ,cast( avg(ListPrice - StandardCost) as decimal(10, 2) ) as avg_profit
	   ,cast( min(ListPrice - StandardCost) as decimal(10, 2) ) as min_profit
	   ,cast( max(ListPrice - StandardCost) as decimal(10, 2) ) as max_profit
from Production.Product
where ListPrice > 0  and StandardCost > 0
group by ProductSubcategoryID
order by avg_profit desc