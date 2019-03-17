
---������� � ��������� ������, � ������� ���� �������, ������� ��������, � �������� ��������� �������,
 ---�������� ����� � ����� ����� ���� ��������� ���� - ������ ����� �� 4 ������, ���� ������ ������ ������ ���� ������, 
----� ����� ������ ����� 100$ ���� ���������� ������ ������ ����� 20. 

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

---10 ��������� �� ���� ������ � ������ ������� � ������ ����������, ������� ������� �����.

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

--������?
--- ��� � ���� Packer ������� Full Name �� ������� �pplicationPeople , ������ ����� �� ������� ������?
---- ������ ������� ���������� ���� ������ ������� � ON ���������. ������ ������ - ��������� ����. 

---- ������ ���� � where ������� ������� �� ������� (v.UnitPrice * v.Quantity) fgdfg- ������ �� �����������