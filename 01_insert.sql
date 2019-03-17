USE WideWorldImporters;

INSERT INTO Warehouse.Colors
	(ColorId, ColorName, LastEditedBy)
VALUES
	(NEXT VALUE FOR Sequences.ColorID, 'Ohra', 1);



Declare 
	@colorId INT, 
	@LastEditedBySystemUser INT,
	@SystemUserName NVARCHAR(50) = 'Data Conversion Only'
		
SET @colorId = NEXT VALUE FOR Sequences.ColorID;

SELECT @LastEditedBySystemUser = PersonID
FROM [Application].People
WHERE FullName = @SystemUserName

INSERT INTO Warehouse.Colors
	(ColorId, ColorName, LastEditedBy)
VALUES
	(@colorId, 'Ohra2', @LastEditedBySystemUser);

select ColorId, ColorName, LastEditedBy into Warehouse.Color_Copy 
from Warehouse.Colors;
--DROP TABLE Warehouse.Color_Copy

INSERT INTO Warehouse.Colors
		(ColorId, ColorName, LastEditedBy)
	OUTPUT inserted.ColorId, inserted.ColorName, inserted.LastEditedBy 
		INTO Warehouse.Color_Copy (ColorId, ColorName, LastEditedBy)
	OUTPUT inserted.ColorId
	VALUES
		(NEXT VALUE FOR Sequences.ColorID,'Dark Blue', 1), 
		(NEXT VALUE FOR Sequences.ColorID,'Light Blue', 1);

SELECT @@ROWCOUNT;


USE AdventureWorks2017;

begin tran
INSERT INTO person.address
(addressline1, addressline2, city, stateprovinceid, postalcode)
VALUES('6777 Kingsway', '', 'Burnaby', 7, 'V5H 3Z7');

SELECT @@IDENTITY, SCOPE_IDENTITY();
commit tran


SELECT top 1 * into Sales.Invoices_Q12016
FROM Sales.Invoices
WHERE InvoiceDate >= '2016-01-01' 
	AND InvoiceDate < '2016-04-01';

-- delete from Warehouse.Colors where ColorName = 'Ohra';
-- delete from Warehouse.Colors where ColorName = 'Dark Blue';
-- delete from Warehouse.Colors where ColorName = 'Light Blue';
-- delete from person.address where AddressId = 
-- drop table Sales.Invoices_Q12016;

TRUNCATE TABLE Sales.Invoices_Q12016;
 
INSERT INTO Sales.Invoices_Q12016
SELECT TOP (5) 
	InvoiceID
	,CustomerID
	,BillToCustomerID
	,OrderID + 1000 
	,DeliveryMethodID
	,ContactPersonID
	,AccountsPersonID
	,SalespersonPersonID
	,PackedByPersonID
	,InvoiceDate
	,CustomerPurchaseOrderNumber
	,IsCreditNote
	,CreditNoteReason
	,Comments
	,DeliveryInstructions
	,InternalComments
	,TotalDryItems
	,TotalChillerItems
	,DeliveryRun
	,RunPosition
	,ReturnedDeliveryData
	,[ConfirmedDeliveryTime]
	,[ConfirmedReceivedBy]
	,LastEditedBy
	,GETDATE()
FROM Sales.Invoices
WHERE InvoiceDate >= '2016-01-01' 
	AND InvoiceDate < '2016-04-01'
ORDER BY InvoiceID;


INSERT INTO Sales.Invoices_Q12016
	(InvoiceID
	,CustomerID
	,BillToCustomerID
	,OrderID 
	,DeliveryMethodID
	,ContactPersonID
	,AccountsPersonID
	,SalespersonPersonID
	,PackedByPersonID
	,InvoiceDate
	,CustomerPurchaseOrderNumber
	,IsCreditNote
	,CreditNoteReason
	,Comments
	,DeliveryInstructions
	,InternalComments
	,TotalDryItems
	,TotalChillerItems
	,DeliveryRun
	,RunPosition
	,ReturnedDeliveryData
	,[ConfirmedDeliveryTime]
	,[ConfirmedReceivedBy]
	,LastEditedBy
	,LastEditedWhen)
EXEC [LinkServer].[db].Sales.GetNewInvoices @batchsize = 10

SELECT *
FROM [Sales].[OrderLines]

INSERT INTO Sales.OrderLines
	(OrderLineID,
	OrderID,
	StockItemID,
    [Description]
	,PackageTypeID
	,[Quantity]
	,[TaxRate]
	,[PickedQuantity]
	,LastEditedBy)
VALUES
	(NEXT VALUE FOR [Sequences].[OrderLineID], 1, 164, 'fdgdfgdf',
	7, 50, 15.000, 50, 4);


	INSERT INTO Warehouse.Colors
	(ColorId, ColorName, LastEditedBy)
VALUES
	(NEXT VALUE FOR Sequences.ColorID, 'Ohra', 1);

--gfhfghgfhfghfgh