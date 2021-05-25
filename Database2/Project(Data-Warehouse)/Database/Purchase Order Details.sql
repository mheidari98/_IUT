USE [Northwind2007]
GO

/****** Object:  Table [dbo].[Purchase Order Details]    Script Date: 11/11/1399 12:03:30 Þ.Ù ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Purchase Order Details](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Purchase Order ID] [int] NOT NULL,
	[Product ID] [int] NULL,
	[Quantity] [float] NOT NULL,
	[Unit Cost] [money] NOT NULL,
	[Date Received] [datetime2](0) NULL,
	[Posted To Inventory] [bit] NOT NULL,
	[Inventory ID] [int] NULL,
 CONSTRAINT [Purchase Order Details$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Purchase Order Details] ADD  DEFAULT ((0)) FOR [Posted To Inventory]
GO

ALTER TABLE [dbo].[Purchase Order Details]  WITH NOCHECK ADD  CONSTRAINT [Purchase Order Details$New_ProductOnPurchaseOrderDetails] FOREIGN KEY([Product ID])
REFERENCES [dbo].[Products] ([ID])
GO

ALTER TABLE [dbo].[Purchase Order Details] CHECK CONSTRAINT [Purchase Order Details$New_ProductOnPurchaseOrderDetails]
GO

ALTER TABLE [dbo].[Purchase Order Details]  WITH NOCHECK ADD  CONSTRAINT [Purchase Order Details$New_PurchaseOrderDeatilsOnPurchaseOrder] FOREIGN KEY([Purchase Order ID])
REFERENCES [dbo].[Purchase Orders] ([Purchase Order ID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Purchase Order Details] CHECK CONSTRAINT [Purchase Order Details$New_PurchaseOrderDeatilsOnPurchaseOrder]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Order Details].[ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Order Details', @level2type=N'COLUMN',@level2name=N'ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Order Details].[Purchase Order ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Order Details', @level2type=N'COLUMN',@level2name=N'Purchase Order ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Order Details].[Product ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Order Details', @level2type=N'COLUMN',@level2name=N'Product ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Order Details].[Quantity]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Order Details', @level2type=N'COLUMN',@level2name=N'Quantity'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Order Details].[Unit Cost]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Order Details', @level2type=N'COLUMN',@level2name=N'Unit Cost'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Order Details].[Date Received]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Order Details', @level2type=N'COLUMN',@level2name=N'Date Received'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Order Details].[Posted To Inventory]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Order Details', @level2type=N'COLUMN',@level2name=N'Posted To Inventory'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Order Details].[Inventory ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Order Details', @level2type=N'COLUMN',@level2name=N'Inventory ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Order Details].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Order Details', @level2type=N'CONSTRAINT',@level2name=N'Purchase Order Details$PrimaryKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Order Details]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Order Details'
GO

