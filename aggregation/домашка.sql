SELECT s.OrderID, count (s.OrderLineID)
From Sales.OrderLines as s
GROUP BY s.OrderID
ORDER BY s.OrderID DESC

USE WideWorldImporters
GO
-- C������ ������� � ������ ������ OrderLines in OrderID = StockItemID in OrderId? 


SELECT s.OrderID, count (s.StockItemID)
From Sales.OrderLines as s
GROUP BY s.OrderID
ORDER BY s.OrderID DESC

SELECT *
From Sales.Orders

SELECT *
FROM Sales.OrderLines

-- ������� ������� �� ������ ������� 

SELECT s.StockItemID, count (s.OrderID)
From Sales.OrderLines as s
GROUP BY s.StockItemID
ORDER BY s.StockItemID DESC

SELECT count (DISTINCT s.StockItemID)
From Sales.OrderLines as s


USE WideWorldImporters
GO
-- �������� �������
SELECT *
FROM Sales.OrderLines 
--------------------------------------------------------------------
-- C������ ���������� � ������� ���������� 
SELECT s.SupplierID, count (s.SupplierTransactionID)
FROM  Purchasing.SupplierTransactions as s
GROUP BY s.SupplierID

-- �������� ������� Suppliers
SELECT 
  SupplierID,
  SupplierName
FROM Purchasing.Suppliers

-----------------------------------------
-- �������� ������� Suppliers Transactions
-----------------------------------------
SELECT s.SupplierID
FROM  Purchasing.SupplierTransactions as s
GROUP BY s.SupplierID
ORDER BY s.SupplierID
--- 7 ����������� � ������������
SELECT 
  SupplierID,
  SupplierName
FROM Purchasing.Suppliers
--����� 12 ����������� 

SELECT *
FROM  Purchasing.SupplierTransactions
-------------------------------------
--2. �����������, � ������� �� ���� ������� �� ������ ������ 

SELECT *
FROM Warehouse.StockItems
WHERE StockItemName = 'Chocolate sharks 250g'
----- ������� ���� �������

---��� ������, � ������� � �������� ���� ������� urgent ��� �������� ���������� � Animal

SELECT *
FROM Warehouse.StockItems
WHERE StockItemName like '%urgent%'
------------------------------------------------
SELECT *
FROM Warehouse.StockItems
WHERE StockItemName like 'Animal%'


--ND, OR
-- ����� ������� StockItems, ��� ���� 350-500 �
-- �������� ���������� � USB ��� Ride.


SELECT RecommendedRetailPrice, *
FROM Warehouse.StockItems 
WHERE RecommendedRetailPrice between 350 AND 500 AND
   ( StockItemName like 'USB%' or StockItemName like 'Ride%')

---���� �����������, ������� ���� ��������� �� 2014� ��� � ��������� Road Freight ��� Post, �������� �������� ����������, ��� ����������� ���� ������������ �����
---10 ��������� �� ���� ������ � ������ ������� � ������ ����������, ������� ������� �����.
---��� �� � ����� �������� � �� ���������� ��������, ������� �������� ����� Chocolate frogs 250g"""

SELECT * 
FROM [Application].[DeliveryMethods]

SELECT * 
FROM [Purchasing].[Suppliers]
----���������� �� �����������

SELECT *
FROM 

SELECT * 
FROM [Purchasing].[SupplierTransactions]
---- ���������� �� ����������� ����������� � �����������
SELECT * 
FROM [Warehouse].[StockItemTransactions]

SELECT * 
FROM [Purchasing].[PurchaseOrders]
---- ����� ���� ���� �ontactPersonID
SELECT * 
FROM [Application].[People]

-----------------------------------------
---���� �����������, ������� ���� ��������� �� 2014� ��� � ��������� Road Freight ��� Post,
----����� �������� ����������, ��� ����������� ���� ������������ �����
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


--2. �����������, � ������� �� ���� ������� �� ������ ������ 
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
--������� �� ������� ��� ����������� ����� PickedbyPersonID

Select *
from Sales.Orders as s
where s.PickedByPersonID in (3,4) OR s.PickedByPersonID is NULL 
ORDER BY PickedByPersonID


SELECT *
From Sales.Orders as s

--- �� � ����� �������� � �� ���������� ��������, ������� �������� ����� Chocolate frogs 250g
---? ����� �� � �� �������� ��������� �������
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

---10 ��������� �� ���� ������ � ������ ������� � ������ ����������, ������� ������� �����.
---3. ������� � ��������� ������, � ������� ���� �������, ������� ��������,
-- �������� ��������� �������, �������� ����� � ����� ����� ���� ��������� ���� - ������ ����� �� 4 ������,
--��� ������ ������ ������ ���� ������, � ����� ������ ����� 100$ ���� ���������� ������ ������ ����� 20.

--������� ������� ����� ������� � ������������ �������� ��������� ������ 1000 � ��������� ��������� 100 �������.
--��������� ������ ���� �� ������ ��������, ����� ����, ���� �������. 

