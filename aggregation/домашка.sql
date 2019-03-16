SELECT s.OrderID, count (s.OrderLineID)
From Sales.OrderLines as s
GROUP BY s.OrderID
ORDER BY s.OrderID DESC

-- C������ ������� � ������ ������ OrderLines in OrderID = StockItemID in OrderId? 


SELECT s.OrderID, count (s.StockItemID)
From Sales.OrderLines as s
GROUP BY s.OrderID
ORDER BY s.OrderID DESC

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