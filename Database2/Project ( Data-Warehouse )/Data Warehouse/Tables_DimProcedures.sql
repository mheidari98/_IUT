	USE NorthWindDataWarehouse
	GO

		/****** 
		
				Team Members:  SaraBaradaran, MahdiHeidari, AminEmamJomeh
				Script Date: January 1, 2021
		
		******/

		
	---###   Dimentions   ###---
	SET ANSI_NULLS ON
	GO

	SET QUOTED_IDENTIFIER ON
	GO

	CREATE TABLE [dbo].[SupplierDim](
	[ID] [int]  NOT NULL PRIMARY KEY,
	[Company] [nvarchar](60) NULL,
	[Last Name] [nvarchar](60) NULL,			--SCD1
	[First Name] [nvarchar](60) NULL,			--SCD1
	[E-mail Address] [nvarchar](60) NULL,		--SCD1
	[Job Title] [nvarchar](60) NULL,			--SCD1			
	[Business Phone] [nvarchar](35) NULL,		--SCD1
	[Home Phone] [nvarchar](35) NULL,			--SCD1
	[Mobile Phone] [nvarchar](35) NULL,			--SCD1
	[Fax Number] [nvarchar](35) NULL,			--SCD1
	[Address] [nvarchar](max) NULL,				--SCD1
	[City] [nvarchar](60) NULL,					--SCD1
	[State/Province] [nvarchar](60) NULL,		--SCD1
	[ZIP/Postal Code] [nvarchar](25) NULL,		--SCD1
	[Country/Region] [nvarchar](60) NULL,		--SCD1
	[Web Page] [nvarchar](max) NULL,			--SCD1
	[CreditCard Number] [nvarchar] (20) NULL,	--SCD1
	[Notes] [nvarchar](max) NULL,				--SCD1

	)		
	GO
	CREATE TABLE [dbo].[ProductDim](
	[ProductKey] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[ID] [int] NOT NULL,
	[Product Code] [nvarchar](35) NULL,
	[Product Name] [nvarchar](60) NULL,
	[Description] [nvarchar](max) NULL,			--SCD1
	[Standard Cost] [money] NULL,				--SCD2
	[List Price] [money] NULL,					--SCD2
	[Reorder Level] [smallint] NULL,			--SCD1
	[Target Level] [int] NULL,					--SCD1
	[Quantity Per Unit] [nvarchar](60) NULL,	--SCD1	
	[Minimum Reorder Quantity] [smallint] NULL,	--SCD1
	[Category] [nvarchar](60) NULL,	
	
	[Start Date] [DATETIME],
	[End Date] [DATETIME],
	[Current Flag] [CHAR](1),
	[Cost Or Price Flag] [CHAR](2),				--if flag = 01 then cost has been changed
												--if flag = 10 then price has been changed
												--if flag = 11 then both of them have been changed
	[Last Discontinued] [nvarchar](10),			--SCD3
	[EffectiveDate] [DATETIME],
	[Current Discontinued] [nvarchar](10)

	)
	GO
	CREATE TABLE [dbo].[ShipperDim](
	[ID] [int] NOT NULL PRIMARY KEY,
	[Company] [nvarchar](60) NULL,
	[Last Name] [nvarchar](60) NULL,			--SCD1
	[First Name] [nvarchar](60) NULL,			--SCD1
	[E-mail Address] [nvarchar](60) NULL,		--SCD1
	[Job Title] [nvarchar](50) NULL,			--SCD1		
	[Business Phone] [nvarchar](35) NULL,		--SCD1
	[Home Phone] [nvarchar](35) NULL,			--SCD1
	[Mobile Phone] [nvarchar](35) NULL,			--SCD1
	[Fax Number] [nvarchar](35) NULL,			--SCD1
	[Address] [nvarchar](max) NULL,				--SCD1
	[City] [nvarchar](50) NULL,					--SCD1
	[State/Province] [nvarchar](60) NULL,		--SCD1
	[ZIP/Postal Code] [nvarchar](25) NULL,		--SCD1
	[Country/Region] [nvarchar](60) NULL,		--SCD1
	[Web Page] [nvarchar](max) NULL,			--SCD1
	[CreditCard Number] [nvarchar] (20) NULL,	--SCD1
	[Notes] [nvarchar](max) NULL,				--SCD1

	)	
	GO
	CREATE TABLE [dbo].[CustomerDim](
	[ID] [int] NOT NULL PRIMARY KEY,
	[Company] [nvarchar](60) NULL,
	[Last Name] [nvarchar](60) NULL,			--SCD1
	[First Name] [nvarchar](60) NULL,			--SCD1
	[E-mail Address] [nvarchar](60) NULL,		--SCD1
	[Job Title] [nvarchar](60) NULL,			--SCD1
	[Business Phone] [nvarchar](35) NULL,		--SCD1
	[Home Phone] [nvarchar](35) NULL,			--SCD1
	[Mobile Phone] [nvarchar](35) NULL,			--SCD1
	[Fax Number] [nvarchar](35) NULL,			--SCD1
	[Address] [nvarchar](max) NULL,				--SCD1
	[City] [nvarchar](60) NULL,					--SCD1
	[State/Province] [nvarchar](60) NULL,		--SCD1
	[ZIP/Postal Code] [nvarchar](25) NULL,		--SCD1
	[Country/Region] [nvarchar](60) NULL,		--SCD1
	[Web Page] [nvarchar](max) NULL,			--SCD1
	[Notes] [nvarchar](max) NULL,				--SCD1

	)
	GO
	CREATE TABLE [dbo].[EmployeeDim](
	[EmployeeKey] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[ID] [int] NOT NULL,
	[Last Name] [nvarchar](60) NULL,
	[First Name] [nvarchar](60) NULL,			
	[E-mail Address] [nvarchar](60) NULL,		--SCD1
	[Business Phone] [nvarchar](35) NULL,		--SCD1
	[Home Phone] [nvarchar](35) NULL,			--SCD1
	[Mobile Phone] [nvarchar](35) NULL,			--SCD1
	[Fax Number] [nvarchar](35) NULL,			--SCD1
	[Address] [nvarchar](max) NULL,				--SCD1
	[City] [nvarchar](60) NULL,					--SCD1
	[State/Province] [nvarchar](60) NULL,		--SCD1
	[ZIP/Postal Code] [nvarchar](25) NULL,		--SCD1
	[Country/Region] [nvarchar](60) NULL,		--SCD1
	[WebPage] [nvarchar](max) NULL,				--SCD1
	[CreditCard Number] [nvarchar] (20) NULL,	--SCD1
	[Hire Date] [Date] NULL,
	[Birth Date] [Date] NULL,
	[Gender] [nvarchar](8) NULL,
	[Marital Status] [nvarchar](8) NULL,		--SCD1
	[National Code] [nvarchar](12) NULL,
	[Annual Leave Hours] [tinyint] NULL,
	[Annual Base Salary] [money] NULL,			--SCD2
	[Notes] [nvarchar](max) NULL,				--SCD1

	[Start Date] [DATETIME],
	[End Date] [DATETIME],
	[Current Flag] [CHAR](1),

	[Last Job Title] [nvarchar](60),			--SCD3
	[Current Job Title] [nvarchar](60),
	[EffectiveDate] [DATETIME],

	)
	GO
	CREATE TABLE [dbo].[PurchaseOrderStatusDim](
	[StatusID] [int] NOT NULL PRIMARY KEY,
	[StatusName] [nvarchar](60) NULL,)
	GO
	CREATE TABLE [dbo].[OrderStatusDim](
	[StatusID] [tinyint] NOT NULL PRIMARY KEY,
	[StatusName] [nvarchar](60) NULL,)
	GO
	CREATE TABLE [dbo].[OrderTaxStatusDim](
	[StatusID] [tinyint] NOT NULL PRIMARY KEY,
	[StatusName] [nvarchar](60) NULL,)
	GO
	CREATE TABLE [dbo].[OrderDetailsStatusDim](
	[StatusID] [int] NOT NULL PRIMARY KEY,
	[StatusName] [nvarchar](60) NULL,)
	GO
	CREATE TABLE [dbo].[PaymentMethodDim](
	[ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Description] [nvarchar](50) NULL,)
	GO
	CREATE TABLE [dbo].[DateDim](
	[TimeKey] [int] NOT NULL PRIMARY KEY,
	[FullDateAlternateKey] [date] NULL,
	[PersianFullDateAlternateKey] [nvarchar](15) NULL,
	[DayNumberOfWeek] [int] NULL,
	[PersianDayNumberOfWeek] [int] NULL,
	[EnglishDayNameOfWeek] [nvarchar](15) NULL,
	[PersianDayNameOfWeek] [nvarchar](15) NULL,
	[DayNumberOfMonth] [int] NULL,
	[PersianDayNumberOfMonth] [int] NULL,
	[DayNumberOfYear] [int] NULL,
	[PersianDayNumberOfYear] [int] NULL,
	[WeekNumberOfYear] [int] NULL,
	[PersianWeekNumberOfYear] [int] NULL,
	[EnglishMonthName] [nvarchar](20) NULL,
	[PersianMonthName] [nvarchar](20) NULL,
	[MonthNumberOfYear] [nvarchar](20) NULL,
	[PersianMonthNumberOfYear] [int] NULL,
	[CalendarQuarter] [int] NULL,
	[PersianCalendarQuarter] [int] NULL,
	[CalendarYear] [int] NULL,
	[PersianCalendarYear] [int] NULL,
	[CalendarSemester] [int] NULL,
	[PersianCalendarSemester] [int] NULL,
	)
	GO
	CREATE TABLE [dbo].[CheckInfoDim](
	[ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CheckNumber] [nvarchar](20) NULL,
	[CheckTypeDesc] [nvarchar](20) NULL,
	[CheckType] [int] NULL,
	[AccountNumber] [nvarchar](20) NULL,
	[Amount] [money] NULL,
	[Bank] [nvarchar](60) NULL,
	[Branch] [nvarchar](30) NULL,
	[IBAN] [nvarchar](20) NULL,
	[DueDate] [date] NULL,
	[Note] [nvarchar](100) NULL,			--SCD1
	[StatusDesc] [nvarchar](60) NULL,		--SCD1
	[StatusID] [int] NULL					--SCD1
	)
	GO
	CREATE TABLE [dbo].[LocationDim](
	[ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Address] [nvarchar](max) NULL,
	[City] [nvarchar](60) NULL,
	[State/Province] [nvarchar](60) NULL,
	[Country/Region] [nvarchar](60) NULL,
	[ZIP/Postal Code] [nvarchar](50) NULL,
	)

