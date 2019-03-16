SELECT s.OrderID, count (s.OrderLineID)
From Sales.OrderLines as s
GROUP BY s.OrderID
ORDER BY s.OrderID DESC

USE WideWorldImporters
GO
-- Cколько позиций в каждом заказе OrderLines in OrderID = StockItemID in OrderId? 


SELECT s.OrderID, count (s.StockItemID)
From Sales.OrderLines as s
GROUP BY s.OrderID
ORDER BY s.OrderID DESC

SELECT *
From Sales.Orders

SELECT *
FROM Sales.OrderLines

-- Сколько заказов на каждую позицию 

SELECT s.StockItemID, count (s.OrderID)
From Sales.OrderLines as s
GROUP BY s.StockItemID
ORDER BY s.StockItemID DESC

SELECT count (DISTINCT s.StockItemID)
From Sales.OrderLines as s


USE WideWorldImporters
GO
-- Исходная таблицы
SELECT *
FROM Sales.OrderLines 
--------------------------------------------------------------------
-- Cколько транзакций у каждого поставщика 
SELECT s.SupplierID, count (s.SupplierTransactionID)
FROM  Purchasing.SupplierTransactions as s
GROUP BY s.SupplierID

-- Исходная таблица Suppliers
SELECT 
  SupplierID,
  SupplierName
FROM Purchasing.Suppliers

-----------------------------------------
-- Исходные таблицы Suppliers Transactions
-----------------------------------------
SELECT s.SupplierID
FROM  Purchasing.SupplierTransactions as s
GROUP BY s.SupplierID
ORDER BY s.SupplierID
--- 7 поставщиков с транзакциями
SELECT 
  SupplierID,
  SupplierName
FROM Purchasing.Suppliers
--всего 12 поставщиков 

SELECT *
FROM  Purchasing.SupplierTransactions
-------------------------------------
--2. Поставщиков, у которых не было сделано ни одного заказа 

SELECT *
FROM Warehouse.StockItems
WHERE StockItemName = 'Chocolate sharks 250g'
----- находим одну строчку

---Все товары, в которых в название есть пометка urgent или название начинается с Animal

SELECT *
FROM Warehouse.StockItems
WHERE StockItemName like '%urgent%'
------------------------------------------------
SELECT *
FROM Warehouse.StockItems
WHERE StockItemName like 'Animal%'


--ND, OR
-- нужно вывести StockItems, где цена 350-500 и
-- название начинается с USB или Ride.


SELECT RecommendedRetailPrice, *
FROM Warehouse.StockItems 
WHERE RecommendedRetailPrice between 350 AND 500 AND
   ( StockItemName like 'USB%' or StockItemName like 'Ride%')

---казы поставщикам, которые были исполнены за 2014й год с доставкой Road Freight или Post, добавьте название поставщика, имя контактного лица принимавшего заказ
---10 последних по дате продаж с именем клиента и именем сотрудника, который оформил заказ.
---Все ид и имена клиентов и их контактные телефоны, которые покупали товар Chocolate frogs 250g"""

SELECT * 
FROM [Application].[DeliveryMethods]

SELECT * 
FROM [Purchasing].[Suppliers]
----информация по поставщикам

SELECT *
FROM 

SELECT * 
FROM [Purchasing].[SupplierTransactions]
---- информация по транзакциям совершенные к поставщикам
SELECT * 
FROM [Warehouse].[StockItemTransactions]

SELECT * 
FROM [Purchasing].[PurchaseOrders]
---- здесь есть поле СontactPersonID
SELECT * 
FROM [Application].[People]

-----------------------------------------
---казы поставщикам, которые были исполнены за 2014й год с доставкой Road Freight или Post,
----авьте название поставщика, имя контактного лица принимавшего заказ
SELECT   
  s.SupplierID,
  s.SupplierName,
  s.PrimaryContactPersonID,
  p.[FullName],
  t.SupplierTransactionID,
  t.SupplierID,
  t.TransactionDate,
  t.TransactionAmount,
  m.DeliveryMethodName
FROM Purchasing.Suppliers s
/*INNER */ JOIN Purchasing.SupplierTransactions t
	ON t.SupplierID = s.SupplierID
	Join [Application].[DeliveryMethods] m
	ON s.DeliveryMethodID = m.DeliveryMethodID
	JOIN Application.People p 
	ON p.PersonID = s.PrimaryContactPersonID
WHERE year (t.TransactionDate) = 2014 AND (m.DeliveryMethodName = 'Post' or m.DeliveryMethodName = 'Road Freight')
ORDER BY s.SupplierID


--2. Поставщиков, у которых не было сделано ни одного заказа 
SELECT   
  s.SupplierID,
  s.SupplierName,
  t.SupplierTransactionID,
  t.SupplierID,
  t.TransactionDate,
  t.TransactionAmount
FROM Purchasing.Suppliers s
LEFT JOIN Purchasing.SupplierTransactions t 
	ON t.SupplierID = s.SupplierID
	WHERE 
t.SupplierTransactionID is null
ORDER BY s.SupplierID
-------------------------------------------------------
SELECT DISTINCT s.PickingCompletedWhen
From Sales.Orders as s
Order by s.PickingCompletedWhen

SELECT COUNT (DISTINCT s.PickingCompletedWhen)
From Sales.Orders as s
-----------------------------------------------------
--смотрим по колонке кто сформировал заказ PickedbyPersonID

Select *
from Sales.Orders as s
where s.PickedByPersonID in (3,4) OR s.PickedByPersonID is NULL 
ORDER BY PickedByPersonID


SELECT *
From Sales.Orders as s

--- ид и имена клиентов и их контактные телефоны, которые покупали товар Chocolate frogs 250g
---? можно ли в он добавить несколько условий
SELECT 
s.StockItemID,
s.StockItemName,
l.OrderID,
l.OrderLineID,
o.SalespersonPersonID,
o.CustomerID,
o.ContactPersonID,
p.FullName,
p.PhoneNumber
FROM Warehouse.StockItems as s
Join Sales.OrderLines as l
on l.StockItemID = s.StockItemID
Join Sales.Orders as o 
on o.OrderID = l.OrderID
JOIN Application.People p 
	ON p.PersonID = o.CustomerID
WHERE 
   StockItemName = 'Chocolate frogs 250g'

   SELECT *
From Sales.Orders

SELECT *
FROM Sales.OrderLines

---10 последних по дате продаж с именем клиента и именем сотрудника, который оформил заказ.
---3. Продажи с названием месяца, в котором была продажа, номером квартала,
-- которому относится продажа, включите также к какой трети года относится дата - каждая треть по 4 месяца,
--ата забора заказа должна быть задана, с ценой товара более 100$ либо количество единиц товара более 20.

--обавьте вариант этого запроса с постраничной выборкой пропустив первую 1000 и отобразив следующие 100 записей.
--оритровка должна быть по номеру квартала, трети года, дате продажи. 

