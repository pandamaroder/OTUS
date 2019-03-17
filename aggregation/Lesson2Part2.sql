
---Продажи с названием месяца, в котором была продажа, номером квартала, к которому относится продажа,
 ---включите также к какой трети года относится дата - каждая треть по 4 месяца, дата забора заказа должна быть задана, 
----с ценой товара более 100$ либо количество единиц товара более 20. 

SELECT DATENAME ( qq , s.OrderDate ) as OneThirdYear , DATENAME ( m , s.OrderDate ) as Months, s.OrderDate,
s.OrderID, s.CustomerID, l.PickingCompletedWhen, v.Quantity, v.UnitPrice,
   CASE 
      WHEN DATEPART (mm, s.OrderDate ) in (1,2,3,4) THEN 1
	  WHEN DATEPART (mm, s.OrderDate ) in (5,6,7,8) THEN 2
	  ELSE 3
	  END as ThroughTheCaseCondition
From Sales.Orders as s
JOIN Sales.OrderLines as l
on l.OrderID = s.OrderID
JOIN Sales.Invoices as i
on s.OrderID = i.OrderID
JOIN Sales.InvoiceLines as v
on v.InvoiceID= i.InvoiceID
WHERE v.Quantity > 10 or v.UnitPrice >100
Order by Months DESC offset 0 rows fetch next 50 rows only;

---10 последних по дате продаж с именем клиента и именем сотрудника, который оформил заказ.

SELECT TOP 10 
s.OrderID,
p.FullName as SalesPerson,
s.OrderDate,
i.PackedByPersonID as Packer,
c.CustomerName,
v.InvoiceID,
(v.UnitPrice * v.Quantity) fgdfg,
v.Quantity
FROM [Sales].[Orders] as s
JOIN Sales.Invoices as i
on s.OrderID = i.OrderID
JOIN Application.People p 
	ON p.PersonID = s.SalespersonPersonID
JOIN Sales.Customers as c
on c.CustomerID= s.CustomerID
JOIN Sales.InvoiceLines as v
on v.InvoiceID= i.InvoiceID
WHERE v.Quantity > 10
ORDER BY s.OrderDate DESC

--Вопрос?
--- Как в поле Packer вывести Full Name из таблицы АpplicationPeople , второй джойн на таблицу делать?
---- другую выборку возвращает если второе условие в ON добавлять. ПОчему другая - непонятно тоже. 

---- Почему если в where добавть условие по столбцу (v.UnitPrice * v.Quantity) fgdfg- запрос не выполняется

SELECT ContactPersonID
From  Sales.Orders
Where ContactPersonID = 3032

SELECT *
From Sales.Orders

SELECT DISTINCT ContactPersonID
From  Sales.Orders

SELECT RecommendedRetailPrice, *
From Warehouse.StockItems
WHERE RecommendedRetailPrice BETWEEN 350 AND 500 and 
(StockItemName like 'USB%' OR StockItemName like 'Ride%')

--использование функций в where 
-- найти заказы у которых дата заказа 2013 год 
SELECT *
FROM Sales.Orders o
WHERE year(OrderDate) = 2013

SELECT *
From Sales.Orders o 
Where OrderDate = '2013-01-01'

Drop Index if exists IX_Sales_Orders_OrderDate ON Sales.Orders
CREATE INDEX IX_Sales_Orders_OrderDate ON Sales.Orders(OrderDate)

SELECT OrderID, PickingCompletedWhen
From Sales.Orders
Where PickingCompletedWhen is not NULL

SELECT 3 + isnull(null, 0)

--разный формат строк
SELECT Orderid, isnull(PickingCompletedWhen, 'Unknown') AS PickingCompletedWhen
From Sales.Orders

SELECT Orderid, isnull(Convert(nvarchar(10), PickingCompletedWhen, 104), 'Unknown') AS PickingCompletedWhen
From Sales.Orders
ORDER BY PickingCompletedWhen

SELECT DISTINCT PickingCompletedWhen
FROM Sales.Orders
Order by PickingCompletedWhen

Convert(nvchar(10), PickingCompletedWhen, 104)
-- здесь нул не считает
SELECT COUNT(Distinct PickingCompletedWhen)
From Sales.Orders

---- IN 
SELECT *
FROM Sales.Orders
Where OrderID in (1,3,5)
--= эквивалентно, при этом в ине можно писать подзапросы
SELECT *
FROM Sales.Orders
Where OrderID =1 or OrderID= 3 or OrderID = 5

SELECT *
FROM Sales.Orders
where PickedByPersonID in (3,4,null)
ORDER BY PickedByPersonID
-- если с SET ANSI_NULLs  on то не выполниться
SET ANSI_NULLs on

SELECT *
FROM Sales.Orders
where PickedByPersonID in (3,4) or PickedByPersonID is NULL
ORDER BY PickedByPersonID

SET DATEFORMAT dmy
SELECT *
FROM Sales.Orders
WHERE OrderDate > '01.05.2016'   -- 1 мая 01.05.2016
ORDER BY OrderDate

SET DATEFORMAT mdy
SELECT *
FROM Sales.Orders
WHERE OrderDate > '01.05.2016'   -- 5 января 05.01.2016
ORDER BY OrderDate

--опция dateformat на это не влияет 

---gfdgdfgdfgd
SET DATEFORMAT mdy
SELECT *
FROM Sales.Orders
WHERE OrderDate > '20160501'   -- 5 января 05.01.2016
ORDER BY OrderDate

--Mounth Day Year
SELECT DISTINCT o.OrderDate,
       MONTH(o.OrderDate) AS OrderMounth,
	   DAY(o.OrderDate) as OrderDay,
	   YEAR(o.OrderDate) as OrderYear
FROM Sales.Orders as o

--более общая функция это DatePart ( datepart, date )

SELECT o.OrderID, 
       o.OrderDate,
	   DATEPART(m, o.OrderDate) as OrderMounth,
	   DATEPART(d, o.OrderDate) as OrderDay,
	   DATEPART(yy, o.OrderDate) as OrderYear
FROM Sales.Orders as o




SELECT DATENAME ( qq , s.OrderDate ) as OneThirdYear , DATENAME ( m , s.OrderDate ) as Months, s.OrderDate,
s.OrderID, s.CustomerID, l.PickingCompletedWhen, v.Quantity, v.UnitPrice,
   CASE 
      WHEN DATEPART (mm, s.OrderDate ) in (1,2,3,4) THEN 1
	  WHEN DATEPART (mm, s.OrderDate ) in (5,6,7,8) THEN 2
	  ELSE 3
	  END as ThroughTheCaseCondition
From Sales.Orders as s
JOIN Sales.OrderLines as l
on l.OrderID = s.OrderID
JOIN Sales.Invoices as i
on s.OrderID = i.OrderID
JOIN Sales.InvoiceLines as v
on v.InvoiceID= i.InvoiceID
WHERE v.Quantity > 10 or v.UnitPrice >100

---  почему сортировка по orderDate идет?
---gfdgdfgdfgd