--####Purchase Mart
	GO
	CREATE TABLE [dbo].[PurchaseOrdersTransactionalFact](
	[PurchaseOrderID] [int] NOT NULL,
	[SupplierKey] [int] NOT NULL,
	[CreatorKey] [int] NOT NULL,
	[ApproverKey] [int] NOT NULL,
	[SubmitterKey] [int] NOT NULL,
	[CreatorNaturalKey] [int] NOT NULL,
	[ApproverNaturalKey] [int] NOT NULL,
	[SubmitterNaturalKey] [int] NOT NULL,
	[CreationDateKey] [int] NOT NULL,
	[ApprovedDateKey] [int] NOT NULL,
	[SubmittedDateKey] [int] NOT NULL,
	[ExpectedDateKey] [int] NOT NULL,
	[PaymentDateKey] [int] NOT NULL,
	[PaymentMethodKey] [int] NOT NULL,
	[PurchaseStatusKey] [int] NOT NULL,
  	[CheckKey] [int] NOT NULL,
	
	[ShippingFee] [money] NULL,
	[Taxes] [money] NULL,
	[PaymentAmount] [money] NULL,
	[Notes] [nvarchar](max) NULL,
	)
	GO
	CREATE TABLE dbo.[PurchaseProductTransactionalFact] (
	[ProductKey] [int] NOT NULL,
	[ProductNaturalKey] [int] NOT NULL,
	[SupplierKey] [int] NOT NULL, 
	[CreatorKey] [int] NOT NULL,
	[ApproverKey] [int] NOT NULL,
	[SubmitterKey] [int] NOT NULL,
	[CreatorNaturalKey] [int] NOT NULL,
	[ApproverNaturalKey] [int] NOT NULL,
	[SubmitterNaturalKey] [int] NOT NULL,
	[CreationDateKey] [int] NOT NULL,
	[ApprovedDateKey] [int] NOT NULL,
	[SubmittedDateKey] [int] NOT NULL,
	[ExpectedDateKey] [int] NOT NULL,
	[DateReceivedKey] [int] NOT NULL,
	[PaymentDateKey] [int] NOT NULL,
	[PaymentMethodKey] [int] NOT NULL,

	[Quantity] [float] NULL,
	)
	GO
    CREATE TABLE [dbo].[PurchaseOrderAccFact](
	[SupplierKey] [int] NOT NULL,
	[PaymentMethodKey] [int] NOT NULL,

	[TotalShippingFee] [money] NULL,
	[TotalTaxes] [money] NULL,
	[TotalPaymentAmount] [money] NULL,
	[TotalCreatedNumbers] [bigint] NULL,
	[TotalApprovedNumbers] [bigint] NULL,
	[TotalSubmittedNumbers] [bigint] NULL,
	[TotalExpectedNumbers] [bigint] NULL,
	[TotalPaidNumbers] [bigint] NULL,
	[FirstCreatedDate] [Date] NULL,
	[LastCreatedDate] [Date] NULL,
	)
	GO
    CREATE TABLE [dbo].[Employe'sPurchaseOrderAccFact]( 
	[EmployeeKey] [int] NOT NULL,
	[EmployeeNaturalKey] [int] NOT NULL,

	[TotalCreatedNumbers] [bigint] NULL,
	[TotalApprovedNumbers] [bigint] NULL,
	[TotalSubmittedNumbers] [bigint] NULL,
	[FirstCreatedDate] [Date] NULL,
	[LastCreatedDate] [Date] NULL,
	[FirstApprovedDate] [Date] NULL,
	[LastApprovedDate] [Date] NULL,
	[FirstSubmittedDate] [Date] NULL,
	[LastSubmittedDate] [Date] NULL,
	)
	GO
    CREATE TABLE [dbo].[PurchaseOrdersDailyFact](
	[SupplierKey] [int] NOT NULL,
	[PaymentMethodKey] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	
	[TotalShippingFee] [money] NULL,
	[TotalTaxes] [money] NULL,
	[TotalPaymentAmount] [money] NULL,
	[TotalCreatedNumbers] [bigint] NULL,
	[TotalApprovedNumbers] [bigint] NULL,
	[TotalSubmittedNumbers] [bigint] NULL,
	[TotalExpectedNumbers] [bigint] NULL,
	[TotalPaidNumbers] [bigint] NULL,
	)
	GO
    CREATE TABLE [dbo].[Employe'sPurchaseOrderDailyFact]( 
	[EmployeeKey] [int] NOT NULL,
	[EmployeeNaturalKey] [int] NOT NULL,
	[DateKey] [int] NOT NULL,

	[TotalCreatedNumbers] [bigint] NULL,
	[TotalApprovedNumbers] [bigint] NULL,
	[TotalSubmittedNumbers] [bigint] NULL,
	)
	GO
	CREATE TABLE dbo.[PurchaseProductAccFact] (
	[ProductKey] [int] NOT NULL,
	[ProductNaturalKey] [int] NOT NULL,
	[SupplierKey] [int] NOT NULL,

	[TotalQuantity] [float] NULL,
	[MinQuantity] [float] NULL,
	[MaxQuantity] [float] NULL,
	[TotalCost] [float] NULL,
	[FirstPurchaseDate] [Date] NULL,
	[LastPurchaseDate] [Date] NULL,
	)
	GO
	CREATE TABLE dbo.[PurchaseProductDailyFact] (
	[ProductKey] [int] NOT NULL,
	[ProductNaturalKey] [int] NOT NULL,
	[SupplierKey] [int] NOT NULL,
	[DateKey] [int] NOT NULL,

	[TotalQuantity] [float] NULL,
	[MinQuantity] [float] NULL,
	[MaxQuantity] [float] NULL,
	[TotalCost] [float] NULL,
	)
	
