	USE NorthWindDataWarehouse
	GO

		/****** 
		
				Team Members:  SaraBaradaran, MahdiHeidari, AminEmamJomeh
				Script Date: January 1, 2021
		
		******/


	CREATE FUNCTION dbo.GetTimeKeyFunction(@DATE Date)
	RETURNS INT
	AS
	BEGIN
	RETURN (SELECT TimeKey FROM NorthWindDataWarehouse.dbo.DateDim WHERE @DATE = FullDateAlternateKey)
	END
	GO
	CREATE FUNCTION dbo.GetDateFunction(@TIMEKEY [INT])
	RETURNS DATE
	AS
	BEGIN
	RETURN (SELECT FullDateAlternateKey FROM NorthWindDataWarehouse.dbo.DateDim WHERE @TIMEKEY = TimeKey)
	END
	GO
	CREATE PROCEDURE dbo.PurchaseOrdersTransactionalFact_LoadProcedure(@MinDate Date, @MaxDate Date, @FirstLoad Bit)
	AS
	BEGIN
		DECLARE @RowNum [int]
		DECLARE @i [int]
		DECLARE @CreationDateKey [int]
		DECLARE @ApprovedDateKey [int]
		DECLARE @SubmitedDateKey [int]
		DECLARE @ExpectedDateKey [int]
		DECLARE @PaymentDateKey [int]
		DECLARE @PaymentMethodKey [int]
		DECLARE	@CreatorKey [int] 
		DECLARE	@ApproverKey [int] 
		DECLARE	@SubmitterKey [int] 
		DECLARE	@CheckKey [int]
		DECLARE	@PurchaseOrderID [int] 
		DECLARE	@SupplierID [int] 
		DECLARE	@Creator [int] 
		DECLARE	@Approver [int] 
		DECLARE	@Submitter [int] 
		DECLARE	@CreationDate [Date] 
		DECLARE	@ApprovedDate [Date] 
		DECLARE	@SubmittedDate [Date] 
		DECLARE	@ExpectedDate [Date] 
		DECLARE	@StatusID [int] 
		DECLARE	@ShippingFee [money] 
		DECLARE	@Taxes [money] 
		DECLARE	@PaymentDate [Date] 
		DECLARE	@PaymentAmount [money] 
		DECLARE	@PaymentMethod [nvarchar](60)
		DECLARE	@Notes [nvarchar](max)
		DECLARE @CurrentDate [Date]
		DECLARE @CurrentDateKey [int]

		IF @FirstLoad = 1
			TRUNCATE TABLE NorthWindDataWarehouse.dbo.[PurchaseOrdersTransactionalFact]

		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			SET @CurrentDateKey = dbo.GetTimeKeyFunction(@CurrentDate)
			DELETE NorthWindDataWarehouse.dbo.[PurchaseOrdersTransactionalFact]
			WHERE [CreationDateKey] = @CurrentDateKey
			SET @RowNum = (	SELECT COUNT([Purchase Order ID]) 
							FROM [NorthWindStorageArea].dbo.[Purchase Orders] 
							WHERE [Creation Date] = @CurrentDate
						  );
			SET @i=0;
			WHILE @i < @RowNum
			BEGIN
				SELECT	@PurchaseOrderID = [Purchase Order ID],
						@SupplierID = [Supplier ID],
						@Creator = [Creator],
						@Approver = [Approver], 
						@Submitter = [Submitter], 
						@CreationDate = [Creation Date],
						@ApprovedDate = [Approved Date],
						@SubmittedDate = [Submitted Date], 
						@ExpectedDate = [Expected Date],
						@StatusID = [Status ID],
						@ShippingFee = [Shipping Fee], 
						@Taxes = [Taxes],
						@PaymentDate = [Payment Date], 
						@PaymentAmount = [Payment Amount], 
						@PaymentMethod = [Payment Method],
						@Notes = [Notes],
						@CheckKey = [Check ID]

				FROM [NorthWindStorageArea].dbo.[Purchase Orders]
				WHERE [Creation Date] = @CurrentDate
				ORDER BY [Creation Date],[Purchase Order ID]
				OFFSET @i ROWS
				FETCH NEXT 1 ROWS ONLY;

				SET @CreationDateKey = dbo.GetTimeKeyFunction(@CreationDate) 
				SET @ApprovedDateKey = dbo.GetTimeKeyFunction(@ApprovedDate)
				SET @SubmitedDateKey = dbo.GetTimeKeyFunction(@SubmittedDate)
				SET @ExpectedDateKey = dbo.GetTimeKeyFunction(@ExpectedDate)
				SET @PaymentDateKey = dbo.GetTimeKeyFunction(@PaymentDate)
			
				SET @CreatorKey = (SELECT [EmployeeKey] FROM NorthWindDataWarehouse.dbo.[EmployeeDim] WHERE [ID] = @Creator AND [Current Flag] = '1')
				SET @ApproverKey = (SELECT [EmployeeKey] FROM NorthWindDataWarehouse.dbo.[EmployeeDim] WHERE [ID] = @Approver AND [Current Flag] = '1')
				SET @SubmitterKey = (SELECT [EmployeeKey] FROM NorthWindDataWarehouse.dbo.[EmployeeDim] WHERE [ID] = @Submitter AND [Current Flag] = '1')
				SET @PaymentMethodKey = (SELECT ID FROM NorthWindDataWarehouse.dbo.PaymentMethodDim WHERE @PaymentMethod = [Description]);

				INSERT INTO NorthWindDataWarehouse.dbo.[PurchaseOrdersTransactionalFact]
				VALUES (
						ISNULL(@PurchaseOrderID,-1),ISNULL(@SupplierID, -1),ISNULL(@CreatorKey, -1),ISNULL(@ApproverKey, -1),ISNULL(@SubmitterKey,-1),
						ISNULL(@Creator, -1),ISNULL(@Approver, -1),ISNULL(@Submitter, -1),ISNULL(@CreationDateKey, -1),ISNULL(@ApprovedDateKey, -1),
						ISNULL(@SubmitedDateKey, -1),ISNULL(@ExpectedDateKey, -1),ISNULL(@PaymentDateKey, -1),ISNULL(@PaymentMethodKey, -1),
						ISNULL(@StatusID, -1),ISNULL(@CheckKey, -1),ISNULL(@ShippingFee, 0),ISNULL(@Taxes, 0),ISNULL(@PaymentAmount, 0),@Notes
					   )

				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
		END
	END
	GO
	CREATE PROCEDURE dbo.PurchaseProductTransactionalFact_LoadProcedure(@MinDate Date, @MaxDate Date, @FirstLoad Bit)
	AS
	BEGIN
		DECLARE @RowNum [int]
		DECLARE @i [int]
		DECLARE @CreationDateKey [int]
		DECLARE @ApprovedDateKey [int]
		DECLARE @SubmitedDateKey [int]
		DECLARE @ExpectedDateKey [int]
		DECLARE @PaymentDateKey [int]
		DECLARE @DateReceivedKey [int]
		DECLARE @PaymentMethodKey [int]
		DECLARE	@CreatorKey [int] 
		DECLARE	@ApproverKey [int] 
		DECLARE	@SubmitterKey [int]
		DECLARE @ProductKey [int]

		DECLARE	@PurchaseOrderID [int] 
		DECLARE	@SupplierID [int] 
		DECLARE @ProductID [int]
		DECLARE	@Creator [int] 
		DECLARE	@Approver [int] 
		DECLARE	@Submitter [int] 
		DECLARE	@CreationDate [Date] 
		DECLARE	@ApprovedDate [Date] 
		DECLARE	@SubmittedDate [Date] 
		DECLARE	@ExpectedDate [Date] 
		DECLARE	@PaymentDate [Date] 
		DECLARE	@PaymentMethod [nvarchar](60)
		DECLARE	@Quantity [float]
		DECLARE	@DateReceived [Date] 
		DECLARE @CurrentDate [Date]
		DECLARE @CurrentDateKey [int]

		CREATE TABLE TEMPTABLE(
			[Purchase Order ID] [int] NOT NULL,
			[Supplier ID] [int] NULL,
			[Creator] [int] NULL,
			[Approver] [int] NULL,
			[Submitter] [int] NULL,
			[Creation Date] [Date] NULL,
			[Approved Date] [Date] NULL,
			[Submitted Date] [Date] NULL,
			[Expected Date] [Date] NULL,
			[Payment Date] [Date] NULL,
			[Payment Method] [nvarchar](60) NULL,

			[Product ID] [int] NULL,
			[Quantity] [float] NULL,
			[Date Received] [Date] NULL,
		)
		
		IF @FirstLoad = 1
			TRUNCATE TABLE NorthWindDataWarehouse.dbo.[PurchaseProductTransactionalFact]

		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			TRUNCATE TABLE TEMPTABLE
			INSERT INTO TEMPTABLE 
			SELECT PO.[Purchase Order ID],PO.[Supplier ID],PO.[Creator],PO.[Approver],
			PO.[Submitter],PO.[Creation Date],PO.[Approved Date],PO.[Submitted Date],
			PO.[Expected Date],PO.[Payment Date],PO.[Payment Method],POD.[Product ID],
			POD.[Quantity],POD.[Date Received]
			FROM 
			(
				SELECT [Purchase Order ID],[Supplier ID],[Creator],[Approver],
				[Submitter],[Creation Date],[Approved Date],[Submitted Date],
				[Expected Date],[Payment Date],[Payment Method]
				FROM [NorthWindStorageArea].dbo.[Purchase Orders] 
				WHERE [Creation Date] = @CurrentDate
			) AS PO
			INNER JOIN 
			(
				SELECT [Purchase Order ID], [Product ID], [Quantity],[Date Received]
				FROM [NorthWindStorageArea].dbo.[Purchase Order Details] 
			)AS POD
			ON POD.[Purchase Order ID] = PO.[Purchase Order ID]

			SET @RowNum = (	SELECT COUNT([Purchase Order ID]) FROM TEMPTABLE );

			DELETE NorthWindDataWarehouse.dbo.[PurchaseProductTransactionalFact]
			WHERE [CreationDateKey] = dbo.GetTimeKeyFunction(@CurrentDate)

			SET @i=0;
			WHILE @i < @RowNum
			BEGIN
				SELECT	@PurchaseOrderID = [Purchase Order ID],
						@SupplierID = [Supplier ID],
						@Creator = [Creator],
						@Approver = [Approver], 
						@Submitter = [Submitter], 
						@CreationDate = [Creation Date],
						@ApprovedDate = [Approved Date],
						@SubmittedDate = [Submitted Date], 
						@ExpectedDate = [Expected Date],
						@PaymentDate = [Payment Date], 
						@PaymentMethod = [Payment Method],
						@ProductID = [Product ID],
						@Quantity = [Quantity],
						@DateReceived = [Date Received]

				FROM TEMPTABLE
				ORDER BY [Creation Date],[Purchase Order ID]
				OFFSET @i ROWS
				FETCH NEXT 1 ROWS ONLY;

				SET @CreationDateKey = dbo.GetTimeKeyFunction(@CreationDate) 
				SET @ApprovedDateKey = dbo.GetTimeKeyFunction(@ApprovedDate)
				SET @SubmitedDateKey = dbo.GetTimeKeyFunction(@SubmittedDate)
				SET @ExpectedDateKey = dbo.GetTimeKeyFunction(@ExpectedDate)
				SET @PaymentDateKey = dbo.GetTimeKeyFunction(@PaymentDate)
				SET @DateReceivedKey = dbo.GetTimeKeyFunction(@DateReceived)

				SET @CreatorKey = (SELECT [EmployeeKey] FROM NorthWindDataWarehouse.dbo.[EmployeeDim] WHERE [ID] = @Creator AND [Current Flag] = '1')
				SET @ApproverKey = (SELECT [EmployeeKey] FROM NorthWindDataWarehouse.dbo.[EmployeeDim] WHERE [ID] = @Approver AND [Current Flag] = '1')
				SET @SubmitterKey = (SELECT [EmployeeKey] FROM NorthWindDataWarehouse.dbo.[EmployeeDim] WHERE [ID] = @Submitter AND [Current Flag] = '1')
				SET @ProductKey = (SELECT [ProductKey] FROM NorthWindDataWarehouse.dbo.[ProductDim] WHERE [ID] = @ProductID AND [Current Flag] = '1')
				SET @PaymentMethodKey = (SELECT ID FROM NorthWindDataWarehouse.dbo.PaymentMethodDim WHERE @PaymentMethod = [Description]);

				INSERT INTO NorthWindDataWarehouse.dbo.[PurchaseProductTransactionalFact]
				VALUES (
						ISNULL(@ProductKey, -1),ISNULL(@ProductID, -1),ISNULL(@SupplierID, -1),ISNULL(@CreatorKey, -1),ISNULL(@ApproverKey, -1),
						ISNULL(@SubmitterKey, -1), ISNULL(@Creator, -1),ISNULL(@Approver, -1),ISNULL(@Submitter, -1),ISNULL(@CreationDateKey, -1),
						ISNULL(@ApprovedDateKey, -1),ISNULL(@SubmitedDateKey,-1),ISNULL(@ExpectedDateKey, -1),ISNULL(@DateReceivedKey, -1),
						ISNULL(@PaymentDateKey, -1),ISNULL(@PaymentMethodKey, -1),ISNULL(@Quantity, 0)
					   )

				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
		END
		DROP TABLE TEMPTABLE
	END
	GO
	CREATE PROCEDURE dbo.PurchaseOrderDailyFact_LoadProcedure(@MinDate Date, @MaxDate Date, @FirstLoad Bit)
	AS
	BEGIN	
		DECLARE @i [int]
		DECLARE @j [int]
		DECLARE @MethodNum [int]
		DECLARE @SupplierNum [int]
		DECLARE	@SupplierKey [int] 
		DECLARE @PaymentMethodKey [int]
		DECLARE @TotalShippingFee [money]
		DECLARE @TotalTaxes [money]
		DECLARE @TotalCreatedNumbers [bigint]
		DECLARE @TotalApprovedNumbers [bigint] 
		DECLARE @TotalSubmittedNumbers [bigint]
		DECLARE @TotalExpectedNumbers [bigint] 
		DECLARE @TotalPaidNumbers [bigint]
		DECLARE @TotalPaymentAmount [money]
		DECLARE @CurrentDate [Date]
		DECLARE @CurrentDateKey [int]

		IF @FirstLoad = 1
			TRUNCATE TABLE NorthWindDataWarehouse.dbo.[PurchaseOrdersDailyFact]

		SET @SupplierNum = (SELECT COUNT(*) FROM NorthWindDataWarehouse.dbo.[SupplierDim]);
		SET @MethodNum = (SELECT COUNT(*) FROM NorthWindDataWarehouse.dbo.[PaymentMethodDim]);
		
		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			SET @CurrentDateKey = dbo.GetTimeKeyFunction(@CurrentDate)
			DELETE NorthWindDataWarehouse.dbo.[PurchaseOrdersDailyFact]
			WHERE [DateKey] = @CurrentDateKey
			SET @i=0;
			WHILE @i < @SupplierNum
			BEGIN
				SELECT	@SupplierKey = [ID]
				FROM NorthWindDataWarehouse.dbo.[SupplierDim]
				ORDER BY [ID]
				OFFSET @i ROWS
				FETCH NEXT 1 ROWS ONLY;
				SET @j=0;
				WHILE @j < @MethodNum
				BEGIN	
					SELECT	@PaymentMethodKey = [ID]
					FROM NorthWindDataWarehouse.dbo.[PaymentMethodDim]
					ORDER BY [ID]
					OFFSET @j ROWS
					FETCH NEXT 1 ROWS ONLY;

					SELECT @TotalShippingFee = SUM([ShippingFee]),
						   @TotalTaxes = SUM([Taxes]),
						   @TotalPaymentAmount = SUM([PaymentAmount]),
						   @TotalCreatedNumbers = COUNT(*)
					FROM NorthWindDataWarehouse.dbo.[PurchaseOrdersTransactionalFact]
					WHERE [SupplierKey] = @SupplierKey AND [PaymentMethodKey] = @PaymentMethodKey AND [CreationDateKey] = @CurrentDateKey

					SELECT @TotalApprovedNumbers = COUNT(*)
					FROM NorthWindDataWarehouse.dbo.[PurchaseOrdersTransactionalFact] 
					WHERE [SupplierKey] = @SupplierKey AND [PaymentMethodKey] = @PaymentMethodKey AND [ApprovedDateKey] = @CurrentDateKey
					
					SELECT @TotalSubmittedNumbers = COUNT(*)
					FROM NorthWindDataWarehouse.dbo.[PurchaseOrdersTransactionalFact]  
					WHERE [SupplierKey] = @SupplierKey AND [PaymentMethodKey] = @PaymentMethodKey AND [SubmittedDateKey] = @CurrentDateKey

					SELECT @TotalExpectedNumbers = COUNT(*)
					FROM NorthWindDataWarehouse.dbo.[PurchaseOrdersTransactionalFact]  
					WHERE [SupplierKey] = @SupplierKey AND [PaymentMethodKey] = @PaymentMethodKey AND [ExpectedDateKey] = @CurrentDateKey

					SELECT @TotalPaidNumbers = COUNT(*)
					FROM NorthWindDataWarehouse.dbo.[PurchaseOrdersTransactionalFact]  
					WHERE [SupplierKey] = @SupplierKey AND [PaymentMethodKey] = @PaymentMethodKey AND [PaymentDateKey] = @CurrentDateKey

					INSERT INTO NorthWindDataWarehouse.dbo.[PurchaseOrdersDailyFact] VALUES
					(
					 @SupplierKey,@PaymentMethodKey,@CurrentDateKey,ISNULL(@TotalShippingFee, 0),ISNULL(@TotalTaxes, 0),
					 ISNULL(@TotalPaymentAmount, 0),ISNULL(@TotalCreatedNumbers, 0),ISNULL(@TotalApprovedNumbers, 0),
					 ISNULL(@TotalSubmittedNumbers, 0),ISNULL(@TotalExpectedNumbers, 0),ISNULL(@TotalPaidNumbers, 0)
					)
					SET @j = @j + 1
				END
				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
		END
	END
	GO
	CREATE PROCEDURE dbo.PurchaseProductDailyFact_LoadProcedure(@MinDate Date, @MaxDate Date, @FirstLoad Bit)
	AS
	BEGIN
		DECLARE @i [int]
		DECLARE @j [int]
		DECLARE @SupplierNum [int]
		DECLARE @ProductNum [int]
		DECLARE @RowNum [int]
		DECLARE	@SupplierKey [int] 
		DECLARE @ProductKey [int]
		DECLARE @ProductNaturalKey [int]
		DECLARE @StandardCost [money]
		DECLARE @TotalQuantity [float]
		DECLARE @TotalCost [money]
		DECLARE @MinQuantity [float]
		DECLARE @MaxQuantity [float] 
		DECLARE @CurrentDate [Date]
		DECLARE @CurrentDateKey [int]

		IF @FirstLoad = 1
			TRUNCATE TABLE NorthWindDataWarehouse.dbo.[PurchaseProductDailyFact]

		SET @SupplierNum = (SELECT COUNT(*) FROM NorthWindDataWarehouse.dbo.[SupplierDim]);
		SET @ProductNum = (SELECT COUNT(*) FROM NorthWindDataWarehouse.dbo.[ProductDim] WHERE [Current Flag] = '1');
		
		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			SET @CurrentDateKey = dbo.GetTimeKeyFunction(@CurrentDate)
			DELETE NorthWindDataWarehouse.dbo.[PurchaseProductDailyFact]
			WHERE [DateKey] = @CurrentDateKey
			SET @i=0;
			WHILE @i < @SupplierNum
			BEGIN
				SELECT	@SupplierKey = [ID]
				FROM NorthWindDataWarehouse.dbo.[SupplierDim]
				ORDER BY [ID]
				OFFSET @i ROWS
				FETCH NEXT 1 ROWS ONLY;
				SET @j=0;
				WHILE @j < @ProductNum
				BEGIN	
					SELECT	@ProductKey = [ProductKey], @ProductNaturalKey = [ID], @StandardCost = [Standard Cost] 
					FROM NorthWindDataWarehouse.dbo.[ProductDim]
					WHERE [Current Flag] = '1'
					ORDER BY [ProductKey]
					OFFSET @j ROWS
					FETCH NEXT 1 ROWS ONLY;

					WITH TEMP ([Quantity],[CreationDateKey]) 
					AS
					(
					SELECT [Quantity],[CreationDateKey]
					FROM NorthWindDataWarehouse.dbo.[PurchaseProductTransactionalFact]
					WHERE [ProductKey] = @ProductKey AND [SupplierKey] = @SupplierKey
					)
					SELECT @TotalQuantity = SUM([Quantity]),
						   @MinQuantity = MIN([Quantity]),
						   @MaxQuantity = MAX([Quantity]),
						   @TotalCost = SUM([Quantity]) * @StandardCost
					FROM TEMP 
					WHERE [CreationDateKey] = @CurrentDateKey

					INSERT INTO NorthWindDataWarehouse.dbo.[PurchaseProductDailyFact] VALUES
					(
					 @ProductKey,@ProductNaturalKey,@SupplierKey,@CurrentDateKey,
					 ISNULL(@TotalQuantity, 0),ISNULL(@MinQuantity, 0),ISNULL(@MaxQuantity, 0),ISNULL(@TotalCost, 0)
					)
					SET @j = @j + 1
				END
				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
		END
	END
	GO
	CREATE PROCEDURE dbo.PurchaseOrderAccFact_LoadProcedure(@MinDate Date, @MaxDate Date, @FirstLoad Bit)
	AS
	BEGIN
		DECLARE @i [int]
		DECLARE @RowNum [int]
		DECLARE @DateKey [int]
		DECLARE	@SupplierKey [int] 
		DECLARE @PaymentMethodKey [int]
		DECLARE @TotalShippingFee [money]
		DECLARE @TotalTaxes [money]
		DECLARE @TotalCreatedNumbers [bigint]
		DECLARE @TotalApprovedNumbers [bigint] 
		DECLARE @TotalSubmittedNumbers [bigint]
		DECLARE @TotalExpectedNumbers [bigint] 
		DECLARE @TotalPaidNumbers [bigint]
		DECLARE @TotalPaymentAmount [money]
		DECLARE @FirstOrderDate [Date] 
		DECLARE @LastOrderDate [Date] 
		DECLARE @TotalCreatedNumbers_Daily [bigint]
		DECLARE @TotalSubmittedNumbers_Daily [bigint]
		DECLARE @TotalApprovedNumbers_Daily [bigint]
		DECLARE @TotalPaidNumbers_Daily [bigint]
		DECLARE @TotalExpectedNumbers_Daily [bigint]
		DECLARE @TotalShippingFee_Daily [money]
		DECLARE @TotalTaxes_Daily [money]
		DECLARE @TotalPaymentAmount_Daily [money]
		DECLARE @CurrentDate [Date]
		DECLARE @CurrentDateKey [int]

		IF @FirstLoad = 1
			TRUNCATE TABLE NorthWindDataWarehouse.dbo.[PurchaseOrderAccFact]

		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			SET @CurrentDateKey = dbo.GetTimeKeyFunction(@CurrentDate)
			SET @RowNum = (SELECT COUNT(*) FROM NorthWindDataWarehouse.dbo.[PurchaseOrdersDailyFact] WHERE [DateKey] = @CurrentDateKey)
			SET @i = 0;
			WHILE @i < @RowNum
			BEGIN
				SELECT	@SupplierKey = [SupplierKey],
						@PaymentMethodKey = [PaymentMethodKey],
						@DateKey = [DateKey],
						@TotalCreatedNumbers_Daily = [TotalCreatedNumbers],
						@TotalApprovedNumbers_Daily = [TotalApprovedNumbers],
						@TotalSubmittedNumbers_Daily = [TotalSubmittedNumbers],
						@TotalExpectedNumbers_Daily = [TotalExpectedNumbers],
						@TotalPaidNumbers_Daily = [TotalPaidNumbers],
						@TotalShippingFee_Daily = [TotalShippingFee],
						@TotalTaxes_Daily = [TotalTaxes],
						@TotalPaymentAmount_Daily = [TotalPaymentAmount]
					
				FROM NorthWindDataWarehouse.dbo.[PurchaseOrdersDailyFact]
				WHERE [DateKey] = @CurrentDateKey
				ORDER BY [SupplierKey],[PaymentMethodKey]
				OFFSET @i ROWS
				FETCH NEXT 1 ROWS ONLY;

				SET @TotalCreatedNumbers = '-1'
				SELECT @TotalShippingFee = [TotalShippingFee],
					   @TotalTaxes = [TotalTaxes],
					   @TotalPaymentAmount = [TotalPaymentAmount],
					   @TotalCreatedNumbers = [TotalCreatedNumbers],
					   @TotalApprovedNumbers = [TotalApprovedNumbers],
					   @TotalSubmittedNumbers = [TotalSubmittedNumbers],
					   @TotalExpectedNumbers = [TotalExpectedNumbers],
					   @TotalPaidNumbers = [TotalPaidNumbers],
					   @FirstOrderDate = [FirstCreatedDate],
					   @LastOrderDate = [LastCreatedDate]

				FROM NorthWindDataWarehouse.dbo.[PurchaseOrderAccFact]
				WHERE [SupplierKey] = @SupplierKey AND [PaymentMethodKey] = @PaymentMethodKey

				IF @TotalCreatedNumbers = '-1'
				BEGIN
					INSERT INTO NorthWindDataWarehouse.dbo.[PurchaseOrderAccFact] VALUES
					(
					 @SupplierKey,@PaymentMethodKey,@TotalShippingFee_Daily,
					 @TotalTaxes_Daily,@TotalPaymentAmount_Daily,@TotalCreatedNumbers_Daily,
					 @TotalApprovedNumbers_Daily,@TotalSubmittedNumbers_Daily,
					 @TotalExpectedNumbers_Daily,@TotalPaidNumbers_Daily,
					 CASE WHEN @TotalCreatedNumbers_Daily <> 0 THEN @CurrentDate ELSE NULL END,
					 CASE WHEN @TotalCreatedNumbers_Daily <> 0 THEN @CurrentDate ELSE NULL END
					)
				END
				ELSE
				BEGIN
					DELETE NorthWindDataWarehouse.dbo.[PurchaseOrderAccFact]
					WHERE [SupplierKey] = @SupplierKey AND [PaymentMethodKey] = @PaymentMethodKey 

					INSERT INTO NorthWindDataWarehouse.dbo.[PurchaseOrderAccFact] VALUES
					(
					 @SupplierKey,@PaymentMethodKey,
					 @TotalShippingFee_Daily + @TotalShippingFee,
					 @TotalTaxes_Daily + @TotalTaxes,
					 @TotalPaymentAmount_Daily + @TotalPaymentAmount,
					 @TotalCreatedNumbers_Daily + @TotalCreatedNumbers,
					 @TotalApprovedNumbers_Daily + @TotalApprovedNumbers,
					 @TotalSubmittedNumbers_Daily + @TotalSubmittedNumbers,
					 @TotalExpectedNumbers_Daily + @TotalExpectedNumbers,
					 @TotalPaidNumbers_Daily + @TotalPaidNumbers,
					 CASE WHEN @FirstOrderDate IS NOT NULL THEN @FirstOrderDate
						  WHEN @FirstOrderDate IS NULL AND @TotalCreatedNumbers_Daily <> 0 THEN @CurrentDate
						  ELSE NULL END,
					 CASE WHEN @TotalCreatedNumbers_Daily <> 0 THEN @CurrentDate ELSE @LastOrderDate END
					)
				END
				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
		END
	END
	GO
	CREATE PROCEDURE dbo.PurchaseProductAccFact_LoadProcedure(@MinDate Date, @MaxDate Date, @FirstLoad Bit)
	AS
	BEGIN
		DECLARE @i [int]
		DECLARE @RowNum [int]
		DECLARE	@SupplierKey [int] 
		DECLARE @ProductKey [int]
		DECLARE @ProductNaturalKey [int]
		DECLARE @DateKey [int]
		DECLARE @TotalQuantity_Daily [float]
		DECLARE @TotalCost_Daily [money]
		DECLARE @MinQuantity_Daily [float]
		DECLARE @MaxQuantity_Daily [float] 
		DECLARE @TotalQuantity [float]
		DECLARE @TotalCost [money]
		DECLARE @MinQuantity [float]
		DECLARE @MaxQuantity [float] 
		DECLARE @FirstPurchaseDate [Date] 
		DECLARE @LastPurchaseDate [Date] 
		DECLARE @CurrentDate [Date]
		DECLARE @CurrentDateKey [int]

		IF @FirstLoad = 1
			TRUNCATE TABLE NorthWindDataWarehouse.dbo.[PurchaseProductAccFact]

		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			SET @CurrentDateKey = dbo.GetTimeKeyFunction(@CurrentDate)
			SET @RowNum = (SELECT COUNT(*) FROM NorthWindDataWarehouse.dbo.[PurchaseProductDailyFact] WHERE [DateKey] = @CurrentDateKey)
			SET @i = 0;
			WHILE @i < @RowNum
			BEGIN
				SELECT	@SupplierKey = [SupplierKey],
						@ProductKey = [ProductKey],
						@ProductNaturalKey = [ProductNaturalKey],
						@DateKey = [DateKey],
						@TotalQuantity_Daily = [TotalQuantity],
						@TotalCost_Daily = [TotalCost],
						@MinQuantity_Daily = [MinQuantity],
						@MaxQuantity_Daily = [MaxQuantity]
					
				FROM NorthWindDataWarehouse.dbo.[PurchaseProductDailyFact]
				WHERE [DateKey] = @CurrentDateKey
				ORDER BY [SupplierKey],[ProductKey]
				OFFSET @i ROWS
				FETCH NEXT 1 ROWS ONLY;

				SET @TotalQuantity = '-1'
				SELECT  @TotalQuantity = [TotalQuantity],
						@TotalCost = [TotalCost],
						@MinQuantity = [MinQuantity],
						@MaxQuantity = [MaxQuantity],
						@FirstPurchaseDate = [FirstPurchaseDate],
						@LastPurchaseDate = [LastPurchaseDate]

				FROM NorthWindDataWarehouse.dbo.[PurchaseProductAccFact]
				WHERE [SupplierKey] = @SupplierKey AND [ProductKey] = @ProductKey

				IF @TotalQuantity = '-1'
				BEGIN
					INSERT INTO NorthWindDataWarehouse.dbo.[PurchaseProductAccFact] VALUES
					(
					 @ProductKey,@ProductNaturalKey,@SupplierKey,@TotalQuantity_Daily,
					 @TotalCost_Daily,@MinQuantity_Daily,@MaxQuantity_Daily,
					 CASE WHEN @TotalQuantity_Daily <> 0 THEN @CurrentDate ELSE NULL END,
					 CASE WHEN @TotalQuantity_Daily <> 0 THEN @CurrentDate ELSE NULL END
					)
				END
				ELSE
				BEGIN
					DELETE NorthWindDataWarehouse.dbo.[PurchaseProductAccFact]
					WHERE [SupplierKey] = @SupplierKey AND [ProductKey] = @ProductKey 

					INSERT INTO NorthWindDataWarehouse.dbo.[PurchaseProductAccFact] VALUES
					(
					 @ProductKey,@ProductNaturalKey,@SupplierKey,
					 @TotalQuantity_Daily + @TotalQuantity,
					 @TotalCost_Daily + @TotalCost,
					 CASE WHEN @MinQuantity_Daily < @MinQuantity THEN @MinQuantity_Daily ELSE @MinQuantity END,
					 CASE WHEN @MaxQuantity < @MaxQuantity_Daily THEN @MaxQuantity_Daily ELSE @MaxQuantity END,
					 CASE WHEN @FirstPurchaseDate IS NOT NULL THEN @FirstPurchaseDate
						  WHEN @FirstPurchaseDate IS NULL AND @TotalQuantity_Daily <> 0 THEN @CurrentDate
						  ELSE NULL END,
					 CASE WHEN @TotalQuantity_Daily <> 0 THEN @CurrentDate ELSE @LastPurchaseDate END
					)
				END
				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
		END
	END
	GO
	CREATE PROCEDURE dbo.[Employe'sPurchaseOrderDailyFact_LoadProcedure](@MinDate Date, @MaxDate Date, @FirstLoad Bit)
	AS
	BEGIN
		DECLARE @i [int]
		DECLARE @EmployeeNum [int]
		DECLARE	@EmployeeKey [int] 
		DECLARE	@EmployeeNaturalKey [int] 
		DECLARE @TotalCreatedNumbers [bigint]
		DECLARE @TotalApprovedNumbers [bigint] 
		DECLARE @TotalSubmittedNumbers [bigint]
		DECLARE @CurrentDate [Date]
		DECLARE @CurrentDateKey [int]
		
		IF @FirstLoad = 1
			TRUNCATE TABLE NorthWindDataWarehouse.dbo.[Employe'sPurchaseOrderDailyFact]

		SET @EmployeeNum = (SELECT COUNT(*) FROM NorthWindDataWarehouse.dbo.[EmployeeDim] WHERE [Current Flag] = '1');
		
		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			SET @CurrentDateKey = dbo.GetTimeKeyFunction(@CurrentDate)
			DELETE NorthWindDataWarehouse.dbo.[Employe'sPurchaseOrderDailyFact]
			WHERE [DateKey] = @CurrentDateKey
			SET @i = 0;
			WHILE @i < @EmployeeNum
			BEGIN
				SELECT	@EmployeeKey = [EmployeeKey], @EmployeeNaturalKey = [ID]
				FROM NorthWindDataWarehouse.dbo.[EmployeeDim]
				WHERE [Current Flag] = '1'
				ORDER BY [EmployeeKey]
				OFFSET @i ROWS
				FETCH NEXT 1 ROWS ONLY;

				SELECT @TotalCreatedNumbers = COUNT(*)
				FROM NorthWindDataWarehouse.dbo.[PurchaseOrdersTransactionalFact]
				WHERE [CreatorKey] = @EmployeeKey AND [CreationDateKey] = @CurrentDateKey

				SELECT @TotalApprovedNumbers = COUNT(*)
				FROM NorthWindDataWarehouse.dbo.[PurchaseOrdersTransactionalFact]
				WHERE [ApproverKey] = @EmployeeKey AND [ApprovedDateKey] = @CurrentDateKey

				SELECT @TotalSubmittedNumbers = COUNT(*)
				FROM NorthWindDataWarehouse.dbo.[PurchaseOrdersTransactionalFact]
				WHERE [SubmitterKey] = @EmployeeKey AND [SubmittedDateKey] = @CurrentDateKey

				INSERT INTO [Employe'sPurchaseOrderDailyFact] VALUES
				(
					@EmployeeKey,@EmployeeNaturalKey,@CurrentDateKey,ISNULL(@TotalCreatedNumbers, 0),
					ISNULL(@TotalApprovedNumbers, 0),ISNULL(@TotalSubmittedNumbers, 0)
				)

				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
		END
	END
	GO
	CREATE PROCEDURE dbo.[Employe'sPurchaseOrderAccFact_LoadProcedure](@MinDate Date, @MaxDate Date, @FirstLoad Bit)
	AS
	BEGIN
		DECLARE @i [int]
		DECLARE @RowNum [int]
		DECLARE @DateKey [int]
		DECLARE @EmployeeKey [int]
		DECLARE @EmployeeNaturalKey [int]
		DECLARE @TotalCreatedNumbers [bigint]
		DECLARE @TotalApprovedNumbers [bigint] 
		DECLARE @TotalSubmittedNumbers [bigint]	
		DECLARE @FirstCreatedDate [Date]
		DECLARE @LastCreatedDate [Date]
		DECLARE @FirstApprovedDate [Date]
		DECLARE @LastApprovedDate [Date]
		DECLARE @FirstSubmittedDate [Date]
		DECLARE @LastSubmittedDate [Date] 
		DECLARE @TotalCreatedNumbers_Daily [bigint]
		DECLARE @TotalSubmittedNumbers_Daily [bigint]
		DECLARE @TotalApprovedNumbers_Daily [bigint]
		DECLARE @CurrentDate [Date]
		DECLARE @CurrentDateKey [int]
		
		IF @FirstLoad = 1
			TRUNCATE TABLE NorthWindDataWarehouse.dbo.[Employe'sPurchaseOrderAccFact]

		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			SET @CurrentDateKey = dbo.GetTimeKeyFunction(@CurrentDate)
			SET @RowNum = (SELECT COUNT(*) FROM NorthWindDataWarehouse.dbo.[Employe'sPurchaseOrderDailyFact] WHERE [DateKey] = @CurrentDateKey)
			SET @i = 0;
			WHILE @i < @RowNum
			BEGIN
				SELECT	@EmployeeKey = [EmployeeKey],
						@EmployeeNaturalKey = [EmployeeNaturalKey],
						@DateKey = [DateKey],
						@TotalCreatedNumbers_Daily = [TotalCreatedNumbers],
						@TotalApprovedNumbers_Daily = [TotalApprovedNumbers],
						@TotalSubmittedNumbers_Daily = [TotalSubmittedNumbers]
					
				FROM NorthWindDataWarehouse.dbo.[Employe'sPurchaseOrderDailyFact]
				WHERE [DateKey] = @CurrentDateKey
				ORDER BY [EmployeeKey]
				OFFSET @i ROWS
				FETCH NEXT 1 ROWS ONLY;

				SET @TotalCreatedNumbers = '-1'
				SELECT @EmployeeKey = [EmployeeKey],
					   @TotalCreatedNumbers = [TotalCreatedNumbers],
					   @TotalApprovedNumbers = [TotalApprovedNumbers],
					   @TotalSubmittedNumbers = [TotalSubmittedNumbers],
					   @FirstCreatedDate = [FirstCreatedDate],
					   @LastCreatedDate = [LastCreatedDate],
					   @FirstApprovedDate = [FirstApprovedDate],
					   @LastApprovedDate = [LastApprovedDate],
					   @FirstSubmittedDate = [FirstSubmittedDate],
					   @LastSubmittedDate = [LastSubmittedDate]

				FROM NorthWindDataWarehouse.dbo.[Employe'sPurchaseOrderAccFact]
				WHERE [EmployeeKey] = @EmployeeKey

				IF @TotalCreatedNumbers = '-1'
				BEGIN
					INSERT INTO NorthWindDataWarehouse.dbo.[Employe'sPurchaseOrderAccFact] VALUES
					(
					 @EmployeeKey,@EmployeeNaturalKey,@TotalCreatedNumbers_Daily,
					 @TotalApprovedNumbers_Daily,@TotalSubmittedNumbers_Daily,
					 CASE WHEN @TotalCreatedNumbers_Daily <> 0 THEN @CurrentDate ELSE NULL END,
					 CASE WHEN @TotalCreatedNumbers_Daily <> 0 THEN @CurrentDate ELSE NULL END,
					 CASE WHEN @TotalApprovedNumbers_Daily <> 0 THEN @CurrentDate ELSE NULL END,
					 CASE WHEN @TotalApprovedNumbers_Daily <> 0 THEN @CurrentDate ELSE NULL END,
					 CASE WHEN @TotalSubmittedNumbers_Daily <> 0 THEN @CurrentDate ELSE NULL END,
					 CASE WHEN @TotalSubmittedNumbers_Daily <> 0 THEN @CurrentDate ELSE NULL END
					)
				END
				ELSE
				BEGIN
					DELETE NorthWindDataWarehouse.dbo.[Employe'sPurchaseOrderAccFact]
					WHERE [EmployeeKey] = @EmployeeKey

					INSERT INTO NorthWindDataWarehouse.dbo.[Employe'sPurchaseOrderAccFact] VALUES
					(
					 @EmployeeKey,@EmployeeNaturalKey,
					 @TotalCreatedNumbers_Daily + @TotalCreatedNumbers,
					 @TotalApprovedNumbers_Daily + @TotalApprovedNumbers,
					 @TotalSubmittedNumbers_Daily + @TotalSubmittedNumbers,
					 CASE WHEN @FirstCreatedDate IS NOT NULL THEN @FirstCreatedDate 
						  WHEN @FirstCreatedDate IS NULL AND @TotalCreatedNumbers_Daily <> 0 THEN @CurrentDate
						  ELSE NULL END,
					 CASE WHEN @TotalCreatedNumbers_Daily <> 0 THEN @CurrentDate ELSE @LastCreatedDate END,
					 CASE WHEN @FirstApprovedDate IS NOT NULL THEN @FirstApprovedDate 
						  WHEN @FirstApprovedDate IS NULL AND @TotalApprovedNumbers_Daily <> 0 THEN @CurrentDate
						  ELSE NULL END,
					 CASE WHEN @TotalApprovedNumbers_Daily <> 0 THEN @CurrentDate ELSE @LastApprovedDate END,
					 CASE WHEN @FirstSubmittedDate IS NOT NULL THEN @FirstSubmittedDate 
						  WHEN @FirstSubmittedDate IS NULL AND @TotalSubmittedNumbers_Daily <> 0 THEN @CurrentDate
						  ELSE NULL END,
					 CASE WHEN @TotalSubmittedNumbers_Daily <> 0 THEN @CurrentDate ELSE @LastSubmittedDate END
					)
				END
				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
		END
	END
	GO
	CREATE PROCEDURE dbo.SalesOrdersTransactionalFact_LoadProcedure(@MinDate Date, @MaxDate Date, @FirstLoad Bit)
	AS
	BEGIN
		DECLARE @RowNum [int]
		DECLARE @i [int]
		DECLARE @EmployeeKey [int]
		DECLARE @OrderDateKey [int]
		DECLARE @ShippedDateKey [int]
		DECLARE @PaidDateKey [int]
		DECLARE @PaymentMethodKey [int]
		DECLARE	@CheckKey [int]
		DECLARE @LocationKey [int]
		DECLARE	@OrderID [int] 
		DECLARE	@EmployeeID [int] 
		DECLARE	@CustomerID [int] 
		DECLARE @ShipperID [int]
		DECLARE	@OrderDate [Date] 
		DECLARE	@ShippedDate [Date] 
		DECLARE @PaidDate [Date]
		DECLARE	@StatusID [smallint] 
		DECLARE	@TaxStatus [smallint]
		DECLARE	@ShippingFee [money] 
		DECLARE @TaxRate [float]
		DECLARE	@Taxes [money] 
		DECLARE	@PaymentType [nvarchar](60)
		DECLARE	@PaymentAmount [money] 
		DECLARE	@Notes [nvarchar](max)
		DECLARE @ShipAddress [nvarchar](max) 
		DECLARE	@ShipCity [nvarchar](60) 
		DECLARE	@ShipProvince [nvarchar](60)
		DECLARE	@ShipPostalCode [nvarchar](60)
		DECLARE	@ShipRegion [nvarchar](60)
		DECLARE @CurrentDate [Date]
		DECLARE @CurrentDateKey [int]

		IF @FirstLoad = 1
			TRUNCATE TABLE NorthWindDataWarehouse.dbo.[SalesOrdersTransactionalFact]

		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			SET @CurrentDateKey = dbo.GetTimeKeyFunction(@CurrentDate)
			DELETE NorthWindDataWarehouse.dbo.[SalesOrdersTransactionalFact]
			WHERE [OrderDateKey] = @CurrentDateKey
			SET @RowNum = (	SELECT COUNT([Order ID]) 
							FROM [NorthWindStorageArea].dbo.[Orders]
							WHERE [Order Date] = @CurrentDate
						  );
			SET @i=0;
			WHILE @i < @RowNum
			BEGIN
				SELECT	@OrderID = [Order ID],
						@EmployeeID = [Employee ID],
						@CustomerID = [Customer ID],
						@ShipperID = [Shipper ID], 
						@OrderDate = [Order Date], 
						@ShippedDate = [Shipped Date],
						@PaidDate = [Paid Date],
						@StatusID = [Status ID],
						@ShippingFee = [Shipping Fee], 
						@Taxes = [Taxes],
						@PaymentType = [Payment Type],
						@TaxRate = [Tax Rate],
						@TaxStatus = [Tax Status],
						@Notes = [Notes],
						@CheckKey = [Check ID],
						@ShipAddress = [Ship Address],
						@ShipCity = [Ship City],
						@ShipProvince = [Ship State/Province],
						@ShipPostalCode = [Ship ZIP/Postal Code],
						@ShipRegion = [Ship Country/Region]

				FROM [NorthWindStorageArea].dbo.[Orders]
				WHERE [Order Date] = @CurrentDate
				ORDER BY [Order Date],[Order ID]
				OFFSET @i ROWS
				FETCH NEXT 1 ROWS ONLY;
			
				SET @OrderDateKey = dbo.GetTimeKeyFunction(@OrderDate)
				SET @ShippedDateKey = dbo.GetTimeKeyFunction(@ShippedDate)
				SET @PaidDateKey = dbo.GetTimeKeyFunction(@PaidDate)
				SET @EmployeeKey = (SELECT [EmployeeKey] FROM NorthWindDataWarehouse.dbo.[EmployeeDim] WHERE [ID] = @EmployeeID AND [Current Flag] = '1')
				SET @PaymentMethodKey = (SELECT ID FROM NorthWindDataWarehouse.dbo.PaymentMethodDim WHERE @PaymentType = [Description])
				SET @LocationKey = (SELECT ID FROM NorthWindDataWarehouse.dbo.LocationDim 
									WHERE @ShipAddress = [Address] AND @ShipCity = [City] AND @ShipProvince = [State/Province] AND
									@ShipPostalCode = [ZIP/Postal Code] AND @ShipRegion = [Country/Region])
				
				SET @PaymentAmount = (SELECT SUM([Unit Price] * Quantity * (1-Discount)) FROM NorthWindStorageArea.dbo.[Order Details] WHERE [Order ID] = @OrderID)
				
				INSERT INTO NorthWindDataWarehouse.dbo.[SalesOrdersTransactionalFact]
				VALUES (
						ISNULL(@OrderID, -1),ISNULL(@EmployeeKey, -1),ISNULL(@EmployeeID, -1),ISNULL(@CustomerID, -1),ISNULL(@ShipperID, -1),
						ISNULL(@OrderDateKey, -1),ISNULL(@ShippedDateKey, -1),ISNULL(@PaidDateKey, -1),ISNULL(@PaymentMethodKey, -1),ISNULL(@TaxStatus, -1),
						ISNULL(@StatusID, -1),ISNULL(@CheckKey, -1),ISNULL(@LocationKey, -1),ISNULL(@PaymentAmount, 0),ISNULL(@ShippingFee, 0),ISNULL(@Taxes, 0),ISNULL(@TaxRate, 0),@Notes
					   )

				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
		END
	END
	GO
	CREATE PROCEDURE dbo.SalesProductTransactionalFact_LoadProcedure(@MinDate Date, @MaxDate Date, @FirstLoad Bit)
	AS
	BEGIN
		DECLARE @RowNum [int]
		DECLARE @i [int]
		DECLARE @EmployeeKey [int]
		DECLARE @OrderDateKey [int]
		DECLARE @ShippedDateKey [int]
		DECLARE @PaidDateKey [int]
		DECLARE @DateAllocatedKey [int]
		DECLARE @PaymentMethodKey [int]
		DECLARE @ProductKey [int]
		DECLARE @LocationKey [int]

		DECLARE	@OrderID [int] 
		DECLARE	@EmployeeID [int] 
		DECLARE	@CustomerID [int] 
		DECLARE @ShipperID [int]
		DECLARE @ProductID [int]
		DECLARE	@OrderDate [Date] 
		DECLARE	@ShippedDate [Date] 
		DECLARE @DateAllocated [Date]
		DECLARE @PaidDate [Date]
		DECLARE	@StatusID [smallint] 
		DECLARE	@PaymentType [nvarchar](50)
		DECLARE @Quantity [float]
		DECLARE @Discount [float]
		DECLARE @ShipAddress [nvarchar](max) 
		DECLARE	@ShipCity [nvarchar](50) 
		DECLARE	@ShipProvince [nvarchar](50)
		DECLARE	@ShipPostalCode [nvarchar](50)
		DECLARE	@ShipRegion [nvarchar](50)
		DECLARE @CurrentDate [Date]
		DECLARE @CurrentDateKey [int]

		CREATE TABLE TEMPTABLE2(
			[Order ID] [int] NOT NULL,
			[Employee ID] [int] NULL,
			[Customer ID] [int] NULL,
			[Order Date] [Date] NULL,
			[Shipped Date] [Date] NULL,
			[Shipper ID] [int] NULL,
			[Payment Type] [nvarchar](50) NULL,
			[Paid Date] [Date] NULL,

			[Product ID] [int] NULL,
			[Quantity] [float] NULL,
			[Discount] [float] NULL,
			[Status ID] [int] NULL,
			[Date Allocated] [Date] NULL,
			
			[Ship Address] [nvarchar](max) NULL,
			[Ship City] [nvarchar](50) NULL,
			[Ship State/Province] [nvarchar](50) NULL,
			[Ship ZIP/Postal Code] [nvarchar](50) NULL,
			[Ship Country/Region] [nvarchar](50) NULL,
		)
		
		IF @FirstLoad = 1
			TRUNCATE TABLE NorthWindDataWarehouse.dbo.[SalesProductTransactionalFact]

		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			TRUNCATE TABLE TEMPTABLE2
			INSERT INTO TEMPTABLE2 
			SELECT  O.[Order ID],O.[Employee ID],O.[Customer ID],O.[Order Date],
			O.[Shipped Date],O.[Shipper ID],O.[Payment Type],O.[Paid Date],
			OD.[Product ID],[Quantity],OD.[Discount],OD.[Status ID],OD.[Date Allocated],
			O.[Ship Address],O.[Ship City],O.[Ship State/Province],
			O.[Ship ZIP/Postal Code],O.[Ship Country/Region]
			FROM 
			(
				SELECT [Order ID],[Employee ID],[Customer ID],[Order Date],
				[Shipped Date],[Shipper ID],[Payment Type],[Paid Date],
				[Status ID],[Ship Address],[Ship City],[Ship State/Province],
				[Ship ZIP/Postal Code],[Ship Country/Region]
				FROM [NorthWindStorageArea].dbo.[Orders]
				WHERE [Order Date] = @CurrentDate
			) AS O
			INNER JOIN 
			(
				SELECT [Order ID], [Product ID], [Status ID], [Quantity], [Discount], [Date Allocated]
				FROM [NorthWindStorageArea].dbo.[Order Details] 
			)AS OD
			ON OD.[Order ID] = O.[Order ID]

			SET @RowNum = (	SELECT COUNT([Order ID]) FROM TEMPTABLE2);

			DELETE NorthWindDataWarehouse.dbo.[SalesProductTransactionalFact]
			WHERE [OrderDateKey] = dbo.GetTimeKeyFunction(@CurrentDate)

			SET @i=0;
			WHILE @i < @RowNum
			BEGIN
				SELECT	@OrderID = [Order ID],
						@EmployeeID = [Employee ID],
						@CustomerID = [Customer ID],
						@ShipperID = [Shipper ID], 
						@OrderDate = [Order Date], 
						@ShippedDate = [Shipped Date],
						@PaidDate = [Paid Date],
						@StatusID = [Status ID],
						@PaymentType = [Payment Type],
						@ProductID = [Product ID],
						@DateAllocated = [Date Allocated],
						@Quantity = [Quantity],
						@Discount = [Discount],
						@ShipAddress = [Ship Address],
						@ShipCity = [Ship City],
						@ShipProvince = [Ship State/Province],
						@ShipPostalCode = [Ship ZIP/Postal Code],
						@ShipRegion = [Ship Country/Region]

				FROM TEMPTABLE2
				ORDER BY [Order Date],[Order ID]
				OFFSET @i ROWS
				FETCH NEXT 1 ROWS ONLY;

				SET @OrderDateKey = dbo.GetTimeKeyFunction(@OrderDate) 
				SET @ShippedDateKey = dbo.GetTimeKeyFunction(@ShippedDate)
				SET @PaidDateKey = dbo.GetTimeKeyFunction(@PaidDate)
				SET @DateAllocatedKey = dbo.GetTimeKeyFunction(@DateAllocated)

				SET @EmployeeKey = (SELECT [EmployeeKey] FROM NorthWindDataWarehouse.dbo.[EmployeeDim] WHERE [ID] = @EmployeeID AND [Current Flag] = '1')
				SET @ProductKey = (SELECT [ProductKey] FROM NorthWindDataWarehouse.dbo.[ProductDim] WHERE [ID] = @ProductID AND [Current Flag] = '1')
				SET @PaymentMethodKey = (SELECT ID FROM NorthWindDataWarehouse.dbo.PaymentMethodDim WHERE @PaymentType = [Description])
				SET @LocationKey = (SELECT ID FROM NorthWindDataWarehouse.dbo.LocationDim 
									WHERE @ShipAddress = [Address] AND @ShipCity = [City] AND @ShipProvince = [State/Province] AND
									@ShipPostalCode = [ZIP/Postal Code] AND @ShipRegion = [Country/Region])

				INSERT INTO NorthWindDataWarehouse.dbo.[SalesProductTransactionalFact]
				VALUES (
						ISNULL(@ProductKey, -1),ISNULL(@ProductID, -1),ISNULL(@EmployeeKey, -1),ISNULL(@EmployeeID, -1),ISNULL(@CustomerID, -1),
						ISNULL(@ShipperID, -1),ISNULL(@OrderDateKey, -1),ISNULL(@ShippedDateKey, -1),ISNULL(@DateAllocatedKey, -1),ISNULL(@PaidDateKey, -1),
						ISNULL(@StatusID, -1),ISNULL(@PaymentMethodKey, -1),ISNULL(@LocationKey, -1),ISNULL(@Quantity, 0),ISNULL(@Discount, 0)
					   )

				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
		END
		DROP TABLE TEMPTABLE2
	END
	GO
	CREATE PROCEDURE dbo.SalesOrdersDailyFact_LoadProcedure(@MinDate Date, @MaxDate Date, @FirstLoad Bit)
	AS
	BEGIN
		DECLARE @i [int]
		DECLARE @CustomerNum [int]
		DECLARE	@CustomerKey [int] 
		DECLARE @TotalShippingFee [money]
		DECLARE @TotalTaxes [money]
		DECLARE @AverageTaxRate [float]
		DECLARE @TotalOrderNumbers [bigint]
		DECLARE @TotalShippedNumbers [bigint]
		DECLARE @TotalPaidNumbers [bigint]
		DECLARE @TotalPaymentAmount [money]
		DECLARE @CurrentDate [Date]
		DECLARE @CurrentDateKey [int]

		IF @FirstLoad = 1
			TRUNCATE TABLE NorthWindDataWarehouse.dbo.[SalesOrdersDailyFact]

		SET @CustomerNum = (SELECT COUNT(*) FROM NorthWindDataWarehouse.dbo.[CustomerDim]);
		
		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			SET @CurrentDateKey = dbo.GetTimeKeyFunction(@CurrentDate)
			DELETE NorthWindDataWarehouse.dbo.[SalesOrdersDailyFact]
			WHERE [DateKey] = @CurrentDateKey
			SET @i=0;
			WHILE @i < @CustomerNum
			BEGIN
				SELECT @CustomerKey = [ID]
				FROM NorthWindDataWarehouse.dbo.[CustomerDim]
				ORDER BY [ID]
				OFFSET @i ROWS
				FETCH NEXT 1 ROWS ONLY;
				
				SELECT  @TotalShippingFee = SUM([ShippingFee]),
						@TotalTaxes = SUM([Taxes]),
						@TotalPaymentAmount = SUM([PaymentAmount]),
						@TotalOrderNumbers = COUNT(*),
						@AverageTaxRate = AVG([TaxRate])
				FROM NorthWindDataWarehouse.dbo.[SalesOrdersTransactionalFact] 
				WHERE [CustomerKey] = @CustomerKey AND [OrderDateKey] = @CurrentDateKey

				SELECT @TotalShippedNumbers = COUNT(*)
				FROM NorthWindDataWarehouse.dbo.[SalesOrdersTransactionalFact] 
				WHERE [CustomerKey] = @CustomerKey AND [ShippedDateKey] = @CurrentDateKey

				SELECT @TotalPaidNumbers = COUNT(*)
				FROM NorthWindDataWarehouse.dbo.[SalesOrdersTransactionalFact] 
				WHERE [CustomerKey] = @CustomerKey AND [PaidDateKey] = @CurrentDateKey

				INSERT INTO NorthWindDataWarehouse.dbo.[SalesOrdersDailyFact] VALUES
				(
					@CustomerKey,@CurrentDateKey,ISNULL(@TotalShippingFee, 0),ISNULL(@TotalTaxes, 0),ISNULL(@AverageTaxRate, 0),
					ISNULL(@TotalOrderNumbers, 0),ISNULL(@TotalShippedNumbers, 0),ISNULL(@TotalPaidNumbers, 0),ISNULL(@TotalPaymentAmount, 0)
				)

				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
		END
	END
	GO
	CREATE PROCEDURE dbo.SalesProductsDailyFact_LoadProcedure(@MinDate Date, @MaxDate Date, @FirstLoad Bit)
	AS
	BEGIN
		DECLARE @i [int]
		DECLARE @j [int]
		DECLARE @EmployeeNum [int]
		DECLARE @ProductNum [int]
		DECLARE @RowNum [int]
		DECLARE	@EmployeeKey [int] 
		DECLARE @ProductKey [int]
		DECLARE @ProductNaturalKey [int]
		DECLARE @EmployeeNaturalKey [int]
		DECLARE @StandardCost [money]
		DECLARE @TotalSaleQuantity [float]
		DECLARE @MaxSaleQuantity [float]
		DECLARE @MinSaleQuantity [float]
		DECLARE @MinDiscount [float]
		DECLARE @MaxDiscount [float]
		DECLARE @TotalPrice [money]
		DECLARE @ListPrice [money]
		DECLARE @CurrentDate [Date]
		DECLARE @CurrentDateKey [int]

		IF @FirstLoad = 1
			TRUNCATE TABLE NorthWindDataWarehouse.dbo.[SalesProductsDailyFact]

		SET @EmployeeNum = (SELECT COUNT(*) FROM NorthWindDataWarehouse.dbo.[EmployeeDim] WHERE [Current Flag] = '1');
		SET @ProductNum = (SELECT COUNT(*) FROM NorthWindDataWarehouse.dbo.[ProductDim] WHERE [Current Flag] = '1');
		
		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			SET @CurrentDateKey = dbo.GetTimeKeyFunction(@CurrentDate)
			DELETE NorthWindDataWarehouse.dbo.[SalesProductsDailyFact]
			WHERE [DateKey] = @CurrentDateKey
			SET @i = 0;
			WHILE @i < @EmployeeNum
			BEGIN
				SELECT	@EmployeeKey = [EmployeeKey], @EmployeeNaturalKey = [ID]
				FROM NorthWindDataWarehouse.dbo.[EmployeeDim]
				WHERE [Current Flag] = '1'
				ORDER BY [ID]
				OFFSET @i ROWS
				FETCH NEXT 1 ROWS ONLY;
				SET @j = 0;
				WHILE @j < @ProductNum
				BEGIN	
					SELECT	@ProductKey = [ProductKey], @ProductNaturalKey = [ID], @ListPrice = [List Price] 
					FROM NorthWindDataWarehouse.dbo.[ProductDim]
					WHERE [Current Flag] = '1'
					ORDER BY [ProductKey]
					OFFSET @j ROWS
					FETCH NEXT 1 ROWS ONLY;

					WITH TEMP ([Quantity],[Discount],[OrderDateKey]) 
					AS
					(
					SELECT [Quantity],[Discount],[OrderDateKey]
					FROM NorthWindDataWarehouse.dbo.[SalesProductTransactionalFact]
					WHERE [ProductKey] = @ProductKey AND [EmployeeKey] = @EmployeeKey
					)
					SELECT @TotalSaleQuantity = SUM([Quantity]),
						   @MinSaleQuantity = MIN([Quantity]),
						   @MaxSaleQuantity = MAX([Quantity]),
						   @MinDiscount = MIN([Discount]),
						   @MaxDiscount = MAX([Discount]),
						   @TotalPrice = SUM([Quantity]) * @ListPrice

					FROM TEMP 
					WHERE [OrderDateKey] = @CurrentDateKey

					INSERT INTO NorthWindDataWarehouse.dbo.[SalesProductsDailyFact] VALUES
					(
					 @ProductKey,@ProductNaturalKey,@EmployeeKey,@EmployeeNaturalKey,@CurrentDateKey,
					 ISNULL(@TotalSaleQuantity, 0),ISNULL(@MaxSaleQuantity, 0),ISNULL(@MinSaleQuantity, 0),
					 ISNULL(@MinDiscount, 0),ISNULL(@MaxDiscount, 0),ISNULL(@TotalPrice, 0)
					)
					SET @j = @j + 1
				END
				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
		END
	END
	GO	
	CREATE PROCEDURE dbo.SalesOrderAccFact_LoadProcedure(@MinDate Date, @MaxDate Date, @FirstLoad Bit)
	AS
	BEGIN
		DECLARE @i [int]
		DECLARE @RowNum [int]
		DECLARE @DateKey [int]
		DECLARE	@CustomerKey [int] 
		DECLARE @TotalShippingFee [money]
		DECLARE @TotalTaxes [money]
		DECLARE @TotalOrderNumbers [bigint]
		DECLARE @TotalShippedNumbers [bigint] 
		DECLARE @TotalPaidNumbers [bigint]
		DECLARE @TotalExpectedNumbers [bigint] 
		DECLARE @TotalPaymentAmount [money]
		DECLARE @AverageTaxRate [float]
		DECLARE @FirstOrderDate [Date] 
		DECLARE @LastOrderDate [Date] 
		DECLARE @TotalOrderNumbers_Daily [bigint]
		DECLARE @TotalShippedNumbers_Daily [bigint]
		DECLARE @TotalPaidNumbers_Daily [bigint]
		DECLARE @TotalShippingFee_Daily [money]
		DECLARE @TotalTaxes_Daily [money]
		DECLARE @TotalPaymentAmount_Daily [money]
		DECLARE @AverageTaxRate_Daily [float]
		DECLARE @CurrentDate [Date]
		DECLARE @CurrentDateKey [int]
		
		IF @FirstLoad = 1
			TRUNCATE TABLE NorthWindDataWarehouse.dbo.[SalesOrderAccFact]

		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			SET @CurrentDateKey = dbo.GetTimeKeyFunction(@CurrentDate)
			SET @RowNum = (SELECT COUNT(*) FROM NorthWindDataWarehouse.dbo.[SalesOrdersDailyFact] WHERE [DateKey] = @CurrentDateKey)
			SET @i = 0
			WHILE @i < @RowNum
			BEGIN
				SELECT	@CustomerKey = [CustomerKey],
						@DateKey = [DateKey],
						@TotalOrderNumbers_Daily = [TotalOrderNumbers],
						@TotalShippedNumbers_Daily = [TotalShippedNumbers],
						@TotalPaidNumbers_Daily = [TotalPaidNumbers],
						@TotalShippingFee_Daily = [TotalShippingFee],
						@TotalTaxes_Daily = [TotalTaxes],
						@TotalPaymentAmount_Daily = [TotalPaymentAmount],
						@AverageTaxRate_Daily = [AverageTaxRate]

				FROM NorthWindDataWarehouse.dbo.[SalesOrdersDailyFact]
				WHERE [DateKey] = @CurrentDateKey
				ORDER BY [CustomerKey]
				OFFSET @i ROWS
				FETCH NEXT 1 ROWS ONLY;

				SET @TotalOrderNumbers = '-1'
				SELECT @TotalShippingFee = [TotalShippingFee],
					   @TotalTaxes = [TotalTaxes],
					   @TotalPaymentAmount = [TotalPaymentAmount],
					   @TotalOrderNumbers = [TotalOrderNumbers],
					   @TotalPaidNumbers = [TotalPaidNumbers],
					   @TotalShippedNumbers = [TotalShippedNumbers],
					   @AverageTaxRate = [AverageTaxRate],
					   @FirstOrderDate = [FirstOrderDate],
					   @LastOrderDate = [LastOrderDate]

				FROM NorthWindDataWarehouse.dbo.[SalesOrderAccFact]
				WHERE [CustomerKey] = @CustomerKey

				IF @TotalOrderNumbers = '-1'
				BEGIN
					INSERT INTO NorthWindDataWarehouse.dbo.[SalesOrderAccFact] VALUES
					(
					 @CustomerKey,@TotalShippingFee_Daily,@TotalTaxes_Daily,
					 @AverageTaxRate_Daily,@TotalOrderNumbers_Daily,@TotalShippedNumbers_Daily,
					 @TotalPaidNumbers_Daily,@TotalPaymentAmount_Daily,
					 CASE WHEN @TotalOrderNumbers_Daily <> 0 THEN @CurrentDate ELSE NULL END,
					 CASE WHEN @TotalOrderNumbers_Daily <> 0 THEN @CurrentDate ELSE NULL END
					)
				END
				ELSE
				BEGIN
					DELETE NorthWindDataWarehouse.dbo.[SalesOrderAccFact]
					WHERE [CustomerKey] = @CustomerKey

					INSERT INTO NorthWindDataWarehouse.dbo.[SalesOrderAccFact] VALUES
					(
					 @CustomerKey,
					 @TotalShippingFee_Daily + @TotalShippingFee,
					 @TotalTaxes_Daily + @TotalTaxes,
					 ((@AverageTaxRate_Daily * @TotalOrderNumbers_Daily) + (@AverageTaxRate * @TotalOrderNumbers)) 
					 / (@TotalOrderNumbers_Daily + @TotalOrderNumbers),
					 @TotalOrderNumbers_Daily + @TotalOrderNumbers,
					 @TotalShippedNumbers_Daily + @TotalShippedNumbers,
					 @TotalPaidNumbers_Daily + @TotalPaidNumbers,
					 @TotalPaymentAmount_Daily + @TotalPaymentAmount,
					 CASE WHEN @FirstOrderDate IS NOT NULL THEN @FirstOrderDate
						  WHEN @FirstOrderDate IS NULL AND @TotalOrderNumbers_Daily <> 0 THEN @CurrentDate
						  ELSE NULL END,
					 CASE WHEN @TotalOrderNumbers_Daily <> 0 THEN @CurrentDate ELSE @LastOrderDate END
					)
				END
				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
		END
	END
	GO
	CREATE PROCEDURE dbo.SalesProductsAccFact_LoadProcedure(@MinDate Date, @MaxDate Date, @FirstLoad Bit)
	AS
	BEGIN
		DECLARE @i [int]
		DECLARE @RowNum [int]
		DECLARE @DateKey [int]
		DECLARE	@EmployeeKey [int] 
		DECLARE @ProductKey [int]
		DECLARE @ProductNaturalKey [int]
		DECLARE @EmployeeNaturalKey [int]
		DECLARE @TotalSaleQuantity_Daily [float]
		DECLARE @TotalPrice_Daily [money]
		DECLARE @MinSaleQuantity_Daily [float]
		DECLARE @MaxSaleQuantity_Daily [float] 
		DECLARE @MinDiscountRate_Daily [float]
		DECLARE @MaxDiscountRate_Daily [float] 
		DECLARE @TotalSaleQuantity [float]
		DECLARE @TotalPrice [money]
		DECLARE @MinSaleQuantity [float]
		DECLARE @MaxSaleQuantity [float] 
		DECLARE @MinDiscountRate [float]
		DECLARE @MaxDiscountRate [float] 
		DECLARE @FirstSaleDate [Date] 
		DECLARE @LastSaleDate [Date] 
		DECLARE @CurrentDate [Date]
		DECLARE @CurrentDateKey [int]
		
		IF @FirstLoad = 1
			TRUNCATE TABLE NorthWindDataWarehouse.dbo.[SalesProductsAccFact]

		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			SET @CurrentDateKey = dbo.GetTimeKeyFunction(@CurrentDate)
			SET @RowNum = (SELECT COUNT(*) FROM NorthWindDataWarehouse.dbo.[SalesProductsDailyFact] WHERE [DateKey] = @CurrentDateKey)
			SET @i = 0;
			WHILE @i < @RowNum
			BEGIN
				SELECT	@EmployeeKey = [EmployeeKey],
						@ProductKey = [ProductKey],
						@ProductNaturalKey = [ProductNaturalKey],
						@EmployeeNaturalKey = [EmployeeNaturalKey],
						@DateKey = [DateKey],
						@TotalSaleQuantity_Daily = [TotalSaleQuantity],
						@TotalPrice_Daily = [TotalPrice],
						@MinSaleQuantity_Daily = [MinSaleQuantity],
						@MaxSaleQuantity_Daily = [MaxSaleQuantity],
						@MinDiscountRate_Daily = [MinDiscountRate],
						@MaxDiscountRate_Daily = [MaxDiscountRate]
			
				FROM NorthWindDataWarehouse.dbo.[SalesProductsDailyFact]
				WHERE [DateKey] = @CurrentDateKey
				ORDER BY [EmployeeKey],[ProductKey]
				OFFSET @i ROWS
				FETCH NEXT 1 ROWS ONLY;

				SET @TotalSaleQuantity = '-1'
				SELECT  @TotalSaleQuantity = [TotalSaleQuantity],
						@TotalPrice = [TotalPrice],
						@MinSaleQuantity = [MinSaleQuantity],
						@MaxSaleQuantity = [MaxSaleQuantity],
						@MinDiscountRate = [MinDiscountRate],
						@MaxDiscountRate = [MaxDiscountRate],
						@FirstSaleDate = [FirstSaleDate],
						@LastSaleDate = [LastSaleDate]
						
				FROM NorthWindDataWarehouse.dbo.[SalesProductsAccFact]
				WHERE [EmployeeKey] = @EmployeeKey AND [ProductKey] = @ProductKey

				IF @TotalSaleQuantity = '-1'
				BEGIN
					INSERT INTO NorthWindDataWarehouse.dbo.[SalesProductsAccFact] VALUES
					(
					 @ProductKey,@ProductNaturalKey,@EmployeeKey,@EmployeeNaturalKey,
					 @TotalSaleQuantity_Daily,@MaxSaleQuantity_Daily,@MinSaleQuantity_Daily,
					 @MinDiscountRate_Daily,@MaxDiscountRate_Daily,
					 @TotalPrice_Daily,
					 CASE WHEN @TotalSaleQuantity_Daily <> 0 THEN @CurrentDate ELSE NULL END,
					 CASE WHEN @TotalSaleQuantity_Daily <> 0 THEN @CurrentDate ELSE NULL END
					)
				END
				ELSE
				BEGIN
					DELETE NorthWindDataWarehouse.dbo.[SalesProductsAccFact]
					WHERE [EmployeeKey] = @EmployeeKey AND [ProductKey] = @ProductKey 

					INSERT INTO NorthWindDataWarehouse.dbo.[SalesProductsAccFact] VALUES
					(
					 @ProductKey,@ProductNaturalKey,@EmployeeKey,@EmployeeNaturalKey,
					 @TotalSaleQuantity_Daily + @TotalSaleQuantity,
					 CASE WHEN @MaxSaleQuantity_Daily > @MaxSaleQuantity THEN @MaxSaleQuantity_Daily ELSE @MaxSaleQuantity END,
					 CASE WHEN @MinSaleQuantity_Daily < @MinSaleQuantity THEN @MinSaleQuantity_Daily ELSE @MinSaleQuantity END,
					 CASE WHEN @MinDiscountRate_Daily < @MinDiscountRate THEN @MinDiscountRate_Daily ELSE @MinDiscountRate END,
					 CASE WHEN @MaxDiscountRate_Daily > @MaxDiscountRate THEN @MaxDiscountRate_Daily ELSE @MaxDiscountRate END,
					 @TotalPrice_Daily + @TotalPrice,
					 CASE WHEN @FirstSaleDate IS NOT NULL THEN @FirstSaleDate
						  WHEN @FirstSaleDate IS NULL AND @TotalSaleQuantity_Daily <> 0 THEN @CurrentDate
						  ELSE NULL END,
					 CASE WHEN @TotalSaleQuantity_Daily <> 0 THEN @CurrentDate ELSE @LastSaleDate END
					)
				END
				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
		END
	END
	GO
	CREATE PROCEDURE dbo.EmployeeSalaryTransactionalFact_LoadProcedure(@MinDate Date, @MaxDate Date, @FirstLoad Bit)
	AS
	BEGIN
		DECLARE @i [int]
		DECLARE @RowNum [int]
		DECLARE @PaymentDateKey [int]
		DECLARE @PaymentMethodKey [int]
		DECLARE @EmployeeKey [int]
		DECLARE @CheckKey [int]
		DECLARE @BaseSalary [money]
		DECLARE @OvertimePaid [money]
		DECLARE @PerformanceBonus [money]
		DECLARE @IncentiveAllowance [money]
		DECLARE	@EmployeeID [int]
		DECLARE	@PaymentDate [Date]
		DECLARE	@PaymentMethod [nvarchar](60)
		DECLARE @CurrentDate [Date]
		DECLARE @CurrentDateKey [int]

		IF @FirstLoad = 1
			TRUNCATE TABLE NorthWindDataWarehouse.dbo.[EmployeeSalaryTransactionalFact]

		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			SET @CurrentDateKey = dbo.GetTimeKeyFunction(@CurrentDate)
			DELETE NorthWindDataWarehouse.dbo.[EmployeeSalaryTransactionalFact]
			WHERE [PaymentDateKey] = @CurrentDateKey
			SET @RowNum = (	SELECT COUNT(*) 
							FROM [NorthWindStorageArea].dbo.[EmployeeSalary] 
							WHERE [PaymentDate] = @CurrentDate
						  );
			SET @i=0;
			WHILE @i < @RowNum
			BEGIN
				SELECT  @EmployeeID = [EmployeeID],
						@BaseSalary = [BaseSalary],
						@OvertimePaid = [OvertimePaid],
						@PerformanceBonus = [PerformanceBonus],
						@IncentiveAllowance = [IncentiveAllowance],
						@PaymentDate = [PaymentDate],
						@PaymentMethod = [PaymentMethod],
						@CheckKey = [Check ID]

				FROM [NorthWindStorageArea].dbo.[EmployeeSalary]
				WHERE [PaymentDate] = @CurrentDate
				ORDER BY [PaymentDate],[EmployeeID]
				OFFSET @i ROWS
				FETCH NEXT 1 ROWS ONLY;
				
				SET @PaymentDateKey = dbo.GetTimeKeyFunction(@PaymentDate)
				SET @EmployeeKey = (SELECT [EmployeeKey] FROM NorthWindDataWarehouse.dbo.[EmployeeDim] WHERE [ID] = @EmployeeID AND [Current Flag] = '1')
				SET @PaymentMethodKey = (SELECT ID FROM NorthWindDataWarehouse.dbo.PaymentMethodDim WHERE @PaymentMethod = [Description]);
				
				INSERT INTO NorthWindDataWarehouse.dbo.[EmployeeSalaryTransactionalFact]
				VALUES (
						ISNULL(@PaymentDateKey,-1), ISNULL(@PaymentMethodKey, -1), ISNULL(@EmployeeKey, -1), ISNULL(@EmployeeID, -1), ISNULL(@CheckKey,-1),
						ISNULL(@BaseSalary, 0), ISNULL(@OvertimePaid, 0), ISNULL(@PerformanceBonus, 0), ISNULL(@IncentiveAllowance, 0)
					   )
				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
		END
	END
	GO
	CREATE PROCEDURE dbo.EmployeeSalaryYearyFact_LoadProcedure(@MinDate Date, @MaxDate Date, @FirstLoad Bit)
	AS
	BEGIN
		DECLARE @i [int]
		DECLARE @j [int]
		DECLARE @MethodNum [int]
		DECLARE @EmployeeNum [int]
		DECLARE @PaymentDateKey [int]
		DECLARE @PaymentMethodKey [int]
		DECLARE @EmployeeKey [int]
		DECLARE @EmployeeNaturalKey [int]
		DECLARE @TotalBaseSalaryPaid [money]
		DECLARE @TotalOvertimePaid [money]
		DECLARE @TotalPerformanceBonusPaid [money]
		DECLARE @TotalIncentiveAllowancePaid [money]
		DECLARE @CurrentDate [Date]
		DECLARE @CurrentDateKey [int]

		IF @FirstLoad = 1
			TRUNCATE TABLE NorthWindDataWarehouse.dbo.[EmployeeSalaryYearyFact]

		SET @EmployeeNum = (SELECT COUNT(*) FROM NorthWindDataWarehouse.dbo.[EmployeeDim]);
		SET @MethodNum = (SELECT COUNT(*) FROM NorthWindDataWarehouse.dbo.[PaymentMethodDim]);
		
		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			SET @CurrentDateKey = dbo.GetTimeKeyFunction(@CurrentDate)
			SET @i=0;
			WHILE @i < @EmployeeNum
			BEGIN
				SELECT	@EmployeeKey = [EmployeeKey], @EmployeeNaturalKey = [ID]
				FROM NorthWindDataWarehouse.dbo.[EmployeeDim]
				ORDER BY [EmployeeKey]
				OFFSET @i ROWS
				FETCH NEXT 1 ROWS ONLY;
				SET @j=0;
				WHILE @j < @MethodNum
				BEGIN	
					SELECT @PaymentMethodKey = [ID]
					FROM NorthWindDataWarehouse.dbo.[PaymentMethodDim]
					ORDER BY [ID]
					OFFSET @j ROWS
					FETCH NEXT 1 ROWS ONLY;
					
					WITH TEMP ([BaseSalary], [OvertimePaid], [PerformanceBonus], [IncentiveAllowance], [PaymentDateKey])
					AS
					(
						SELECT [BaseSalary], [OvertimePaid], [PerformanceBonus],[IncentiveAllowance], [PaymentDateKey]
						FROM NorthWindDataWarehouse.dbo.[EmployeeSalaryTransactionalFact]
						WHERE [EmployeeKey] = @EmployeeKey AND [PaymentMethodKey] = @PaymentMethodKey
					)
					SELECT @TotalBaseSalaryPaid = SUM([BaseSalary]),
							@TotalOvertimePaid = SUM([OvertimePaid]),
							@TotalPerformanceBonusPaid = SUM([PerformanceBonus]),
							@TotalIncentiveAllowancePaid = SUM([IncentiveAllowance])
					FROM TEMP 
					WHERE YEAR(dbo.GetDateFunction([PaymentDateKey])) = YEAR(@CurrentDate);
					
					INSERT INTO NorthWindDataWarehouse.dbo.[EmployeeSalaryYearyFact] VALUES
					(
						@CurrentDateKey, @PaymentMethodKey, @EmployeeKey, @EmployeeNaturalKey, ISNULL(@TotalBaseSalaryPaid, 0),
						ISNULL(@TotalOvertimePaid, 0), ISNULL(@TotalPerformanceBonusPaid, 0), ISNULL(@TotalIncentiveAllowancePaid, 0)
					)
					
					SET @j = @j + 1
				END
				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(YEAR, 1, @CurrentDate)
		END
	END
	GO
	CREATE PROCEDURE dbo.EmployeeSalaryAccFact_LoadProcedure(@MinDate Date, @MaxDate Date, @FirstLoad Bit)
	AS
	BEGIN
		DECLARE @i [int]
		DECLARE @j [int]
		DECLARE @MethodNum [int]
		DECLARE @EmployeeNum [int]
		DECLARE @RowNum [int]
		DECLARE @PaymentMethodKey [int]
		DECLARE @EmployeeKey [int]
		DECLARE @EmployeeNaturalKey [int]
		DECLARE @PaymentDateKey [int]
		DECLARE @TotalBaseSalary [money]
		DECLARE @TotalOvertimePaid [money]
		DECLARE @TotalPerformanceBonus [money]
		DECLARE @TotalIncentiveAllowance [money]
		DECLARE @MinOverTimePaid [money]
		DECLARE @MaxOverTimePaid [money]
		DECLARE @MinPerformanceBonus [money]
		DECLARE @MaxPerformanceBonus [money]
		DECLARE @TotalBaseSalary_daily [money]
		DECLARE @TotalOvertimePaid_daily [money]
		DECLARE @TotalPerformanceBonus_daily [money]
		DECLARE @TotalIncentiveAllowance_daily [money]
		DECLARE @MinOverTimePaid_daily [money]
		DECLARE @MaxOverTimePaid_daily [money]
		DECLARE @MinPerformanceBonus_daily [money]
		DECLARE @MaxPerformanceBonus_daily [money]
		DECLARE @CurrentDate [Date]
		DECLARE @CurrentDateKey [int]

		IF @FirstLoad = 1
			TRUNCATE TABLE NorthWindDataWarehouse.dbo.[EmployeeSalaryAccFact]
		
		SET @EmployeeNum = (SELECT COUNT(*) FROM NorthWindDataWarehouse.dbo.[EmployeeDim]);
		SET @MethodNum = (SELECT COUNT(*) FROM NorthWindDataWarehouse.dbo.[PaymentMethodDim]);
		
		SET @CurrentDate = DATEADD(DAY, 1, @MinDate)
		WHILE @CurrentDate <= @MaxDate
		BEGIN
			SET @CurrentDateKey = dbo.GetTimeKeyFunction(@CurrentDate)
			SET @i=0;
			WHILE @i < @EmployeeNum
			BEGIN
				SELECT	@EmployeeKey = [EmployeeKey], @EmployeeNaturalKey = [ID]
				FROM NorthWindDataWarehouse.dbo.[EmployeeDim]
				ORDER BY [EmployeeKey]
				OFFSET @i ROWS
				FETCH NEXT 1 ROWS ONLY;
				SET @j=0;
				WHILE @j < @MethodNum
				BEGIN	
					SELECT @PaymentMethodKey = [ID]
					FROM NorthWindDataWarehouse.dbo.[PaymentMethodDim]
					ORDER BY [ID]
					OFFSET @j ROWS
					FETCH NEXT 1 ROWS ONLY;

					SELECT  @PaymentDateKey = [PaymentDateKey],
							@TotalBaseSalary_daily = [BaseSalary],
							@TotalOvertimePaid_daily = [OvertimePaid],
							@TotalPerformanceBonus_daily = [PerformanceBonus] ,
							@TotalIncentiveAllowance_daily = [IncentiveAllowance]
		
					FROM NorthWindDataWarehouse.dbo.[EmployeeSalaryTransactionalFact]
					WHERE [PaymentDateKey] = @CurrentDateKey AND [EmployeeKey] = @EmployeeKey
					ORDER BY [EmployeeKey],[PaymentMethodKey]
					OFFSET @i ROWS
					FETCH NEXT 1 ROWS ONLY;

					SET @TotalBaseSalary = '-1'
					SELECT  @TotalBaseSalary = [TotalBaseSalary],
							@TotalOvertimePaid = [TotalOvertimePaid],
							@TotalPerformanceBonus = [TotalPerformanceBonus],
							@TotalIncentiveAllowance = [TotalIncentiveAllowance],
							@MinOverTimePaid = [MinOverTimePaid],
							@MaxOverTimePaid = [MaxOverTimePaid],
							@MinPerformanceBonus = [MinPerformanceBonus],
							@MaxPerformanceBonus = [MaxPerformanceBonus]

					FROM NorthWindDataWarehouse.dbo.[EmployeeSalaryAccFact]
					WHERE [EmployeeKey] = @EmployeeKey AND [PaymentMethodKey] = @PaymentMethodKey

					IF @TotalBaseSalary = '-1'
					BEGIN
						INSERT INTO NorthWindDataWarehouse.dbo.[EmployeeSalaryAccFact] VALUES
						(
							@PaymentMethodKey, @EmployeeKey, @EmployeeNaturalKey, @TotalBaseSalary_daily,
							@TotalOvertimePaid_daily, @TotalPerformanceBonus_daily, @TotalIncentiveAllowance_daily,
							@TotalOvertimePaid_daily, @TotalOvertimePaid_daily,
							@TotalPerformanceBonus_daily, @MinPerformanceBonus_daily
						)
					END
					ELSE
					BEGIN
						DELETE NorthWindDataWarehouse.dbo.[EmployeeSalaryAccFact]
						WHERE [EmployeeKey] = @EmployeeKey AND [PaymentMethodKey] = @PaymentMethodKey 

						INSERT INTO NorthWindDataWarehouse.dbo.[EmployeeSalaryAccFact] VALUES
						(
							@PaymentMethodKey, @EmployeeKey, @EmployeeNaturalKey,
							@TotalBaseSalary_daily + @TotalBaseSalary,
							@TotalOvertimePaid_daily + @TotalOvertimePaid,
							@TotalPerformanceBonus_daily + @TotalPerformanceBonus,
							@TotalIncentiveAllowance_daily + @TotalIncentiveAllowance,
							CASE WHEN @MinOverTimePaid_daily < @MinOverTimePaid THEN @MinOverTimePaid_daily ELSE @MinOverTimePaid END,
							CASE WHEN @MaxOverTimePaid_daily > @MaxOverTimePaid THEN @MaxOverTimePaid_daily ELSE @MaxOverTimePaid END,
							CASE WHEN @MinPerformanceBonus_daily < @MinPerformanceBonus THEN @MinPerformanceBonus_daily ELSE @MinPerformanceBonus END,
							CASE WHEN @MaxPerformanceBonus_daily > @MaxPerformanceBonus THEN @MaxPerformanceBonus_daily ELSE @MaxPerformanceBonus END
						)
					END
					SET @j = @j + 1
				END
				SET @i = @i + 1
			END
			SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
		END
	END
	GO
	CREATE PROCEDURE PurchaseMart_FillProcedure
	AS
	BEGIN
		DECLARE @MinDateKey [int]
		DECLARE @MaxDateKey [int]
		DECLARE @MinDate [Date]
		DECLARE @MaxDate [Date]

		SET @MinDateKey = (SELECT MIN(CreationDateKey) FROM NorthWindDataWarehouse.dbo.PurchaseOrdersTransactionalFact)
		SET @MaxDateKey = (SELECT MAX(CreationDateKey) FROM NorthWindDataWarehouse.dbo.PurchaseOrdersTransactionalFact)
		SET @MinDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MinDateKey)
		SET @MaxDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MaxDateKey)
		SET @MinDate = DATEADD(DAY, -10, @MinDate)
		SET @MaxDate = DATEADD(DAY, -10, @MaxDate)
		
		EXEC NorthWindDataWarehouse.dbo.PurchaseOrdersTransactionalFact_LoadProcedure @MinDate, @MaxDate, 0
		
		SET @MinDateKey = (SELECT MIN(CreationDateKey) FROM NorthWindDataWarehouse.dbo.PurchaseProductTransactionalFact)
		SET @MaxDateKey = (SELECT MAX(CreationDateKey) FROM NorthWindDataWarehouse.dbo.PurchaseProductTransactionalFact)
		SET @MinDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MinDateKey)
		SET @MaxDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MaxDateKey)
		SET @MinDate = DATEADD(DAY, -10, @MinDate)
		SET @MaxDate = DATEADD(DAY, -10, @MaxDate)

		EXEC NorthWindDataWarehouse.dbo.PurchaseProductTransactionalFact_LoadProcedure @MinDate, @MaxDate, 0

		SET @MinDateKey = (SELECT MIN(DateKey) FROM NorthWindDataWarehouse.dbo.PurchaseOrdersDailyFact)
		SET @MaxDateKey = (SELECT MAX(DateKey) FROM NorthWindDataWarehouse.dbo.PurchaseOrdersDailyFact)
		SET @MinDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MinDateKey)
		SET @MaxDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MaxDateKey)

		EXEC NorthWindDataWarehouse.dbo.PurchaseOrderDailyFact_LoadProcedure @MinDate, @MaxDate, 0
		EXEC NorthWindDataWarehouse.dbo.PurchaseOrderAccFact_LoadProcedure @MinDate, @MaxDate, 0
		
		SET @MinDateKey = (SELECT MIN(DateKey) FROM NorthWindDataWarehouse.dbo.PurchaseProductDailyFact)
		SET @MaxDateKey = (SELECT MAX(DateKey) FROM NorthWindDataWarehouse.dbo.PurchaseProductDailyFact)
		SET @MinDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MinDateKey)
		SET @MaxDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MaxDateKey)

		EXEC NorthWindDataWarehouse.dbo.PurchaseProductDailyFact_LoadProcedure @MinDate, @MaxDate, 0
		EXEC NorthWindDataWarehouse.dbo.PurchaseProductAccFact_LoadProcedure @MinDate, @MaxDate, 0

		SET @MinDateKey = (SELECT MIN(DateKey) FROM NorthWindDataWarehouse.dbo.[Employe'sPurchaseOrderDailyFact])
		SET @MaxDateKey = (SELECT MAX(DateKey) FROM NorthWindDataWarehouse.dbo.[Employe'sPurchaseOrderDailyFact])
		SET @MinDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MinDateKey)
		SET @MaxDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MaxDateKey)

		EXEC NorthWindDataWarehouse.dbo.[Employe'sPurchaseOrderDailyFact_LoadProcedure] @MinDate, @MaxDate, 0
		EXEC NorthWindDataWarehouse.dbo.[Employe'sPurchaseOrderAccFact_LoadProcedure] @MinDate, @MaxDate, 0
		
	END
	GO
	CREATE PROCEDURE SalesMart_FillProcedure
	AS
	BEGIN

		DECLARE @MinDateKey [int]
		DECLARE @MaxDateKey [int]
		DECLARE @MinDate [Date]
		DECLARE @MaxDate [Date]
		
		SET @MinDateKey = (SELECT MIN(OrderDateKey) FROM NorthWindDataWarehouse.dbo.SalesOrdersTransactionalFact)
		SET @MaxDateKey = (SELECT MAX(OrderDateKey) FROM NorthWindDataWarehouse.dbo.SalesOrdersTransactionalFact)
		SET @MinDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MinDateKey)
		SET @MaxDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MaxDateKey)
		SET @MinDate = DATEADD(DAY, -10, @MinDate)
		SET @MaxDate = DATEADD(DAY, -10, @MaxDate)

		EXEC NorthWindDataWarehouse.dbo.SalesOrdersTransactionalFact_LoadProcedure @MinDate, @MaxDate, 0
		
		SET @MinDateKey = (SELECT MIN(OrderDateKey) FROM NorthWindDataWarehouse.dbo.SalesProductTransactionalFact)
		SET @MaxDateKey = (SELECT MAX(OrderDateKey) FROM NorthWindDataWarehouse.dbo.SalesProductTransactionalFact)
		SET @MinDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MinDateKey)
		SET @MaxDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MaxDateKey)
		SET @MinDate = DATEADD(DAY, -10, @MinDate)
		SET @MaxDate = DATEADD(DAY, -10, @MaxDate)

		EXEC NorthWindDataWarehouse.dbo.SalesProductTransactionalFact_LoadProcedure @MinDate, @MaxDate, 0
		
		SET @MinDateKey = (SELECT MIN(DateKey) FROM NorthWindDataWarehouse.dbo.SalesOrdersDailyFact)
		SET @MaxDateKey = (SELECT MAX(DateKey) FROM NorthWindDataWarehouse.dbo.SalesOrdersDailyFact)
		SET @MinDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MinDateKey)
		SET @MaxDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MaxDateKey)

		EXEC NorthWindDataWarehouse.dbo.SalesOrdersDailyFact_LoadProcedure @MinDate, @MaxDate, 0
		EXEC NorthWindDataWarehouse.dbo.SalesOrderAccFact_LoadProcedure @MinDate, @MaxDate, 0
		
		SET @MinDateKey = (SELECT MIN(DateKey) FROM NorthWindDataWarehouse.dbo.SalesProductsDailyFact)
		SET @MaxDateKey = (SELECT MAX(DateKey) FROM NorthWindDataWarehouse.dbo.SalesProductsDailyFact)
		SET @MinDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MinDateKey)
		SET @MaxDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MaxDateKey)

		EXEC NorthWindDataWarehouse.dbo.SalesProductsDailyFact_LoadProcedure @MinDate, @MaxDate, 0
		EXEC NorthWindDataWarehouse.dbo.SalesProductsAccFact_LoadProcedure @MinDate, @MaxDate, 0

	END
	GO
	CREATE PROCEDURE SalaryMart_FillProcedure
	AS
	BEGIN

		DECLARE @MinDateKey [int]
		DECLARE @MaxDateKey [int]
		DECLARE @MinDate [Date]
		DECLARE @MaxDate [Date]
		
		SET @MinDateKey = (SELECT MIN(PaymentDateKey) FROM NorthWindDataWarehouse.dbo.EmployeeSalaryTransactionalFact)
		SET @MaxDateKey = (SELECT MAX(PaymentDateKey) FROM NorthWindDataWarehouse.dbo.EmployeeSalaryTransactionalFact)
		SET @MinDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MinDateKey)
		SET @MaxDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MaxDateKey)

		EXEC NorthWindDataWarehouse.dbo.EmployeeSalaryTransactionalFact_LoadProcedure @MinDate, @MaxDate, 0
		
		SET @MinDateKey = (SELECT MIN(PaymentDateKey) FROM NorthWindDataWarehouse.dbo.EmployeeSalaryYearyFact)
		SET @MaxDateKey = (SELECT MAX(PaymentDateKey) FROM NorthWindDataWarehouse.dbo.EmployeeSalaryYearyFact)
		SET @MinDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MinDateKey)
		SET @MaxDate = NorthWindDataWarehouse.dbo.GetDateFunction(@MaxDateKey)

		EXEC NorthWindDataWarehouse.dbo.EmployeeSalaryYearyFact_LoadProcedure @MinDate, @MaxDate, 0
		EXEC NorthWindDataWarehouse.dbo.EmployeeSalaryAccFact_LoadProcedure @MinDate, @MaxDate, 0
		
	END
	GO
	CREATE PROCEDURE Main_FactProcedure
	AS
	BEGIN
		EXEC PurchaseMart_FillProcedure
		EXEC SalesMart_FillProcedure
		EXEC SalaryMart_FillProcedure
	END


	/*
	-----------------------------------------------------
	select * from NorthWindDataWarehouse.dbo.SalesOrdersTransactionalFact
	order by OrderDateKey

	select * from NorthWindDataWarehouse.dbo.SalesOrdersDailyFact
	order by CustomerKey, DateKey

	select * from NorthWindDataWarehouse.dbo.SalesOrderAccFact
	order by CustomerKey
	-----------------------------------------------------
	select * from NorthWindDataWarehouse.dbo.SalesProductTransactionalFact
	order by OrderDateKey DESC

	select * from NorthWindDataWarehouse.dbo.SalesProductsDailyFact
	order by ProductKey,EmployeeKey, DateKey DESC

	select * from NorthWindDataWarehouse.dbo.SalesProductsAccFact
	order by ProductKey, EmployeeKey
	-----------------------------------------------------

	SELECT * FROM NorthWindDataWarehouse.DBO.PurchaseOrdersTransactionalFact
	ORDER BY CreationDateKey DESC

	SELECT * FROM NorthWindDataWarehouse.DBO.PurchaseOrdersDailyFact
	ORDER BY DateKey DESC

	SELECT * FROM NorthWindDataWarehouse.DBO.PurchaseOrderAccFact
	ORDER BY SupplierKey DESC

	-----------------------------------------------------

	SELECT * FROM NorthWindDataWarehouse.DBO.PurchaseProductTransactionalFact
	ORDER BY SupplierKey, ProductKey

	SELECT * FROM NorthWindDataWarehouse.DBO.PurchaseProductDailyFact
	ORDER BY DateKey DESC

	SELECT * FROM NorthWindDataWarehouse.DBO.PurchaseProductAccFact
	ORDER BY SupplierKey DESC
	-----------------------------------------------------

	SELECT * FROM NorthWindDataWarehouse.DBO.[Employe'sPurchaseOrderDailyFact]
	ORDER BY EmployeeKey ,DateKey

	SELECT * FROM NorthWindDataWarehouse.DBO.[Employe'sPurchaseOrderAccFact]
	ORDER BY EmployeeKey
	-----------------------------------------------------

	SELECT * FROM NorthWindDataWarehouse.DBO.EmployeeSalaryYearyFact

	SELECT * FROM NorthWindDataWarehouse.DBO.EmployeeSalaryTransactionalFact

	SELECT * FROM NorthWindDataWarehouse.DBO.EmployeeSalaryAccFact

	*/
