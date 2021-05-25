USE [Northwind2007]
GO

/****** Object:  Table [dbo].[Purchase Orders]    Script Date: 11/11/1399 12:04:27 Þ.Ù ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Purchase Orders](
	[Purchase Order ID] [int] IDENTITY(1,1) NOT NULL,
	[Supplier ID] [int] NULL,
	[Created By] [int] NULL,
	[Submitted Date] [datetime2](0) NULL,
	[Creation Date] [datetime2](0) NULL,
	[Status ID] [int] NULL,
	[Expected Date] [datetime2](0) NULL,
	[Shipping Fee] [money] NOT NULL,
	[Taxes] [money] NOT NULL,
	[Payment Date] [datetime2](0) NULL,
	[Payment Amount] [money] NULL,
	[Payment Method] [nvarchar](50) NULL,
	[Notes] [nvarchar](max) NULL,
	[Approved By] [int] NULL,
	[Approved Date] [datetime2](0) NULL,
	[Submitted By] [int] NULL,
	[Check ID] [int] NULL,
 CONSTRAINT [Purchase Orders$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[Purchase Order ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Purchase Orders] ADD  DEFAULT (getdate()) FOR [Creation Date]
GO

ALTER TABLE [dbo].[Purchase Orders] ADD  DEFAULT ((0)) FOR [Status ID]
GO

ALTER TABLE [dbo].[Purchase Orders] ADD  DEFAULT ((0)) FOR [Shipping Fee]
GO

ALTER TABLE [dbo].[Purchase Orders] ADD  DEFAULT ((0)) FOR [Taxes]
GO

ALTER TABLE [dbo].[Purchase Orders] ADD  DEFAULT ((0)) FOR [Payment Amount]
GO

ALTER TABLE [dbo].[Purchase Orders]  WITH NOCHECK ADD  CONSTRAINT [Purchase Orders$New_EmployeesOnPurchaseOrder] FOREIGN KEY([Created By])
REFERENCES [dbo].[Employees] ([ID])
GO

ALTER TABLE [dbo].[Purchase Orders] CHECK CONSTRAINT [Purchase Orders$New_EmployeesOnPurchaseOrder]
GO

ALTER TABLE [dbo].[Purchase Orders]  WITH NOCHECK ADD  CONSTRAINT [Purchase Orders$New_PurchaseOrderStatusLookup] FOREIGN KEY([Status ID])
REFERENCES [dbo].[Purchase Order Status] ([Status ID])
GO

ALTER TABLE [dbo].[Purchase Orders] CHECK CONSTRAINT [Purchase Orders$New_PurchaseOrderStatusLookup]
GO

ALTER TABLE [dbo].[Purchase Orders]  WITH NOCHECK ADD  CONSTRAINT [Purchase Orders$New_SuppliersOnPurchaseOrder] FOREIGN KEY([Supplier ID])
REFERENCES [dbo].[Suppliers] ([ID])
GO

ALTER TABLE [dbo].[Purchase Orders] CHECK CONSTRAINT [Purchase Orders$New_SuppliersOnPurchaseOrder]
GO

ALTER TABLE [dbo].[Purchase Orders]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Purchase Orders$Notes$disallow_zero_length] CHECK  ((len([Notes])>(0)))
GO

ALTER TABLE [dbo].[Purchase Orders] CHECK CONSTRAINT [SSMA_CC$Purchase Orders$Notes$disallow_zero_length]
GO

ALTER TABLE [dbo].[Purchase Orders]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Purchase Orders$Payment Method$disallow_zero_length] CHECK  ((len([Payment Method])>(0)))
GO

ALTER TABLE [dbo].[Purchase Orders] CHECK CONSTRAINT [SSMA_CC$Purchase Orders$Payment Method$disallow_zero_length]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Orders].[Purchase Order ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Orders', @level2type=N'COLUMN',@level2name=N'Purchase Order ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Orders].[Supplier ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Orders', @level2type=N'COLUMN',@level2name=N'Supplier ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Orders].[Created By]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Orders', @level2type=N'COLUMN',@level2name=N'Created By'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Orders].[Submitted Date]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Orders', @level2type=N'COLUMN',@level2name=N'Submitted Date'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Orders].[Creation Date]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Orders', @level2type=N'COLUMN',@level2name=N'Creation Date'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Orders].[Status ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Orders', @level2type=N'COLUMN',@level2name=N'Status ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Orders].[Expected Date]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Orders', @level2type=N'COLUMN',@level2name=N'Expected Date'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Orders].[Shipping Fee]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Orders', @level2type=N'COLUMN',@level2name=N'Shipping Fee'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Orders].[Taxes]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Orders', @level2type=N'COLUMN',@level2name=N'Taxes'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Orders].[Payment Date]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Orders', @level2type=N'COLUMN',@level2name=N'Payment Date'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Orders].[Payment Amount]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Orders', @level2type=N'COLUMN',@level2name=N'Payment Amount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Orders].[Payment Method]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Orders', @level2type=N'COLUMN',@level2name=N'Payment Method'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Orders].[Notes]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Orders', @level2type=N'COLUMN',@level2name=N'Notes'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Orders].[Approved By]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Orders', @level2type=N'COLUMN',@level2name=N'Approved By'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Orders].[Approved Date]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Orders', @level2type=N'COLUMN',@level2name=N'Approved Date'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Orders].[Submitted By]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Orders', @level2type=N'COLUMN',@level2name=N'Submitted By'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Orders].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Orders', @level2type=N'CONSTRAINT',@level2name=N'Purchase Orders$PrimaryKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Orders]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Orders'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Orders].[New_EmployeesOnPurchaseOrder]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Orders', @level2type=N'CONSTRAINT',@level2name=N'Purchase Orders$New_EmployeesOnPurchaseOrder'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Orders].[New_PurchaseOrderStatusLookup]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Orders', @level2type=N'CONSTRAINT',@level2name=N'Purchase Orders$New_PurchaseOrderStatusLookup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Orders].[New_SuppliersOnPurchaseOrder]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Orders', @level2type=N'CONSTRAINT',@level2name=N'Purchase Orders$New_SuppliersOnPurchaseOrder'
GO