--#### Sales Mart
	GO
	CREATE TABLE [dbo].[SalesOrdersTransactionalFact](
	[OrderID] [int] NOT NULL,
	[EmployeeKey] [int] NOT NULL,
	[EmployeeNaturalKey] [int] NOT NULL,
	[CustomerKey] [int] NOT NULL,
	[ShipperKey] [int] NOT NULL,
	[OrderDateKey] [int] NOT NULL,
	[ShippedDateKey] [int] NOT NULL,
	[PaidDateKey] [int] NOT NULL,
	[PaymentMethodKey] [int] NOT NULL,
	[OrderTaxStatusKey] [smallint] NOT NULL,
	[OrderStatusKey] [smallint] NOT NULL,
  	[CheckKey] [int] NOT NULL,
	[LocationKey] [int] NOT NULL,

	[PaymentAmount] [money] NULL,
	[ShippingFee] [money] NULL,
	[Taxes] [money] NULL,
	[TaxRate] [float] NULL,
	[Notes] [nvarchar](max) NULL,
	)
	GO
	CREATE TABLE [dbo].[SalesProductTransactionalFact](
	[ProductKey] [int] NOT NULL,
	[ProductNaturalKey] [int] NOT NULL,
	[EmployeeKey] [int] NOT NULL,
	[EmployeeNaturalKey] [int] NOT NULL,
	[CustomerKey] [int] NOT NULL,
	[ShipperKey] [int] NOT NULL,
	[OrderDateKey] [int] NOT NULL,
	[ShippedDateKey] [int] NOT NULL,
	[DateAllocatedKey] [int] NOT NULL,
	[PaidDateKey] [int] NOT NULL,
	[OrderDetailStatusKey] [int] NOT NULL,
	[PaymentMethodKey] [int] NOT NULL,
	[LocationKey] [int] NOT NULL,

	[Quantity] [float] NULL,
	[Discount] [float] NULL,
	)
	GO
	CREATE TABLE [dbo].[SalesOrderAccFact](
	[CustomerKey] [int] NOT NULL,

	[TotalShippingFee] [money] NULL,
	[TotalTaxes] [money] NULL,
	[AverageTaxRate] [float] NULL,
	[TotalOrderNumbers] [bigint] NULL,
	[TotalShippedNumbers] [bigint] NULL,
	[TotalPaidNumbers] [bigint] NULL,
	[TotalPaymentAmount] [money] NULL,
	[FirstOrderDate] [Date] NULL,
	[LastOrderDate] [Date] NULL,
	)
	GO
	CREATE TABLE [dbo].[SalesOrdersDailyFact](
	[CustomerKey] [int] NOT NULL,
	[DateKey] [int] NOT NULL,

	[TotalShippingFee] [money] NULL,
	[TotalTaxes] [money] NULL,
	[AverageTaxRate] [float] NULL,
	[TotalOrderNumbers] [bigint] NULL,
	[TotalShippedNumbers] [bigint] NULL,
	[TotalPaidNumbers] [bigint] NULL,
	[TotalPaymentAmount] [money] NULL,
	)
	GO
	CREATE TABLE [dbo].[SalesProductsAccFact](
	[ProductKey] [int] NOT NULL,
	[ProductNaturalKey] [int] NOT NULL,
	[EmployeeKey] [int] NOT NULL,
	[EmployeeNaturalKey] [int] NOT NULL,
	
	[TotalSaleQuantity] [float] NULL,
	[MaxSaleQuantity] [float] NULL,
	[MinSaleQuantity] [float] NULL,
	[MinDiscountRate] [float] NULL,
	[MaxDiscountRate] [float] NULL,
	[TotalPrice] [money] NULL,
	[FirstSaleDate] [Date] NULL,
	[LastSaleDate] [Date] NULL,
	)
	GO
	CREATE TABLE [dbo].[SalesProductsDailyFact](
	[ProductKey] [int] NOT NULL,
	[ProductNaturalKey] [int] NOT NULL,
	[EmployeeKey] [int] NOT NULL,
	[EmployeeNaturalKey] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	
	[TotalSaleQuantity] [float] NULL,
	[MaxSaleQuantity] [float] NULL,
	[MinSaleQuantity] [float] NULL,
	[MinDiscountRate] [float] NULL,
	[MaxDiscountRate] [float] NULL,
	[TotalPrice] [money] NULL,
	)

  --#### Salary Mart
	GO
    CREATE TABLE [dbo].[EmployeeSalaryTransactionalFact](
	[PaymentDateKey] [int] NOT NULL,
	[PaymentMethodKey] [int] NOT NULL,
	[EmployeeKey] [int] NOT NULL,
	[EmployeeNaturalKey] [int] NOT NULL,
	[CheckKey] [int] NOT NULL,

	[BaseSalary] [money] NULL,
	[OvertimePaid] [money] NULL,
	[PerformanceBonus] [money] NULL,
	[IncentiveAllowance] [money] NULL,
	)
	GO
    CREATE TABLE [dbo].[EmployeeSalaryAccFact](
	[PaymentMethodKey] [int] NOT NULL,
	[EmployeeKey] [int] NOT NULL,
	[EmployeeNaturalKey] [int] NOT NULL,

	[TotalBaseSalary] [money] NULL,
	[TotalOvertimePaid] [money] NULL,
	[TotalPerformanceBonus] [money] NULL,
	[TotalIncentiveAllowance] [money] NULL,
    [MinOverTimePaid] [money] NULL,
    [MaxOverTimePaid] [money] NULL,
    [MinPerformanceBonus] [money] NULL,
    [MaxPerformanceBonus] [money] NULL,
	)
	GO
	CREATE TABLE [dbo].[EmployeeSalaryYearyFact](
  	[PaymentDateKey] [int] NOT NULL,
	[PaymentMethodKey] [int] NOT NULL,
	[EmployeeKey] [int] NOT NULL,
	[EmployeeNaturalKey] [int] NOT NULL,

	[TotalBaseSalaryPaid] [money] NULL,
	[TotalOvertimePaid] [money] NULL,
	[TotalPerformanceBonusPaid] [money] NULL,
	[TotalIncentiveAllowancePaid] [money] NULL,
	)

