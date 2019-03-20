USE WideWorldImporters
GO
--How much StockItems in any orders OrderLines in OrderID = StockItemID in OrderId? 


SELECT s.OrderID, count (s.StockItemID)
From Sales.OrderLines as s
GROUP BY s.OrderID
ORDER BY s.OrderID DESC

-- How much orders on any stockitem? 

SELECT s.StockItemID, count (s.OrderID)
From Sales.OrderLines as s
GROUP BY s.StockItemID
ORDER BY s.StockItemID DESC

-------------------------------------
---All stockitems with  urgent or ñ Animal/Animal/Chocolate
SELECT *
FROM Warehouse.StockItems
WHERE StockItemName = 'Chocolate sharks 250g'


SELECT *
FROM Warehouse.StockItems
WHERE StockItemName like '%urgent%'
------------------------------------------------
SELECT *
FROM Warehouse.StockItems
WHERE StockItemName like 'Animal%'

--2. Suppliers who do not made any orders
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

---Orders of Suppliers with Delivery as Road Freight or Post, add name of the Supplier, Name of Contact
---Name of Person who register the order

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

--id of the Client who bougth the StockItem=  Chocolate frogs 250g

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

---3. 
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

---10 last orders

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

--QUESTION???????
--- HOW TO SHOW THE  Packer WITH Full Name FROM TABLE  ÀpplicationPeople , NEED TO MAKE SECOND JOIN OR SECOND CONDITION ON JOIN? 

