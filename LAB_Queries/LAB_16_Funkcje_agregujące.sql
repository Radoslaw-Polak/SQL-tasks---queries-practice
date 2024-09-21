use AdventureWorks2016
go
--------------------------------------------------------------------------------
-- funkcje agreguj¹ce: GROUP BY, HAVING
-- je¿eli wywo³ujemy count(*) to liczymy wszystkie rekordy a je¿eli wywo³ujemy
-- count na konkretnej kolumnie np. 
-- count(id) to liczymy wszystkie wiersze gdzie ta wartoœæ jest nieNULLOWA
--------------------------------------------------------------------------------

-- Pracujemy na tabeli Person.Person
-- -oblicz iloœæ rekordów
-- -oblicz ile osób poda³o swoje drugie imiê (kolumna MiddleName)
-- -oblicz ile osób poda³o swoje pierwsze imiê (kolumna FirstName)
-- -oblicz ile osób wyrazi³o zgodê na otrzymywanie maili (kolumna EmailPromotion ma byæ równa 1)
select count(*) as records_num
	   ,count(MiddleName) as middle_name_num
	   ,count(FirstName) as first_name_num
	   ,count(EmailPromotion) as email_promotion_num
from Person.Person
where EmailPromotion = 1;


-- Pracujemy na tabeli Sales.SalesOrderDetail
-- -wyznacz ca³kowit¹ wielkoœæ sprzeda¿y bez uwzglêdnienia rabatów - suma UnitPrice * OrderQty
-- -wyznacz ca³kowit¹ wielkoœæ sprzeda¿y z uwzglêdnieniiem rabatów - suma (UnitPrice-UnitPriceDiscount) * OrderQty
select cast( sum(UnitPrice * OrderQty) as decimal(14, 2)) as total_sales
	   ,cast(sum( (UnitPrice - UnitPriceDiscount) * OrderQty ) as decimal(14, 2)) as total_sales_with_discount
from Sales.SalesOrderDetail;


-- Pracujemy na tabeli Production.Product.
-- - dla rekordów z podkategorii 14
-- - wylicz minimaln¹ cenê, maksymaln¹ cenê, œredni¹ cenê i odchylenie standardowe dla ceny (u¿yj funkcji STDEV)
select cast( min(ListPrice) as decimal(10, 2) ) as min_
	   ,cast( max(ListPrice) as decimal(10, 2) ) as max_
	   ,cast (avg(ListPrice) as decimal(10,2) ) as avg_
	   ,cast( stdev(ListPrice) as decimal(10, 2) ) as stdev_
from Production.Product
where ProductSubcategoryID = 14;

-- Pracujemy na tabeli Sales.SalesOrderHeader.
-- -wyznacz iloœæ zamówieñ zrealizowanych przez poszczególnych pracowników (kolumna SalesPersonId)

--Wynik poprzedniego polecenia posortuj wg wyliczonej iloœci malej¹co

-- Wynik poprzedniego polecenia ogranicz do zamówieñ z 2012 roku

-- Wynik poprzedniego polecenia ogranicz tak, aby prezentowani byli te rekordy, gdzie wyznaczona suma jest wiêksza od 100000

select count(SalesPersonID) as sales_per_employee
from Sales.SalesOrderHeader
-- where year(OrderDate) = 2012
group by SalesPersonID
-- having count(SalesPersonID) > 100000
order by sales_per_employee desc;


-- Pracujemy na tabeli Sales.SalesOrderHeader. 
-- Policz ile zamówieñ by³o dostarczanych z wykorzystaniem ró¿nych metod dostawy (kolumna ShipMethodId)

select ShipMethodId
	   ,count(ShipMethodId) as orders_num
from Sales.SalesOrderHeader
group by ShipMethodId

-- Pracujemy na tabeli Production.Product
-- Napisz zapytanie, które wyœwietla:
-- -ProductID
-- -Name
-- -StandardCost
-- -ListPrice
-- -ró¿nicê miêdzy ListPrice a StandardCost. Zaaliasuj j¹ "Profit"
-- -w wyniku opuœæ te produkty które maj¹ ListPrice lub StandardCost <=0

select ProductID
	   ,Name
	   ,StandardCost
	   ,ListPrice
	   ,ListPrice - StandardCost as Profit
from Production.Product
where ListPrice > 0  and StandardCost > 0;

-- Bazuj¹c na poprzednim zapytaniu, spróbujemy wyznaczyæ jakie kategorie produktów s¹ najbardziej zyskowne.
-- Dla ka¿dej podkategorii wyznacz œredni, minimalny i maksymalny profit. Uporz¹dkuj wynik w kolejnoœci œredniego profitu malej¹co

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