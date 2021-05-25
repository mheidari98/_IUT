	USE [NorthWindStorageArea]
	GO

		/****** 
		
				Team Members:  SaraBaradaran, MahdiHeidari, AminEmamJomeh
				Script Date: January 1, 2021
		
		******/


	SET ANSI_NULLS ON
	GO

	SET QUOTED_IDENTIFIER ON
	GO
	
-- ####>>>> CREATE TABLE

	CREATE TABLE [dbo].[Customers](
		[ID] [int] NOT NULL,
		[Company] [nvarchar](60) NULL,
		[Last Name] [nvarchar](60) NULL,
		[First Name] [nvarchar](60) NULL,
		[E-mail Address] [nvarchar](60) NULL,
		[Job Title] [nvarchar](60) NULL,
		[Business Phone] [nvarchar](35) NULL,
		[Home Phone] [nvarchar](35) NULL,
		[Mobile Phone] [nvarchar](35) NULL,
		[Fax Number] [nvarchar](35) NULL,
		[Address] [nvarchar](max) NULL,
		[City] [nvarchar](60) NULL,
		[State/Province] [nvarchar](60) NULL,
		[ZIP/Postal Code] [nvarchar](25) NULL,
		[Country/Region] [nvarchar](60) NULL,
		[Web Page] [nvarchar](max) NULL,
		[Notes] [nvarchar](max) NULL,
	 CONSTRAINT [Customers$PrimaryKey] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	GO

	CREATE TABLE [dbo].[Employees](
		[ID] [int] NOT NULL,
		[Last Name] [nvarchar](60) NULL,
		[First Name] [nvarchar](60) NULL,
		[E-mail Address] [nvarchar](60) NULL,
		[Job Title] [nvarchar](60) NULL,
		[Business Phone] [nvarchar](35) NULL,
		[Home Phone] [nvarchar](35) NULL,
		[Mobile Phone] [nvarchar](35) NULL,
		[Fax Number] [nvarchar](35) NULL,
		[Address] [nvarchar](max) NULL,
		[City] [nvarchar](60) NULL,
		[State/Province] [nvarchar](60) NULL,
		[ZIP/Postal Code] [nvarchar](25) NULL,
		[Country/Region] [nvarchar](60) NULL,
		[Web Page] [nvarchar](max) NULL,
		[CreditCard Number] [nvarchar] (20) NULL,
		[Hire Date] [Date] NULL,
		[Birth Date] [Date] NULL,
		[Gender] [nvarchar](8) NULL,
		[Marital Status] [nvarchar](8) NULL,		--SCD1
		[National Code] [nvarchar](12) NULL,
		[Annual Leave Hours] [tinyint] NULL,		--SCD3
		[Annual Base Salary] [money] NULL,
		[Notes] [nvarchar](max) NULL,
	 CONSTRAINT [Employees$PrimaryKey] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	GO

	CREATE TABLE [dbo].[Shippers](
		[ID] [int] NOT NULL,
		[Company] [nvarchar](60) NULL,
		[Last Name] [nvarchar](60) NULL,
		[First Name] [nvarchar](60) NULL,
		[E-mail Address] [nvarchar](60) NULL,
		[Job Title] [nvarchar](60) NULL,
		[Business Phone] [nvarchar](35) NULL,
		[Home Phone] [nvarchar](35) NULL,
		[Mobile Phone] [nvarchar](35) NULL,
		[Fax Number] [nvarchar](35) NULL,
		[Address] [nvarchar](max) NULL,
		[City] [nvarchar](60) NULL,
		[State/Province] [nvarchar](60) NULL,
		[ZIP/Postal Code] [nvarchar](25) NULL,
		[Country/Region] [nvarchar](60) NULL,
		[Web Page] [nvarchar](max) NULL,
		[CreditCard Number] [nvarchar] (20) NULL,
		[Notes] [nvarchar](max) NULL,
	 CONSTRAINT [Shippers$PrimaryKey] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	GO

	CREATE TABLE [dbo].[Suppliers](
		[ID] [int] NOT NULL,
		[Company] [nvarchar](60) NULL,
		[Last Name] [nvarchar](60) NULL,
		[First Name] [nvarchar](60) NULL,
		[E-mail Address] [nvarchar](60) NULL,
		[Job Title] [nvarchar](60) NULL,
		[Business Phone] [nvarchar](35) NULL,
		[Home Phone] [nvarchar](35) NULL,
		[Mobile Phone] [nvarchar](35) NULL,
		[Fax Number] [nvarchar](35) NULL,
		[Address] [nvarchar](max) NULL,
		[City] [nvarchar](60) NULL,
		[State/Province] [nvarchar](60) NULL,
		[ZIP/Postal Code] [nvarchar](25) NULL,
		[Country/Region] [nvarchar](60) NULL,
		[Web Page] [nvarchar](max) NULL,
		[CreditCard Number] [nvarchar] (20) NULL,
		[Notes] [nvarchar](max) NULL,
	 CONSTRAINT [Suppliers$PrimaryKey] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	GO

	CREATE TABLE [dbo].[Products](
		[ID] [int] NOT NULL,
		[Product Code] [nvarchar](35) NULL,
		[Product Name] [nvarchar](60) NULL,
		[Description] [nvarchar](max) NULL,
		[Standard Cost] [money] NULL,
		[List Price] [money] NULL,
		[Reorder Level] [smallint] NULL,
		[Target Level] [int] NULL,
		[Quantity Per Unit] [nvarchar](60) NULL,
		[Discontinued] [nvarchar](10) NULL,
		[Minimum Reorder Quantity] [smallint] NULL,
		[Category] [nvarchar](60) NULL,
	 CONSTRAINT [Products$PrimaryKey] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	GO
	
	CREATE TABLE [dbo].[EmployeeSalary](
		[EmployeeID] [int] NOT NULL,
		[BaseSalary] [money] NULL,
		[OvertimePaid] [money] NULL,
		[PerformanceBonus] [money] NULL,
		[IncentiveAllowance] [money] NULL,
		[PaymentDate] [date] NULL,
		[PaymentMethod] [nvarchar](60) NULL,
		[Check ID] [int] NULL,
	PRIMARY KEY CLUSTERED 
	(
		[EmployeeID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	GO

	CREATE TABLE [dbo].[CheckINfo](
		[ID] [int] IDENTITY(1,1) NOT NULL,
		[CheckNumber] [nvarchar](20) NULL,
		[CheckType] [int] NULL,
		[Status] [int] NULL,
		[AccountNumber] [nvarchar](20) NULL,
		[Amount] [money] NULL,
		[Bank] [nvarchar](60) NULL,
		[branch] [nvarchar](30) NULL,
		[IBAN] [nvarchar](20) NULL,
		[DueDate] [date] NULL,
		[Note] [nvarchar](100) NULL,
	PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	GO

	CREATE TABLE [dbo].[Check Type](
		[ID] [tinyint] NOT NULL,
		[Type] [nvarchar](30) NULL
	) ON [PRIMARY]
	GO
	
	CREATE TABLE [dbo].[Check Status](
		[ID] [tinyint] NOT NULL,
		[Status] [nvarchar](30) NULL
	) ON [PRIMARY]
	GO

	CREATE TABLE [dbo].[Purchase Orders](
		[Purchase Order ID] [int] NOT NULL,
		[Supplier ID] [int] NULL,
		[Creator] [int] NULL,
		[Approver] [int] NULL,
		[Submitter] [int] NULL,
		[Creation Date] [Date] NULL,
		[Approved Date] [Date] NULL,
		[Submitted Date] [Date] NULL,
		[Expected Date] [Date] NULL,
		[Status ID] [int] NULL,
		[Shipping Fee] [money] NULL,
		[Taxes] [money] NULL,
		[Payment Date] [Date] NULL,
		[Payment Amount] [money] NULL,
		[Payment Method] [nvarchar](60) NULL,
		[Notes] [nvarchar](max) NULL,
		[Check ID] [int] NULL,
	 CONSTRAINT [Purchase Orders$PrimaryKey] PRIMARY KEY CLUSTERED 
	(
		[Purchase Order ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	GO

	CREATE TABLE [dbo].[Purchase Order Status](
		[Status ID] [int] NOT NULL,
		[Status] [nvarchar](60) NULL,
	 CONSTRAINT [Purchase Order Status$PrimaryKey] PRIMARY KEY CLUSTERED 
	(
		[Status ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	GO

	CREATE TABLE [dbo].[Purchase Order Details](
		[ID] [int] NOT NULL,
		[Purchase Order ID] [int] NOT NULL,
		[Product ID] [int] NULL,
		[Quantity] [float] NULL,
		[Unit Cost] [money] NULL,
		[Date Received] [Date] NULL,
	 CONSTRAINT [Purchase Order Details$PrimaryKey] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	GO

	CREATE TABLE [dbo].[Orders Tax Status](
		[ID] [tinyint] NOT NULL,
		[Tax Status Name] [nvarchar](60) NULL,
	 CONSTRAINT [Orders Tax Status$PrimaryKey] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	GO

	CREATE TABLE [dbo].[Orders Status](
		[Status ID] [tinyint] NOT NULL,
		[Status Name] [nvarchar](60) NULL,
	 CONSTRAINT [Orders Status$PrimaryKey] PRIMARY KEY CLUSTERED 
	(
		[Status ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	GO

	CREATE TABLE [dbo].[Orders](
		[Order ID] [int] NOT NULL,
		[Employee ID] [int] NULL,
		[Customer ID] [int] NULL,
		[Order Date] [Date] NULL,
		[Shipped Date] [Date] NULL,
		[Shipper ID] [int] NULL,
		[Ship Name] [nvarchar](60) NULL,
		[Ship Address] [nvarchar](max) NULL,
		[Ship City] [nvarchar](60) NULL,
		[Ship State/Province] [nvarchar](60) NULL,
		[Ship ZIP/Postal Code] [nvarchar](60) NULL,
		[Ship Country/Region] [nvarchar](60) NULL,
		[Shipping Fee] [money] NULL,
		[Taxes] [money] NULL,
		[Payment Type] [nvarchar](60) NULL,
		[Paid Date] [Date] NULL,
		[Notes] [nvarchar](max) NULL,
		[Tax Rate] [float] NULL,
		[Tax Status] [tinyint] NULL,
		[Status ID] [tinyint] NULL,
		[Check ID] [int] NULL,
	 CONSTRAINT [Orders$PrimaryKey] PRIMARY KEY CLUSTERED 
	(
		[Order ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	GO

	CREATE TABLE [dbo].[Order Details Status](
		[Status ID] [int] NOT NULL,
		[Status Name] [nvarchar](60) NOT NULL,
	 CONSTRAINT [Order Details Status$PrimaryKey] PRIMARY KEY CLUSTERED 
	(
		[Status ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	GO

	CREATE TABLE [dbo].[Order Details](
		[ID] [int] NOT NULL,
		[Order ID] [int] NOT NULL,
		[Product ID] [int] NULL,
		[Quantity] [float] NULL,
		[Unit Price] [money] NULL,
		[Discount] [float] NULL,
		[Status ID] [int] NULL,
		[Date Allocated] [Date] NULL,
	 CONSTRAINT [Order Details$PrimaryKey] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	GO

-- ####>>>> CREATE PROCEDURE

	USE [NorthWindStorageArea]
	GO
	CREATE PROCEDURE [dbo].Suppliers_LoadData
	AS
	BEGIN
		TRUNCATE TABLE Suppliers
		INSERT INTO Suppliers
			SELECT [ID],[Company],[Last Name],[First Name],[E-mail Address],
			[Job Title],[Business Phone],[Home Phone],[Mobile Phone],[Fax Number],
			[Address],[City],[State/Province],[ZIP/Postal Code],[Country/Region],
			[Web Page],[CreditCard Number],[Notes]
			FROM [Northwind2007].dbo.Suppliers 
	END;

	--USE [NorthWindStorageArea]
	GO
	CREATE PROCEDURE [dbo].Products_LoadData
	AS
	BEGIN
		TRUNCATE TABLE Products
		INSERT INTO Products
			SELECT [ID],[Product Code],[Product Name],[Description],[Standard Cost],
			[List Price],[Reorder Level],[Target Level],[Quantity Per Unit],
			CASE WHEN [Discontinued] = 1 THEN 'No Stock' WHEN [Discontinued] = 0 THEN 'In Stock' END,
			[Minimum Reorder Quantity],[Category]
			FROM [Northwind2007].dbo.Products
	END;

	--USE [NorthWindStorageArea]
	GO
	CREATE PROCEDURE [dbo].Shippers_LoadData
	AS
	BEGIN
		TRUNCATE TABLE Shippers
		INSERT INTO Shippers
			SELECT [ID],[Company],[Last Name],[First Name],[E-mail Address],
			[Job Title],[Business Phone],[Home Phone],[Mobile Phone],[Fax Number],
			[Address],[City],[State/Province],[ZIP/Postal Code],[Country/Region],
			[Web Page],[CreditCard Number],[Notes]
			FROM [Northwind2007].dbo.Shippers 
	END;

	--USE [NorthWindStorageArea]
	GO
	CREATE PROCEDURE [dbo].Customers_LoadData
	AS
	BEGIN
		TRUNCATE TABLE Customers
		INSERT INTO Customers
			SELECT [ID],[Company],[Last Name],[First Name],[E-mail Address],
			[Job Title],[Business Phone],[Home Phone],[Mobile Phone],[Fax Number],
			[Address],[City],[State/Province],[ZIP/Postal Code],[Country/Region],
			[Web Page],[Notes]
			FROM [Northwind2007].dbo.Customers 
	END;

	--USE [NorthWindStorageArea]
	GO
	CREATE PROCEDURE [dbo].Employees_LoadData
	AS
	BEGIN
		TRUNCATE TABLE Employees
		INSERT INTO Employees
			SELECT [ID],[Last Name],[First Name],[E-mail Address],
			[Job Title],[Business Phone],[Home Phone],[Mobile Phone],[Fax Number],
			[Address],[City],[State/Province],[ZIP/Postal Code],[Country/Region],
			[Web Page],[CreditCard Number],[HireDate],[BirthDate],
			CASE WHEN [Gender] = 'F' THEN 'Female' WHEN [Gender] ='M' THEN 'Male' END,
			CASE WHEN [Marital Status] = 'S' THEN 'Single' 
				 WHEN [Marital Status] = 'M' THEN 'Married' 
				 WHEN [Marital Status] = 'D' THEN 'Divorced' 
				 WHEN [Marital Status] = 'W' THEN 'Widowed' END,
			[National Code],[Annual Leave Hours],[Annual Base Salary], [Notes]
			FROM [Northwind2007].dbo.Employees
	END;
	
	--USE [NorthWindStorageArea]
	GO
	CREATE PROCEDURE [dbo].PurchaseOrderStatus_LoadData
	AS
	BEGIN
		TRUNCATE TABLE [Purchase Order Status]
		INSERT INTO [Purchase Order Status]
			SELECT [Status ID], [Status]
			FROM [Northwind2007].dbo.[Purchase Order Status]
	END

	--USE [NorthWindStorageArea]
	GO
	CREATE PROCEDURE [dbo].OrdersTaxStatus_LoadData
	AS
	BEGIN
		TRUNCATE TABLE [Orders Tax Status]
		INSERT INTO [Orders Tax Status]
			SELECT [ID], [Tax Status Name]
			FROM [Northwind2007].dbo.[Orders Tax Status]
	END

	--USE [NorthWindStorageArea]
	GO
	CREATE PROCEDURE [dbo].OrdersStatus_LoadData
	AS
	BEGIN
		TRUNCATE TABLE [Orders Status]
		INSERT INTO [Orders Status]
			SELECT [Status ID], [Status Name]
			FROM [Northwind2007].dbo.[Orders Status]
	END

	--USE [NorthWindStorageArea]
	GO
	CREATE PROCEDURE [dbo].OrderDetailsStatus_LoadData
	AS
	BEGIN
		TRUNCATE TABLE [Order Details Status]
		INSERT INTO [Order Details Status]
			SELECT [Status ID], [Status Name]
			FROM [Northwind2007].dbo.[Order Details Status]
	END

	--USE [NorthWindStorageArea]
	GO
	CREATE PROCEDURE [dbo].CheckINfo_LoadData
	AS
	BEGIN
		TRUNCATE TABLE [CheckINfo]
		INSERT INTO [CheckINfo]
			SELECT [CheckNumber], [CheckType], [Status], [AccountNumber], [Amount],[Bank], [Branch], [IBAN], [DueDate], [Note]
			FROM [Northwind2007].dbo.CheckINfo
	END

	--USE [NorthWindStorageArea]
	GO
	CREATE PROCEDURE [dbo].CheckStatus_LoadData
	AS
	BEGIN
		TRUNCATE TABLE [Check Status]
		INSERT INTO [Check Status]
			SELECT [ID], [Status]
			FROM [Northwind2007].dbo.[Check Status]
	END

	--USE [NorthWindStorageArea]
	GO
	CREATE PROCEDURE [dbo].CheckType_LoadData
	AS
	BEGIN
		TRUNCATE TABLE [Check Type]
		INSERT INTO [Check Type]
			SELECT [ID], [Type]
			FROM [Northwind2007].dbo.[Check Type]
	END
	
	--USE [NorthWindStorageArea]
	GO
	CREATE PROCEDURE [dbo].Orders_LoadData (@MinDate Date, @MaxDate Date)
	AS
	BEGIN
		DECLARE @i INT = 0;
		DECLARE @RowNum INT;
		DECLARE @CurrentDate DATE;
		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			SET @RowNum = (SELECT COUNT([Order ID]) FROM [Northwind2007].dbo.Orders 
			WHERE CONVERT(DATE, [Order Date]) = @CurrentDate);
			SET @i = 0;
			WHILE @i < @RowNum
			BEGIN
				INSERT INTO Orders
				SELECT [Order ID],[Employee ID],[Customer ID],[Order Date],
				[Shipped Date],[Shipper ID],[Ship Name],[Ship Address],[Ship City],
				[Ship State/Province],[Ship ZIP/Postal Code],[Ship Country/Region],
				[Shipping Fee],[Taxes], [Payment Type],[Paid Date],[Notes],[Tax Rate],
				[Tax Status],[Status ID],[Check ID]
				FROM [Northwind2007].dbo.Orders 
				WHERE CONVERT(DATE, [Order Date]) = @CurrentDate
				ORDER BY [Order Date]
				OFFSET @i ROWS  
				FETCH NEXT 1 ROWS ONLY;

				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
		END
	END

	--USE [NorthWindStorageArea]
	GO
	CREATE PROCEDURE [dbo].PurchaseOrders_LoadData (@MinDate Date, @MaxDate Date)
	AS
	BEGIN
		DECLARE @i INT = 0;
		DECLARE @RowNum INT;
		DECLARE @CurrentDate DATE;
		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			SET @RowNum = (SELECT COUNT([Purchase Order ID]) FROM [Northwind2007].dbo.[Purchase Orders] 
			WHERE CONVERT(DATE, [Creation Date]) = @CurrentDate);
			SET @i = 0;
			WHILE @i < @RowNum
			BEGIN
				INSERT INTO [Purchase Orders]
				SELECT [Purchase Order ID],[Supplier ID],[Created By],[Approved By],
				[Submitted By],[Creation Date],[Approved Date],[Submitted Date],
				[Expected Date],[Status ID],[Shipping Fee],[Taxes],[Payment Date],
				[Payment Amount],[Payment Method],[Notes], [Check ID]
				FROM [Northwind2007].dbo.[Purchase Orders] 
				WHERE CONVERT(DATE, [Creation Date]) = @CurrentDate
				ORDER BY [Creation Date]
				OFFSET @i ROWS  
				FETCH NEXT 1 ROWS ONLY;

				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
		END
	END

	--USE [NorthWindStorageArea]
	GO
	CREATE PROCEDURE [dbo].PurchaseOrderDetails_LoadData (@MinDate Date, @MaxDate Date)
	AS
	BEGIN
		DECLARE @i INT = 0;
		DECLARE @RowNum INT;

		CREATE TABLE TEMP2(
			[ID] [int], 
			[Purchase Order ID] [int], 
			[Product ID] [int],
			[Quantity] [float],
			[Unit Cost] [money],
			[Date Received] DATETIME2(0),
		)
		DECLARE @CurrentDate DATE;
		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			TRUNCATE TABLE TEMP2
			INSERT INTO TEMP2 
			SELECT POD.[ID], POD.[Purchase Order ID], POD.[Product ID], POD.[Quantity], POD.[Unit Cost], POD.[Date Received]
			FROM
			(SELECT [Purchase Order ID] FROM [Northwind2007].dbo.[Purchase Orders]
			WHERE CONVERT(DATE, [Creation Date]) = @CurrentDate) AS PO 
			INNER JOIN
			(SELECT [ID], [Purchase Order ID], [Product ID], [Quantity], [Unit Cost], [Date Received]
			FROM [Northwind2007].dbo.[Purchase Order Details]) AS POD
			ON PO.[Purchase Order ID] = POD.[Purchase Order ID]

			SET @RowNum = (SELECT COUNT([ID]) FROM TEMP2);
			SET @i = 0;
			WHILE @i < @RowNum
			BEGIN
				INSERT INTO [Purchase Order Details]
				SELECT [ID], [Purchase Order ID], [Product ID], [Quantity], [Unit Cost], [Date Received]
				FROM TEMP2
				ORDER BY [ID]
				OFFSET @i ROWS  
				FETCH NEXT 1 ROWS ONLY;

				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
		END
		DROP TABLE TEMP2
	END

	--USE [NorthWindStorageArea]
	GO
	CREATE PROCEDURE [dbo].OrderDetails_LoadData (@MinDate Date, @MaxDate Date)
	AS
	BEGIN
		DECLARE @i INT = 0;
		DECLARE @RowNum INT;

		CREATE TABLE TEMP3(
			[ID] [int],
			[Order ID] [int],
			[Product ID] [int],
			[Quantity] [float],
			[Unit Price] [money],
			[Discount] [float],
			[Status ID] [int],
			[Date Allocated] DATETIME2(0)
		)
		DECLARE @CurrentDate DATE;
		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			TRUNCATE TABLE TEMP3
			INSERT INTO TEMP3 
			SELECT POD.[ID], POD.[Order ID], POD.[Product ID], POD.[Quantity], POD.[Unit Price], POD.[Discount]
			,POD.[Status ID], POD.[Date Allocated]
			FROM
			(SELECT [Order ID] FROM [Northwind2007].dbo.[Orders]
			WHERE CONVERT(DATE, [Order Date]) = @CurrentDate) AS PO 
			INNER JOIN
			(SELECT [ID], [Order ID], [Product ID], [Quantity], [Unit Price], [Discount], [Status ID], [Date Allocated]
			FROM [Northwind2007].dbo.[Order Details]) AS POD
			ON PO.[Order ID] = POD.[Order ID]
		
			SET @RowNum = (SELECT COUNT([ID]) FROM TEMP3);
			SET @i = 0;
			WHILE @i < @RowNum
			BEGIN
				INSERT INTO [Order Details]
				SELECT [ID], [Order ID], [Product ID], [Quantity], [Unit Price], [Discount], [Status ID], [Date Allocated]
				FROM TEMP3
				ORDER BY [ID]
				OFFSET @i ROWS  
				FETCH NEXT 1 ROWS ONLY;

				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
		END
		DROP TABLE TEMP3
	END
	--USE [NorthWindStorageArea]
	GO
	CREATE PROCEDURE [dbo].EmployeeSalary_LoadData (@MinDate Date, @MaxDate Date)
	AS
	BEGIN
		DECLARE @i INT = 0;
		DECLARE @RowNum INT;
		DECLARE @CurrentDate DATE;
		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			SET @RowNum = (SELECT COUNT(*) FROM [Northwind2007].dbo.[EmployeeSalary] 
			WHERE CONVERT(DATE, [PaymentDate]) = @CurrentDate);
			SET @i = 0;
			WHILE @i < @RowNum
			BEGIN
				INSERT INTO [EmployeeSalary]
				SELECT EmployeeID, BaseSalary, OvertimePaid, PerformanceBonus, IncentiveAllowance, PaymentDate, PaymentMethod, [Check ID]
				FROM [Northwind2007].dbo.[EmployeeSalary] 
				WHERE CONVERT(DATE, [PaymentDate]) = @CurrentDate
				ORDER BY [PaymentDate]
				OFFSET @i ROWS  
				FETCH NEXT 1 ROWS ONLY;

				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
		END
	END
	--USE [NorthWindStorageArea]
	GO
	CREATE PROCEDURE [dbo].Main_SAProcedure 
	AS
	BEGIN
		EXEC Suppliers_LoadData
		EXEC Customers_LoadData
		EXEC Products_LoadData
		EXEC Shippers_LoadData
		EXEC Employees_LoadData
		EXEC OrdersStatus_LoadData
		EXEC OrderDetailsStatus_LoadData
		EXEC PurchaseOrderStatus_LoadData
		EXEC OrdersTaxStatus_LoadData
		EXEC CheckINfo_LoadData
		EXEC CheckStatus_LoadData
		EXEC CheckType_LoadData

		DECLARE @MaxDate DATE
		DECLARE @MinDate DATE

		SET @MaxDate = (SELECT MAX([Creation Date]) FROM [Northwind2007].[dbo].[Purchase Orders])
		SET @MinDate = (SELECT MAX([Creation Date]) FROM [NorthWindStorageArea].[dbo].[Purchase Orders])
		IF @MinDate IS NULL
			SET @MinDate = DATEADD(DAY, -1, (SELECT MIN([Creation Date]) FROM [Northwind2007].[dbo].[Purchase Orders]))
		
		EXEC PurchaseOrders_LoadData @MinDate, @MaxDate
		EXEC PurchaseOrderDetails_LoadData @MinDate, @MaxDate
		
		SET @MaxDate = (SELECT MAX([Order Date]) FROM [Northwind2007].[dbo].[Orders])
		SET @MinDate = (SELECT MAX([Order Date]) FROM [NorthWindStorageArea].[dbo].[Orders])
		IF @MinDate IS NULL
			SET @MinDate = DATEADD(DAY, -1, (SELECT MIN([Order Date]) FROM [Northwind2007].[dbo].[Orders]))

		EXEC Orders_LoadData @MinDate, @MaxDate
		EXEC OrderDetails_LoadData @MinDate, @MaxDate
		
		SET @MaxDate = (SELECT MAX([PaymentDate]) FROM [Northwind2007].[dbo].[EmployeeSalary])
		SET @MinDate = (SELECT MAX([PaymentDate]) FROM [NorthWindStorageArea].[dbo].[EmployeeSalary])
		IF @MinDate IS NULL
			SET @MinDate = DATEADD(DAY, -1, (SELECT MIN([PaymentDate]) FROM [Northwind2007].[dbo].[EmployeeSalary]))

		EXEC EmployeeSalary_LoadData @MinDate, @MaxDate

	END

  -- EXEC MAIN;

   
