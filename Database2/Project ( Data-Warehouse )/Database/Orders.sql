USE [Northwind2007]
GO

/****** Object:  Table [dbo].[Orders]    Script Date: 11/11/1399 12:02:16 Þ.Ù ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Orders](
	[Order ID] [int] IDENTITY(1,1) NOT NULL,
	[Employee ID] [int] NULL,
	[Customer ID] [int] NULL,
	[Order Date] [datetime2](0) NULL,
	[Shipped Date] [datetime2](0) NULL,
	[Shipper ID] [int] NULL,
	[Ship Name] [nvarchar](50) NULL,
	[Ship Address] [nvarchar](max) NULL,
	[Ship City] [nvarchar](50) NULL,
	[Ship State/Province] [nvarchar](50) NULL,
	[Ship ZIP/Postal Code] [nvarchar](50) NULL,
	[Ship Country/Region] [nvarchar](50) NULL,
	[Shipping Fee] [money] NULL,
	[Taxes] [money] NULL,
	[Payment Type] [nvarchar](50) NULL,
	[Paid Date] [datetime2](0) NULL,
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

ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [Order Date]
GO

ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [Shipping Fee]
GO

ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [Taxes]
GO

ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [Tax Rate]
GO

ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [Status ID]
GO

ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [Orders$New_CustomerOnOrders] FOREIGN KEY([Customer ID])
REFERENCES [dbo].[Customers] ([ID])
GO

ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [Orders$New_CustomerOnOrders]
GO

ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [Orders$New_EmployeesOnOrders] FOREIGN KEY([Employee ID])
REFERENCES [dbo].[Employees] ([ID])
GO

ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [Orders$New_EmployeesOnOrders]
GO

ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [Orders$New_OrderStatus] FOREIGN KEY([Status ID])
REFERENCES [dbo].[Orders Status] ([Status ID])
GO

ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [Orders$New_OrderStatus]
GO

ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [Orders$New_ShipperOnOrder] FOREIGN KEY([Shipper ID])
REFERENCES [dbo].[Shippers] ([ID])
GO

ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [Orders$New_ShipperOnOrder]
GO

ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [Orders$New_TaxStatusOnOrders] FOREIGN KEY([Tax Status])
REFERENCES [dbo].[Orders Tax Status] ([ID])
GO

ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [Orders$New_TaxStatusOnOrders]
GO

ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Orders$Notes$disallow_zero_length] CHECK  ((len([Notes])>(0)))
GO

GO

ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Orders$Payment Type$disallow_zero_length] CHECK  ((len([Payment Type])>(0)))
GO

ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [SSMA_CC$Orders$Payment Type$disallow_zero_length]
GO

ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Orders$Ship Address$disallow_zero_length] CHECK  ((len([Ship Address])>(0)))
GO

ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [SSMA_CC$Orders$Ship Address$disallow_zero_length]
GO

ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Orders$Ship City$disallow_zero_length] CHECK  ((len([Ship City])>(0)))
GO

ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [SSMA_CC$Orders$Ship City$disallow_zero_length]
GO

ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Orders$Ship Country/Region$disallow_zero_length] CHECK  ((len([Ship Country/Region])>(0)))
GO

ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [SSMA_CC$Orders$Ship Country/Region$disallow_zero_length]
GO

ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Orders$Ship Name$disallow_zero_length] CHECK  ((len([Ship Name])>(0)))
GO

ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [SSMA_CC$Orders$Ship Name$disallow_zero_length]
GO

ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Orders$Ship State/Province$disallow_zero_length] CHECK  ((len([Ship State/Province])>(0)))
GO

ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [SSMA_CC$Orders$Ship State/Province$disallow_zero_length]
GO

ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Orders$Ship ZIP/Postal Code$disallow_zero_length] CHECK  ((len([Ship ZIP/Postal Code])>(0)))
GO

ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [SSMA_CC$Orders$Ship ZIP/Postal Code$disallow_zero_length]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[Employee ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Employee ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[Customer ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Customer ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[Order Date]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Order Date'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[Shipped Date]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Shipped Date'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[Shipper ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Shipper ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[Ship Name]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Ship Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[Ship Address]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Ship Address'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[Ship City]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Ship City'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[Ship State/Province]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Ship State/Province'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[Ship ZIP/Postal Code]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Ship ZIP/Postal Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[Ship Country/Region]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Ship Country/Region'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[Shipping Fee]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Shipping Fee'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[Taxes]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Taxes'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[Payment Type]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Payment Type'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[Paid Date]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Paid Date'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[Notes]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Notes'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[Tax Rate]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Tax Rate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[Tax Status]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Tax Status'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[Status ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Status ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'CONSTRAINT',@level2name=N'Orders$PrimaryKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[New_CustomerOnOrders]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'CONSTRAINT',@level2name=N'Orders$New_CustomerOnOrders'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[New_EmployeesOnOrders]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'CONSTRAINT',@level2name=N'Orders$New_EmployeesOnOrders'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[New_OrderStatus]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'CONSTRAINT',@level2name=N'Orders$New_OrderStatus'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[New_ShipperOnOrder]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'CONSTRAINT',@level2name=N'Orders$New_ShipperOnOrder'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders].[New_TaxStatusOnOrders]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'CONSTRAINT',@level2name=N'Orders$New_TaxStatusOnOrders'
GO