--#### PROCEDURE

	USE NorthWindDataWarehouse
	GO
	CREATE PROCEDURE dbo.LocationDim_FirstLoad
	AS
	BEGIN
		TRUNCATE TABLE NorthWindDataWarehouse.dbo.LocationDim
		INSERT INTO NorthWindDataWarehouse.dbo.LocationDim
			SELECT [Ship Address],[Ship City],[Ship State/Province],
			[Ship Country/Region],[Ship ZIP/Postal Code]
			FROM NorthWindStorageArea.dbo.Orders
			UNION
			SELECT [Address],[City],[State/Province],
			[Country/Region],[ZIP/Postal Code]
			FROM NorthWindStorageArea.dbo.Customers		
	END
	GO
	CREATE PROCEDURE dbo.SupplierDim_FirstLoad
	AS
	BEGIN
		TRUNCATE TABLE NorthWindDataWarehouse.dbo.SupplierDim
		INSERT INTO NorthWindDataWarehouse.dbo.SupplierDim
			SELECT [ID],[Company],[Last Name],[First Name],[E-mail Address],
			[Job Title],[Business Phone],[Home Phone],[Mobile Phone],[Fax Number],
			[Address],[City],[State/Province],[ZIP/Postal Code],[Country/Region],
			[Web Page],[CreditCard Number],[Notes]
			FROM NorthWindStorageArea.dbo.Suppliers
	END
	GO
	CREATE PROCEDURE dbo.ProductDim_FirstLoad
	AS
	BEGIN
		TRUNCATE TABLE NorthWindDataWarehouse.dbo.ProductDim
		INSERT INTO NorthWindDataWarehouse.dbo.ProductDim
			SELECT [ID],[Product Code],[Product Name],[Description],[Standard Cost],
			[List Price],[Reorder Level],[Target Level],[Quantity Per Unit],
			[Minimum Reorder Quantity],[Category],
			CURRENT_TIMESTAMP,NULL,'1','00',NULL,NULL,[Discontinued]
			FROM NorthWindStorageArea.dbo.Products 
	END
	GO
	CREATE PROCEDURE dbo.ShipperDim_FirstLoad
	AS
	BEGIN
		TRUNCATE TABLE NorthWindDataWarehouse.dbo.ShipperDim
		INSERT INTO NorthWindDataWarehouse.dbo.ShipperDim
			SELECT [ID],[Company],[Last Name],[First Name],[E-mail Address],
			[Job Title],[Business Phone],[Home Phone],[Mobile Phone],[Fax Number],
			[Address],[City],[State/Province],[ZIP/Postal Code],[Country/Region],
			[Web Page],[CreditCard Number],[Notes]
			FROM NorthWindStorageArea.dbo.Shippers
	END
	GO
	CREATE PROCEDURE dbo.CustomerDim_FirstLoad
	AS
	BEGIN
		TRUNCATE TABLE NorthWindDataWarehouse.dbo.CustomerDim
		INSERT INTO NorthWindDataWarehouse.dbo.CustomerDim
			SELECT [ID],[Company],[Last Name],[First Name],[E-mail Address],
			[Job Title],[Business Phone],[Home Phone],[Mobile Phone],[Fax Number],
			[Address],[City],[State/Province],[ZIP/Postal Code],[Country/Region],
			[Web Page],[Notes]
			FROM NorthWindStorageArea.dbo.Customers
	END
	GO
	CREATE PROCEDURE dbo.EmployeeDim_FirstLoad
	AS
	BEGIN
		TRUNCATE TABLE NorthWindDataWarehouse.dbo.EmployeeDim
		INSERT INTO NorthWindDataWarehouse.dbo.EmployeeDim
			SELECT [ID],[Last Name],[First Name],[E-mail Address],
			[Business Phone],[Home Phone],[Mobile Phone],[Fax Number],
			[Address],[City],[State/Province],[ZIP/Postal Code],[Country/Region],
			[Web Page],[CreditCard Number],[Hire Date],[Birth Date],[Gender],
			[Marital Status],[National Code],[Annual Leave Hours],[Annual Base Salary],
			[Notes],CURRENT_TIMESTAMP,NULL,'1',NULL,[Job Title],NULL
			FROM NorthWindStorageArea.dbo.Employees
	END
	GO
	CREATE PROCEDURE dbo.PurchaseOrderStatusDim_FirstLoad
	AS
	BEGIN		
		TRUNCATE TABLE NorthWindDataWarehouse.dbo.[PurchaseOrderStatusDim]
		INSERT INTO NorthWindDataWarehouse.dbo.[PurchaseOrderStatusDim]
			SELECT [Status ID], [Status]
			FROM NorthWindStorageArea.dbo.[Purchase Order Status]
	END
	GO
	CREATE PROCEDURE dbo.OrderTaxStatusDim_FirstLoad
	AS
	BEGIN
		TRUNCATE TABLE NorthWindDataWarehouse.dbo.[OrderTaxStatusDim]
		INSERT INTO NorthWindDataWarehouse.dbo.[OrderTaxStatusDim]
			SELECT [ID], [Tax Status Name]
			FROM NorthWindStorageArea.dbo.[Orders Tax Status]
	END
	GO
	CREATE PROCEDURE dbo.OrderStatusDim_FirstLoad
	AS
	BEGIN
		TRUNCATE TABLE NorthWindDataWarehouse.dbo.OrderStatusDim
		INSERT INTO NorthWindDataWarehouse.dbo.OrderStatusDim
			SELECT [Status ID], [Status Name]
			FROM NorthWindStorageArea.dbo.[Orders Status]
	END
	GO
	CREATE PROCEDURE dbo.OrderDetailsStatusDim_FirstLoad
	AS
	BEGIN
		TRUNCATE TABLE NorthWindDataWarehouse.dbo.OrderDetailsStatusDim
		INSERT INTO NorthWindDataWarehouse.dbo.OrderDetailsStatusDim
			SELECT [Status ID], [Status Name]
			FROM NorthWindStorageArea.dbo.[Order Details Status]
	END
	GO
	CREATE PROCEDURE dbo.PaymentMethodDim_FirstLoad
	AS
	BEGIN
		TRUNCATE TABLE NorthWindDataWarehouse.dbo.[PaymentMethodDim]
		INSERT INTO NorthWindDataWarehouse.dbo.[PaymentMethodDim]
			SELECT DISTINCT [Payment Method] 
			FROM
			(
				SELECT DISTINCT [Payment Method] 
				FROM NorthWindStorageArea.dbo.[Purchase Orders]
				UNION
				SELECT DISTINCT [Payment Type]
				FROM NorthWindStorageArea.dbo.Orders
			) AS TEMP
			WHERE [Payment Method] IS NOT NULL
	END
	GO
	CREATE PROCEDURE dbo.CheckInfoDim_FirstLoad
	AS
	BEGIN
		TRUNCATE TABLE NorthWindDataWarehouse.dbo.CheckInfoDim
		INSERT INTO NorthWindDataWarehouse.dbo.CheckInfoDim
			SELECT CI.[CheckNumber], CT.[Type], CT.[ID], CI.[AccountNumber],CI.[Amount],
			CI.[Bank], CI.[Branch], CI.[IBAN], CI.[DueDate], CI.[Note], CS.[Status], CS.[ID]
			FROM NorthWindStorageArea.dbo.CheckINfo AS CI 
			INNER JOIN NorthWindStorageArea.dbo.[Check Type] AS CT ON CT.[ID] = CI.[CheckType]
			INNER JOIN NorthWindStorageArea.dbo.[Check Status] AS CS ON CS.ID = CI.[Status]
	END
	GO
	CREATE PROCEDURE dbo.DateDim_FirstLoad
	AS
	BEGIN
		TRUNCATE TABLE NorthWindDataWarehouse.dbo.[DateDim]
		INSERT INTO NorthWindDataWarehouse.dbo.[DateDim]
		SELECT CONVERT(int, F1),CONVERT(date, F2),F3,CONVERT(int, F4),CONVERT(int, F5),
		F6,F7,CONVERT(int, F8),CONVERT(int, F9),CONVERT(int, F10),CONVERT(int, F11),CONVERT(int, F12),CONVERT(int, F13),
		F14,F15,F16,CONVERT(int, F17),CONVERT(int, F18),CONVERT(int, F19),CONVERT(int, F20),CONVERT(int, F21),CONVERT(int, F22),CONVERT(int, F23) --CONVERT(date, F2)
		FROM OPENROWSET
		(
			'Microsoft.ACE.OLEDB.12.0',
			'Excel 12.0; Database=C:\Users\User\Downloads\Telegram Desktop\Date.xlsx; HDR=No; IMEX=1', 
			'SELECT * FROM [Date$] WHERE [Date$].F1 <> "TimeKey"' 
		);
	END

	GO
	CREATE PROCEDURE dbo.Main_DimFirstLoadProcedure
	AS
	BEGIN
			EXEC LocationDim_FirstLoad
			EXEC SupplierDim_FirstLoad
			EXEC EmployeeDim_FirstLoad
			EXEC ShipperDim_FirstLoad
			EXEC ProductDim_FirstLoad
			EXEC CustomerDim_FirstLoad
			EXEC OrderDetailsStatusDim_FirstLoad
			EXEC OrderTaxStatusDim_FirstLoad
			EXEC OrderStatusDim_FirstLoad
			EXEC PurchaseOrderStatusDim_FirstLoad
			EXEC PaymentMethodDim_FirstLoad
			EXEC CheckInfoDim_FirstLoad
			EXEC DateDim_FirstLoad
			
	END
	--EXEC NorthWindDataWarehouse.DBO.Main_DimFirstLoadProcedure;

	----------------------------------------------------------------------------------
	----------------------------------------------------------------------------------
	--USE NorthWindDataWarehouse
	GO
	CREATE PROCEDURE dbo.SupplierDim_GeneralLoad
	AS
	BEGIN
		CREATE TABLE TEMP(
		[ID] [int],
		[Company] [nvarchar](60),
		[Last Name] [nvarchar](60), 
		[First Name] [nvarchar](60), 
		[E-mail Address] [nvarchar](60), 
		[Job Title] [nvarchar](60), 			
		[Business Phone] [nvarchar](35), 
		[Home Phone] [nvarchar](35),
		[Mobile Phone] [nvarchar](35),
		[Fax Number] [nvarchar](35),
		[Address] [nvarchar](max),
		[City] [nvarchar](60),
		[State/Province] [nvarchar](60), 
		[ZIP/Postal Code] [nvarchar](25),
		[Country/Region] [nvarchar](60),
		[Web Page] [nvarchar](max),
		[CreditCard Number] [nvarchar] (20),
		[Notes] [nvarchar](max)
		)

		INSERT INTO TEMP
			SELECT 
			CASE WHEN DW.[ID] IS NOT NULL THEN DW.[ID] ELSE SA.[ID] END,
			CASE WHEN DW.[Company] IS NOT NULL THEN DW.[Company] ELSE SA.[Company] END,
			CASE WHEN SA.[Last Name] IS NOT NULL THEN SA.[Last Name] ELSE DW.[Last Name] END,
			CASE WHEN SA.[First Name] IS NOT NULL THEN SA.[First Name] ELSE DW.[First Name] END,
			CASE WHEN SA.[E-mail Address] IS NOT NULL THEN SA.[E-mail Address] ELSE DW.[E-mail Address] END,
			CASE WHEN SA.[Job Title] IS NOT NULL THEN SA.[Job Title] ELSE DW.[Job Title] END,
			CASE WHEN SA.[Business Phone] IS NOT NULL THEN SA.[Business Phone] ELSE DW.[Business Phone] END,
			CASE WHEN SA.[Home Phone] IS NOT NULL THEN SA.[Home Phone] ELSE DW.[Home Phone] END,
			CASE WHEN SA.[Mobile Phone] IS NOT NULL THEN SA.[Mobile Phone] ELSE DW.[Mobile Phone] END,
			CASE WHEN SA.[Fax Number] IS NOT NULL THEN SA.[Fax Number] ELSE DW.[Fax Number] END,
			CASE WHEN SA.[Address] IS NOT NULL THEN SA.[Address] ELSE DW.[Address] END,
			CASE WHEN SA.[City] IS NOT NULL THEN SA.[City] ELSE DW.[City] END,
			CASE WHEN SA.[State/Province] IS NOT NULL THEN SA.[State/Province] ELSE DW.[State/Province] END,
			CASE WHEN SA.[ZIP/Postal Code] IS NOT NULL THEN SA.[ZIP/Postal Code] ELSE DW.[ZIP/Postal Code] END,
			CASE WHEN SA.[Country/Region] IS NOT NULL THEN SA.[Country/Region] ELSE DW.[Country/Region] END,
			CASE WHEN SA.[Web Page] IS NOT NULL THEN SA.[Web Page] ELSE DW.[Web Page] END,
			CASE WHEN SA.[CreditCard Number] IS NOT NULL THEN SA.[CreditCard Number] ELSE DW.[CreditCard Number] END,
			CASE WHEN SA.[Notes] IS NOT NULL THEN SA.[Notes] ELSE DW.[Notes] END
			FROM 
			NorthWindStorageArea.dbo.Suppliers as SA
			FULL JOIN 
			NorthWindDataWarehouse.dbo.SupplierDim as DW
			ON DW.ID = SA.ID

		TRUNCATE TABLE NorthWindDataWarehouse.dbo.SupplierDim

		INSERT INTO NorthWindDataWarehouse.dbo.SupplierDim
			SELECT [ID],[Company],[Last Name],[First Name],[E-mail Address],[Job Title],
			[Business Phone],[Home Phone],[Mobile Phone],[Fax Number],[Address],[City],
			[State/Province],[ZIP/Postal Code],[Country/Region],[Web Page],[CreditCard Number],[Notes]
			FROM TEMP

		DROP TABLE TEMP
	END
	GO
	CREATE PROCEDURE dbo.ShipperDim_GeneralLoad
	AS
	BEGIN 
		CREATE TABLE TEMP(
		[ID] [int],
		[Company] [nvarchar](60),
		[Last Name] [nvarchar](60), 
		[First Name] [nvarchar](60), 
		[E-mail Address] [nvarchar](60), 
		[Job Title] [nvarchar](60), 			
		[Business Phone] [nvarchar](35), 
		[Home Phone] [nvarchar](35),
		[Mobile Phone] [nvarchar](35),
		[Fax Number] [nvarchar](35),
		[Address] [nvarchar](max),
		[City] [nvarchar](60),
		[State/Province] [nvarchar](60), 
		[ZIP/Postal Code] [nvarchar](25),
		[Country/Region] [nvarchar](60),
		[Web Page] [nvarchar](max),
		[CreditCard Number] [nvarchar] (20),
		[Notes] [nvarchar](max)
		)

		INSERT INTO TEMP
			SELECT 
			CASE WHEN DW.[ID] IS NOT NULL THEN DW.[ID] ELSE SA.[ID] END,
			CASE WHEN DW.[Company] IS NOT NULL THEN DW.[Company] ELSE SA.[Company] END,
			CASE WHEN SA.[Last Name] IS NOT NULL THEN SA.[Last Name] ELSE DW.[Last Name] END,
			CASE WHEN SA.[First Name] IS NOT NULL THEN SA.[First Name] ELSE DW.[First Name] END,
			CASE WHEN SA.[E-mail Address] IS NOT NULL THEN SA.[E-mail Address] ELSE DW.[E-mail Address] END,
			CASE WHEN SA.[Job Title] IS NOT NULL THEN SA.[Job Title] ELSE DW.[Job Title] END,
			CASE WHEN SA.[Business Phone] IS NOT NULL THEN SA.[Business Phone] ELSE DW.[Business Phone] END,
			CASE WHEN SA.[Home Phone] IS NOT NULL THEN SA.[Home Phone] ELSE DW.[Home Phone] END,
			CASE WHEN SA.[Mobile Phone] IS NOT NULL THEN SA.[Mobile Phone] ELSE DW.[Mobile Phone] END,
			CASE WHEN SA.[Fax Number] IS NOT NULL THEN SA.[Fax Number] ELSE DW.[Fax Number] END,
			CASE WHEN SA.[Address] IS NOT NULL THEN SA.[Address] ELSE DW.[Address] END,
			CASE WHEN SA.[City] IS NOT NULL THEN SA.[City] ELSE DW.[City] END,
			CASE WHEN SA.[State/Province] IS NOT NULL THEN SA.[State/Province] ELSE DW.[State/Province] END,
			CASE WHEN SA.[ZIP/Postal Code] IS NOT NULL THEN SA.[ZIP/Postal Code] ELSE DW.[ZIP/Postal Code] END,
			CASE WHEN SA.[Country/Region] IS NOT NULL THEN SA.[Country/Region] ELSE DW.[Country/Region] END,
			CASE WHEN SA.[Web Page] IS NOT NULL THEN SA.[Web Page] ELSE DW.[Web Page] END,
			CASE WHEN SA.[CreditCard Number] IS NOT NULL THEN SA.[CreditCard Number] ELSE DW.[CreditCard Number] END,
			CASE WHEN SA.[Notes] IS NOT NULL THEN SA.[Notes] ELSE DW.[Notes] END
			FROM 
			NorthWindStorageArea.dbo.Shippers as SA
			FULL JOIN 
			NorthWindDataWarehouse.dbo.ShipperDim as DW
			ON DW.ID = SA.ID

		TRUNCATE TABLE NorthWindDataWarehouse.dbo.ShipperDim

		INSERT INTO NorthWindDataWarehouse.dbo.ShipperDim
			SELECT [ID],[Company],[Last Name],[First Name],[E-mail Address],[Job Title],
			[Business Phone],[Home Phone],[Mobile Phone],[Fax Number],[Address],[City],
			[State/Province],[ZIP/Postal Code],[Country/Region],[Web Page],[CreditCard Number],[Notes]
			FROM TEMP

		DROP TABLE TEMP
	END
	GO
	CREATE PROCEDURE dbo.CustomerDim_GeneralLoad
	AS
	BEGIN
	CREATE TABLE TEMP(
		[ID] [int],
		[Company] [nvarchar](60),
		[Last Name] [nvarchar](60), 
		[First Name] [nvarchar](60), 
		[E-mail Address] [nvarchar](60), 
		[Job Title] [nvarchar](60), 			
		[Business Phone] [nvarchar](35), 
		[Home Phone] [nvarchar](35),
		[Mobile Phone] [nvarchar](35),
		[Fax Number] [nvarchar](35),
		[Address] [nvarchar](max),
		[City] [nvarchar](60),
		[State/Province] [nvarchar](60), 
		[ZIP/Postal Code] [nvarchar](25),
		[Country/Region] [nvarchar](60),
		[Web Page] [nvarchar](max),
		[Notes] [nvarchar](max)
		)

		INSERT INTO TEMP
			SELECT 
			CASE WHEN DW.[ID] IS NOT NULL THEN DW.[ID] ELSE SA.[ID] END,
			CASE WHEN DW.[Company] IS NOT NULL THEN DW.[Company] ELSE SA.[Company] END,
			CASE WHEN SA.[Last Name] IS NOT NULL THEN SA.[Last Name] ELSE DW.[Last Name] END,
			CASE WHEN SA.[First Name] IS NOT NULL THEN SA.[First Name] ELSE DW.[First Name] END,
			CASE WHEN SA.[E-mail Address] IS NOT NULL THEN SA.[E-mail Address] ELSE DW.[E-mail Address] END,
			CASE WHEN SA.[Job Title] IS NOT NULL THEN SA.[Job Title] ELSE DW.[Job Title] END,
			CASE WHEN SA.[Business Phone] IS NOT NULL THEN SA.[Business Phone] ELSE DW.[Business Phone] END,
			CASE WHEN SA.[Home Phone] IS NOT NULL THEN SA.[Home Phone] ELSE DW.[Home Phone] END,
			CASE WHEN SA.[Mobile Phone] IS NOT NULL THEN SA.[Mobile Phone] ELSE DW.[Mobile Phone] END,
			CASE WHEN SA.[Fax Number] IS NOT NULL THEN SA.[Fax Number] ELSE DW.[Fax Number] END,
			CASE WHEN SA.[Address] IS NOT NULL THEN SA.[Address] ELSE DW.[Address] END,
			CASE WHEN SA.[City] IS NOT NULL THEN SA.[City] ELSE DW.[City] END,
			CASE WHEN SA.[State/Province] IS NOT NULL THEN SA.[State/Province] ELSE DW.[State/Province] END,
			CASE WHEN SA.[ZIP/Postal Code] IS NOT NULL THEN SA.[ZIP/Postal Code] ELSE DW.[ZIP/Postal Code] END,
			CASE WHEN SA.[Country/Region] IS NOT NULL THEN SA.[Country/Region] ELSE DW.[Country/Region] END,
			CASE WHEN SA.[Web Page] IS NOT NULL THEN SA.[Web Page] ELSE DW.[Web Page] END,
			CASE WHEN SA.[Notes] IS NOT NULL THEN SA.[Notes] ELSE DW.[Notes] END
			FROM 
			NorthWindStorageArea.dbo.Customers as SA
			FULL JOIN 
			NorthWindDataWarehouse.dbo.CustomerDim as DW
			ON DW.ID = SA.ID

		TRUNCATE TABLE NorthWindDataWarehouse.dbo.CustomerDim

		INSERT INTO NorthWindDataWarehouse.dbo.CustomerDim
			SELECT [ID],[Company],[Last Name],[First Name],[E-mail Address],[Job Title],
			[Business Phone],[Home Phone],[Mobile Phone],[Fax Number],[Address],[City],
			[State/Province],[ZIP/Postal Code],[Country/Region],[Web Page],[Notes]
			FROM TEMP

		DROP TABLE TEMP
	END
	GO
	CREATE PROCEDURE CheckInfoDim_GeneralLoad
	AS
	BEGIN
		
		CREATE TABLE TEMPcheck(
			[ID] [int],
			[CheckNumber] [nvarchar](20),
			[CheckTypeDesc] [nvarchar](20) NULL,
			[CheckType] [nvarchar](20),		
			[AccountNumber] [nvarchar](20),
			[Amount] [money],
			[Branch] [nvarchar](20),
			[Bank] [nvarchar](60),
			[IBAN] [nvarchar](20),
			[DueDate] [date],
			[Note] [nvarchar](100),
			[StatusID] [int],
			[StatusDesc] [nvarchar](60),
		)
		
		INSERT INTO TEMPcheck
			SELECT 
			CASE WHEN DW.[ID] IS NOT NULL THEN DW.[ID] END,
			CASE WHEN DW.[CheckNumber] IS NOT NULL THEN DW.[CheckNumber] ELSE SA.[CheckNumber] END,
			CASE WHEN DW.[CheckTypeDesc] IS NOT NULL THEN DW.[CheckTypeDesc] ELSE CT.[Type] END,
			CASE WHEN DW.[CheckType] IS NOT NULL THEN DW.[CheckType] ELSE SA.[CheckType] END,
			CASE WHEN DW.[AccountNumber] IS NOT NULL THEN DW.[AccountNumber] ELSE SA.[AccountNumber] END,
			CASE WHEN DW.[Amount] IS NOT NULL THEN DW.[Amount] ELSE SA.[Amount] END,
			CASE WHEN DW.[Branch] IS NOT NULL THEN DW.[Branch] ELSE SA.[Branch] END,
			CASE WHEN DW.[Bank] IS NOT NULL THEN DW.[Bank] ELSE SA.[Bank] END,
			CASE WHEN DW.[IBAN] IS NOT NULL THEN DW.[IBAN] ELSE SA.[IBAN] END,
			CASE WHEN DW.[DueDate] IS NOT NULL THEN DW.[DueDate] ELSE SA.[DueDate] END,
			CASE WHEN SA.[Note] IS NOT NULL THEN SA.[Note] ELSE DW.[Note] END,
			CASE WHEN SA.[Status] IS NOT NULL THEN SA.[Status] ELSE DW.[StatusID] END,
			CASE WHEN CS.[Status] IS NOT NULL THEN CS.[Status] ELSE DW.[StatusDesc] END
			FROM 
			NorthWindStorageArea.dbo.CheckINfo as SA 
			INNER JOIN 
			NorthWindStorageArea.dbo.[Check Type] AS CT ON CT.[ID] = SA.[CheckType]
			INNER JOIN 
			NorthWindStorageArea.dbo.[Check Status] AS CS ON CS.ID = SA.[Status]
			FULL JOIN 
			NorthWindDataWarehouse.dbo.CheckInfoDim as DW
			ON DW.ID = SA.ID
		
		TRUNCATE TABLE NorthWindDataWarehouse.dbo.CheckInfoDim
		INSERT INTO NorthWindDataWarehouse.dbo.CheckInfoDim
			SELECT 
			[ID],[CheckNumber],[CheckTypeDesc],[CheckType],[AccountNumber],[Amount],[Bank],
			[Branch],[IBAN],[DueDate],[Note],[StatusDesc],[StatusID]
			FROM TEMPcheck
			
		DROP TABLE TEMPcheck
	END
	GO
	CREATE PROCEDURE dbo.EmployeeDim_GeneralLoad
	AS 
	BEGIN
		SET NOCOUNT ON;
		SET XACT_ABORT ON;
		SET ANSI_PADDING ON;
		SET ANSI_WARNINGS ON;
		SET ARITHABORT ON;
		SET CONCAT_NULL_YIELDS_NULL ON;
		SET NUMERIC_ROUNDABORT OFF;

		BEGIN TRY

		DECLARE  @Yesterday DATETIME  = DATEADD(dd,-1,GETDATE())
				,@Today DATETIME      = GETDATE();

			/* Start a new transaction */
			BEGIN TRANSACTION;

			MERGE NorthWindDataWarehouse.dbo.EmployeeDim AS DST   -- SA
			USING NorthWindStorageArea.dbo.Employees AS SRC
			  ON (SRC.ID = DST.ID)

			WHEN NOT MATCHED BY SOURCE  -- deleted from source
			  THEN UPDATE
				SET DST.[End Date] = @Today

			WHEN NOT MATCHED BY TARGET THEN   /*###> SCD 0 <###*/
			  INSERT ([ID], [Last Name], [First Name], [E-mail Address], [Business Phone], [Home Phone], [Mobile Phone], [Fax Number], [Address], [City], [State/Province], [ZIP/Postal Code], [Country/Region], [WebPage], [CreditCard Number], [Hire Date], [Birth Date], [Gender], [Marital Status], [National Code], [Annual Leave Hours], [Annual Base Salary], [Notes], [Start Date], [End Date], [Current Flag], [Last Job Title], [Current Job Title], [EffectiveDate])
			  VALUES (SRC.[ID], SRC.[Last Name], SRC.[First Name], SRC.[E-mail Address], SRC.[Business Phone], SRC.[Home Phone], SRC.[Mobile Phone], SRC.[Fax Number], SRC.[Address], SRC.[City], SRC.[State/Province], SRC.[ZIP/Postal Code], SRC.[Country/Region], SRC.[Web Page], SRC.[CreditCard Number], SRC.[Hire Date], SRC.[Birth Date], SRC.[Gender], SRC.[Marital Status], SRC.[National Code], SRC.[Annual Leave Hours], SRC.[Annual Base Salary], SRC.[Notes], @Today, NULL, '1', NULL, SRC.[Job Title], NULL)

			WHEN MATCHED      /*###> SCD 1 <###*/
			AND (
			   ISNULL(DST.[E-mail Address] ,'') <> ISNULL(SRC.[E-mail Address],'') 
			   OR ISNULL(DST.[Business Phone],'') <> ISNULL(SRC.[Business Phone],'') 
			   OR ISNULL(DST.[Home Phone],'') <> ISNULL(SRC.[Home Phone],'')
			   OR ISNULL(DST.[Mobile Phone],'') <> ISNULL(SRC.[Mobile Phone],'')
			   OR ISNULL(DST.[Fax Number],'') <> ISNULL(SRC.[Fax Number],'')
			   OR ISNULL(DST.[Address],'') <> ISNULL(SRC.[Address],'')
			   OR ISNULL(DST.[City],'') <> ISNULL(SRC.[City],'')
			   OR ISNULL(DST.[State/Province],'') <> ISNULL(SRC.[State/Province],'')
			   OR ISNULL(DST.[ZIP/Postal Code],'') <> ISNULL(SRC.[ZIP/Postal Code],'')
			   OR ISNULL(DST.[Country/Region],'') <> ISNULL(SRC.[Country/Region],'')
			   OR ISNULL(DST.[WebPage],'') <> ISNULL(SRC.[Web Page],'')
			   OR ISNULL(DST.[CreditCard Number],'') <> ISNULL(SRC.[CreditCard Number],'')
			   OR ISNULL(DST.[Marital Status],'') <> ISNULL(SRC.[Marital Status],'')
			   OR ISNULL(DST.[Notes],'') <> ISNULL(SRC.[Notes],'')
			 )
			THEN UPDATE 
			SET 
			  DST.[E-mail Address] = SRC.[E-mail Address]
			 ,DST.[Business Phone] = SRC.[Business Phone]
			 ,DST.[Home Phone] = SRC.[Home Phone]
			 ,DST.[Mobile Phone] = SRC.[Mobile Phone]
			 ,DST.[Fax Number] = SRC.[Fax Number]
			 ,DST.[Address] = SRC.[Address]
			 ,DST.[City] = SRC.[City]
			 ,DST.[State/Province] = SRC.[State/Province]
			 ,DST.[ZIP/Postal Code] = SRC.[ZIP/Postal Code]
			 ,DST.[Country/Region] = SRC.[Country/Region]
			 ,DST.[WebPage] = SRC.[Web Page]
			 ,DST.[CreditCard Number] = SRC.[CreditCard Number]
			 ,DST.[Marital Status] = SRC.[Marital Status]
			 ,DST.[Notes] = SRC.[Notes]  ;

 
			--#### For SCD type 2 ####--
			INSERT INTO NorthWindDataWarehouse.dbo.EmployeeDim ([ID], [Last Name], [First Name], [E-mail Address], [Business Phone], [Home Phone], [Mobile Phone], [Fax Number], [Address], [City], [State/Province], [ZIP/Postal Code], [Country/Region], [WebPage], [CreditCard Number], [Hire Date], [Birth Date], [Gender], [Marital Status], [National Code], [Annual Leave Hours], [Annual Base Salary], [Notes], [Start Date], [End Date], [Current Flag], [Last Job Title], [Current Job Title], [EffectiveDate])
			SELECT [ID], [Last Name], [First Name], [E-mail Address], [Business Phone], [Home Phone], [Mobile Phone], [Fax Number], [Address], [City], [State/Province], [ZIP/Postal Code], [Country/Region], [Web Page], [CreditCard Number], [Hire Date], [Birth Date], [Gender], [Marital Status], [National Code], [Annual Leave Hours], [Annual Base Salary], [Notes], @Today, NULL, '1', [Last Job Title], [Current Job Title], [EffectiveDate]
			FROM
			(
			  MERGE NorthWindDataWarehouse.dbo.EmployeeDim AS DST   -- SA
			  USING NorthWindStorageArea.dbo.Employees AS SRC
			  ON (SRC.ID = DST.ID)

			  WHEN MATCHED 
			  AND DST.[Current Flag] = '1'
			  AND ISNULL(DST.[Annual Base Salary],'') <> ISNULL(SRC.[Annual Base Salary],'') 
			  -- Update statement for a changed dimension record, to flag as no longer active
			  THEN UPDATE 
			  SET DST.[Current Flag] = '0', DST.[End Date] = @Today
			  OUTPUT SRC.[ID], SRC.[Last Name], SRC.[First Name], SRC.[E-mail Address], SRC.[Business Phone], SRC.[Home Phone], SRC.[Mobile Phone], SRC.[Fax Number], SRC.[Address], SRC.[City], SRC.[State/Province], SRC.[ZIP/Postal Code], SRC.[Country/Region], SRC.[Web Page], SRC.[CreditCard Number], SRC.[Hire Date], SRC.[Birth Date], SRC.[Gender], SRC.[Marital Status], SRC.[National Code], SRC.[Annual Leave Hours], SRC.[Annual Base Salary], SRC.[Notes], 
			  inserted.[Last Job Title], inserted.[Current Job Title], inserted.[EffectiveDate],
				  $Action AS MergeAction
			  ) AS MRG
			  WHERE MRG.MergeAction = 'UPDATE';

			--#### For SCD type 3 ####--
			MERGE NorthWindDataWarehouse.dbo.EmployeeDim AS DST   -- SA
			USING NorthWindStorageArea.dbo.Employees AS SRC
			  ON (SRC.ID = DST.ID)
			WHEN MATCHED
			  AND DST.[Current Flag] = '1'
			  AND ISNULL(DST.[Current Job Title],'') <> ISNULL(SRC.[Job Title],'') 
			  THEN UPDATE
				SET DST.[Last Job Title] = DST.[Current Job Title]
				   ,DST.[Current Job Title] = SRC.[Job Title]
				   ,DST.[EffectiveDate] = @Today;

			/* If you have an open transaction, commit it */
			IF @@TRANCOUNT > 0
				COMMIT TRANSACTION;

		END TRY
		BEGIN CATCH

			/* Whoops, there was an error... rollback! */
			IF @@TRANCOUNT > 0
				ROLLBACK TRANSACTION;

		END CATCH;

		SET NOCOUNT OFF;
		RETURN 0;

	END
	GO
	CREATE PROCEDURE dbo.ProductDim_GeneralLoad
	AS 
	BEGIN
		SET NOCOUNT ON;
		SET XACT_ABORT ON;
		SET ANSI_PADDING ON;
		SET ANSI_WARNINGS ON;
		SET ARITHABORT ON;
		SET CONCAT_NULL_YIELDS_NULL ON;
		SET NUMERIC_ROUNDABORT OFF;

		BEGIN TRY

		DECLARE  @Yesterday DATETIME  = DATEADD(dd,-1,GETDATE())
				,@Today DATETIME      = GETDATE();

			/* Start a new transaction */
			BEGIN TRANSACTION;

			MERGE NorthWindDataWarehouse.dbo.ProductDim AS DST   -- SA
			USING NorthWindStorageArea.dbo.Products AS SRC
			  ON (SRC.ID = DST.ID)

			WHEN NOT MATCHED BY SOURCE  -- deleted from source
			  THEN UPDATE
				SET DST.[End Date] = @Today

			WHEN NOT MATCHED BY TARGET THEN   /*###> SCD 0 <###*/
			  INSERT ([ID], [Product Code], [Product Name], [Description], [Standard Cost], [List Price], [Reorder Level], [Target Level], [Quantity Per Unit], [Minimum Reorder Quantity], [Category], [Start Date], [End Date], [Current Flag], [Cost Or Price Flag], [Last Discontinued], [EffectiveDate], [Current Discontinued])
			  VALUES (SRC.ID, SRC.[Product Code], SRC.[Product Name], SRC.[Description], SRC.[Standard Cost], SRC.[List Price], SRC.[Reorder Level], SRC.[Target Level], SRC.[Quantity Per Unit], SRC.[Minimum Reorder Quantity], SRC.[Category], @Today, NULL, '1', '00', NULL, NULL, SRC.[Discontinued])

			WHEN MATCHED      /*###> SCD 1 <###*/
			AND (
			   ISNULL(DST.[Description],'') <> ISNULL(SRC.[Description],'') 
			   OR ISNULL(DST.[Reorder Level],'') <> ISNULL(SRC.[Reorder Level],'') 
			   OR ISNULL(DST.[Target Level],'') <> ISNULL(SRC.[Target Level],'')
			   OR ISNULL(DST.[Quantity Per Unit],'') <> ISNULL(SRC.[Quantity Per Unit],'')
			   OR ISNULL(DST.[Minimum Reorder Quantity],'') <> ISNULL(SRC.[Minimum Reorder Quantity],'')
			 )
			THEN UPDATE 
			SET 
			  DST.[Description] = SRC.[Description] 
			 ,DST.[Reorder Level] = SRC.[Reorder Level] 
			 ,DST.[Target Level] = SRC.[Target Level]
			 ,DST.[Quantity Per Unit] = SRC.[Quantity Per Unit]
			 ,DST.[Minimum Reorder Quantity] = SRC.[Minimum Reorder Quantity]  ;

 
			--#### For SCD type 2 ####--
			INSERT INTO NorthWindDataWarehouse.dbo.ProductDim ([ID], [Product Code], [Product Name], [Description], [Standard Cost], [List Price], [Reorder Level], [Target Level], [Quantity Per Unit], [Minimum Reorder Quantity], [Category], [Start Date], [End Date], [Current Flag], [Cost Or Price Flag], [Last Discontinued], [EffectiveDate], [Current Discontinued])
			SELECT [ID], [Product Code], [Product Name], [Description], [Standard Cost], [List Price], [Reorder Level], [Target Level], [Quantity Per Unit], [Minimum Reorder Quantity], [Category], @Today, NULL, '1', [Cost Or Price Flag], [Last Discontinued], [EffectiveDate], [Current Discontinued]
			FROM
			(
			  MERGE INTO NorthWindDataWarehouse.dbo.ProductDim AS DST
			  USING NorthWindStorageArea.dbo.Products AS SRC
			  ON (SRC.ID = DST.ID)

			  WHEN MATCHED 
			  AND DST.[Current Flag] = '1'
			  AND (
			   ISNULL(DST.[Standard Cost],'') <> ISNULL(SRC.[Standard Cost],'') 
			   OR ISNULL(DST.[List Price],'') <> ISNULL(SRC.[List Price],'') 
			   )
			  -- Update statement for a changed dimension record, to flag as no longer active
			  THEN UPDATE 
			  SET DST.[Current Flag] = '0', DST.[End Date] = @Today
			  OUTPUT SRC.ID, SRC.[Product Code], SRC.[Product Name], SRC.[Description], SRC.[Standard Cost], SRC.[List Price], SRC.[Reorder Level], SRC.[Target Level], SRC.[Quantity Per Unit], SRC.[Minimum Reorder Quantity], SRC.[Category], 
				  CASE WHEN ISNULL(inserted.[Standard Cost],'') <> ISNULL(SRC.[Standard Cost],'') AND ISNULL(inserted.[List Price],'') <> ISNULL(SRC.[List Price],'')  THEN '11'
					WHEN ISNULL(inserted.[Standard Cost],'') <> ISNULL(SRC.[Standard Cost],'') THEN '01'
					WHEN ISNULL(inserted.[List Price],'') <> ISNULL(SRC.[List Price],'')  THEN '10'
					ELSE '00' END AS [Cost Or Price Flag],
				  inserted.[Last Discontinued], inserted.[EffectiveDate], inserted.[Current Discontinued],
				  $Action AS MergeAction
			  ) AS MRG
			  WHERE MRG.MergeAction = 'UPDATE';

			--#### For SCD type 3 ####--
			MERGE NorthWindDataWarehouse.dbo.ProductDim AS DST
			USING NorthWindStorageArea.dbo.Products AS SRC
			  ON (SRC.ID = DST.ID)
			WHEN MATCHED
			  AND DST.[Current Flag] = '1'
			  AND ISNULL(DST.[Current Discontinued],'') <> ISNULL(SRC.[Discontinued],'') 
			  THEN UPDATE
				SET DST.[Last Discontinued] = DST.[Current Discontinued]
				   ,DST.[Current Discontinued] = SRC.[Discontinued]
				   ,DST.[EffectiveDate] = @Today;

			/* If you have an open transaction, commit it */
			IF @@TRANCOUNT > 0
				COMMIT TRANSACTION;

		END TRY
		BEGIN CATCH

			/* Whoops, there was an error... rollback! */
			IF @@TRANCOUNT > 0
				ROLLBACK TRANSACTION;

		END CATCH;

		SET NOCOUNT OFF;
		RETURN 0;
	END
	GO
	CREATE PROCEDURE dbo.PurchaseOrderStatusDim_GeneralLoad
	AS
	BEGIN
		INSERT INTO NorthWindDataWarehouse.dbo.[PurchaseOrderStatusDim]
			SELECT SA.[Status ID], SA.[Status]
			FROM 
			NorthWindStorageArea.dbo.[Purchase Order Status] AS SA
			LEFT JOIN
			NorthWindDataWarehouse.dbo.[PurchaseOrderStatusDim] AS DW
			ON  SA.[Status ID] = DW.[StatusID]
			WHERE DW.[StatusID] IS NULL

	END
	GO
	CREATE PROCEDURE dbo.OrderTaxStatusDim_GeneralLoad
	AS
	BEGIN
		INSERT INTO NorthWindDataWarehouse.dbo.[OrderTaxStatusDim]	
			SELECT SA.[ID], SA.[Tax Status Name]
			FROM 
			NorthWindStorageArea.dbo.[Orders Tax Status] AS SA
			LEFT JOIN
			NorthWindDataWarehouse.dbo.[OrderTaxStatusDim] AS DW
			ON  SA.[ID] = DW.[StatusID]
			WHERE DW.[StatusID] IS NULL
	END
	GO
	CREATE PROCEDURE OrderStatusDim_GeneralLoad
	AS
	BEGIN
		INSERT INTO NorthWindDataWarehouse.dbo.[OrderStatusDim]
			SELECT SA.[Status ID], SA.[Status Name]
			FROM 
			NorthWindStorageArea.dbo.[Orders Status] AS SA
			LEFT JOIN
			NorthWindDataWarehouse.dbo.[OrderStatusDim] AS DW
			ON  SA.[Status ID] = DW.[StatusID]
			WHERE DW.[StatusID] IS NULL
	END
	GO
	CREATE PROCEDURE OrderDetailsStatusDim_GeneralLoad
	AS
	BEGIN
		INSERT INTO NorthWindDataWarehouse.dbo.[OrderDetailsStatusDim]
			SELECT SA.[Status ID], SA.[Status Name]
			FROM 
			NorthWindStorageArea.dbo.[Order Details Status] AS SA
			LEFT JOIN
			NorthWindDataWarehouse.dbo.[OrderDetailsStatusDim] AS DW
			ON  SA.[Status ID] = DW.[StatusID]
			WHERE DW.[StatusID] IS NULL
	END
	GO
	CREATE PROCEDURE PurchaseOrderStatusDim_GeneralLoad
	AS
	BEGIN
		INSERT INTO NorthWindDataWarehouse.dbo.[PurchaseOrderStatusDim]
			SELECT SA.[Status ID], SA.Status
			FROM 
			NorthWindStorageArea.dbo.[Purchase Order Status] AS SA
			LEFT JOIN
			NorthWindDataWarehouse.dbo.[PurchaseOrderStatusDim] AS DW
			ON  SA.[Status ID] = DW.[StatusID]
			WHERE DW.[StatusID] IS NULL
	END
	GO
	CREATE PROCEDURE PaymentMethodDim_GeneralLoad
	AS
	BEGIN
		INSERT INTO NorthWindDataWarehouse.dbo.[PaymentMethodDim]
			SELECT [Payment Method]
			FROM 
			(
				SELECT DISTINCT [Payment Method] 
				FROM NorthWindStorageArea.dbo.[Purchase Orders]
				WHERE [Payment Method] IS NOT NULL
				UNION
				SELECT DISTINCT [Payment Type]
				FROM NorthWindStorageArea.dbo.Orders
				WHERE [Payment Type] IS NOT NULL
			
			) AS SA 
			LEFT JOIN
			NorthWindDataWarehouse.dbo.PaymentMethodDim AS DW
			ON SA.[Payment Method] = DW.[Description]
			WHERE DW.[ID] IS NULL
	END
	GO
	CREATE PROCEDURE dbo.LocationDim_GeneralLoad
	AS
	BEGIN
		INSERT INTO NorthWindDataWarehouse.dbo.LocationDim
			SELECT [Ship Address],[Ship City],[Ship State/Province],
			[Ship Country/Region],[Ship ZIP/Postal Code]
			FROM(
				SELECT [Ship Address],[Ship City],[Ship State/Province],
				[Ship Country/Region],[Ship ZIP/Postal Code]
				FROM NorthWindStorageArea.dbo.Orders
				UNION
				SELECT [Address],[City],[State/Province],
				[Country/Region],[ZIP/Postal Code]
				FROM NorthWindStorageArea.dbo.Customers		
			) AS SA
			LEFT JOIN
			NorthWindDataWarehouse.dbo.[LocationDim] AS DW
			ON  SA.[Ship Address] = DW.[Address] AND SA.[Ship City] = DW.[City] 
			AND SA.[Ship State/Province] = DW.[State/Province] 
			AND SA.[Ship Country/Region] = DW.[Country/Region]
			AND SA.[Ship ZIP/Postal Code] = DW.[ZIP/Postal Code]
			WHERE DW.[Address] IS NULL
	END
	GO
	CREATE PROCEDURE dbo.DateDim_GeneralLoad
	AS
	BEGIN
		TRUNCATE TABLE NorthWindDataWarehouse.dbo.[DateDim]
		INSERT INTO NorthWindDataWarehouse.dbo.[DateDim]
		SELECT CONVERT(int, F1),CONVERT(date, F2),F3,CONVERT(int, F4),CONVERT(int, F5),
		F6,F7,CONVERT(int, F8),CONVERT(int, F9),CONVERT(int, F10),CONVERT(int, F11),CONVERT(int, F12),CONVERT(int, F13),
		F14,F15,F16,CONVERT(int, F17),CONVERT(int, F18),CONVERT(int, F19),CONVERT(int, F20),CONVERT(int, F21),CONVERT(int, F22),CONVERT(int, F23) --CONVERT(date, F2)
		FROM OPENROWSET
		(
			'Microsoft.ACE.OLEDB.12.0',
			'Excel 12.0; Database=C:\Users\User\Downloads\Telegram Desktop\Date.xlsx; HDR=No; IMEX=1', 
			'SELECT * FROM [Date$] WHERE [Date$].F1 <> "TimeKey"' 
		);
	END
	GO
	CREATE PROCEDURE dbo.Main_DimGeneralLoadProcedure
	AS
	BEGIN
			EXEC LocationDim_GeneralLoad
			EXEC SupplierDim_GeneralLoad
			EXEC EmployeeDim_GeneralLoad
			EXEC ShipperDim_GeneralLoad
			EXEC ProductDim_GeneralLoad
			EXEC CustomerDim_GeneralLoad
			EXEC OrderDetailsStatusDim_GeneralLoad
			EXEC OrderTaxStatusDim_GeneralLoad
			EXEC OrderStatusDim_GeneralLoad
			EXEC PurchaseOrderStatusDim_GeneralLoad
			EXEC PaymentMethodDim_GeneralLoad
			EXEC CheckInfoDim_GeneralLoad
			EXEC DateDim_GeneralLoad
			
	END

	--EXEC Main_DimGeneralLoadProcedure
