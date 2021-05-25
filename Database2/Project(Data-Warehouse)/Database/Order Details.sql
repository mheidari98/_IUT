USE [Northwind2007]
GO

/****** Object:  Table [dbo].[Order Details]    Script Date: 11/11/1399 12:01:35 Þ.Ù ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Order Details](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Order ID] [int] NOT NULL,
	[Product ID] [int] NULL,
	[Quantity] [float] NOT NULL,
	[Unit Price] [money] NULL,
	[Discount] [float] NOT NULL,
	[Status ID] [int] NULL,
	[Date Allocated] [datetime2](0) NULL,
	[Purchase Order ID] [int] NULL,
	[Inventory ID] [int] NULL,
 CONSTRAINT [Order Details$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Order Details] ADD  DEFAULT ((0)) FOR [Quantity]
GO

ALTER TABLE [dbo].[Order Details] ADD  DEFAULT ((0)) FOR [Unit Price]
GO

ALTER TABLE [dbo].[Order Details] ADD  DEFAULT ((0)) FOR [Discount]
GO

ALTER TABLE [dbo].[Order Details]  WITH NOCHECK ADD  CONSTRAINT [Order Details$New_OrderDetails] FOREIGN KEY([Order ID])
REFERENCES [dbo].[Orders] ([Order ID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [Order Details$New_OrderDetails]
GO

ALTER TABLE [dbo].[Order Details]  WITH NOCHECK ADD  CONSTRAINT [Order Details$New_OrderStatusLookup] FOREIGN KEY([Status ID])
REFERENCES [dbo].[Order Details Status] ([Status ID])
GO

ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [Order Details$New_OrderStatusLookup]
GO

ALTER TABLE [dbo].[Order Details]  WITH NOCHECK ADD  CONSTRAINT [Order Details$New_ProductsOnOrders] FOREIGN KEY([Product ID])
REFERENCES [dbo].[Products] ([ID])
GO

ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [Order Details$New_ProductsOnOrders]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Order Details].[Order ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Order Details', @level2type=N'COLUMN',@level2name=N'Order ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Order Details].[Product ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Order Details', @level2type=N'COLUMN',@level2name=N'Product ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Order Details].[Quantity]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Order Details', @level2type=N'COLUMN',@level2name=N'Quantity'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Order Details].[Unit Price]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Order Details', @level2type=N'COLUMN',@level2name=N'Unit Price'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Order Details].[Discount]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Order Details', @level2type=N'COLUMN',@level2name=N'Discount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Order Details].[Status ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Order Details', @level2type=N'COLUMN',@level2name=N'Status ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Order Details].[Date Allocated]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Order Details', @level2type=N'COLUMN',@level2name=N'Date Allocated'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Order Details].[Purchase Order ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Order Details', @level2type=N'COLUMN',@level2name=N'Purchase Order ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Order Details].[Inventory ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Order Details', @level2type=N'COLUMN',@level2name=N'Inventory ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Order Details].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Order Details', @level2type=N'CONSTRAINT',@level2name=N'Order Details$PrimaryKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Order Details]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Order Details'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Order Details].[New_OrderDetails]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Order Details', @level2type=N'CONSTRAINT',@level2name=N'Order Details$New_OrderDetails'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Order Details].[New_OrderStatusLookup]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Order Details', @level2type=N'CONSTRAINT',@level2name=N'Order Details$New_OrderStatusLookup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Order Details].[New_ProductsOnOrders]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Order Details', @level2type=N'CONSTRAINT',@level2name=N'Order Details$New_ProductsOnOrders'
GO


