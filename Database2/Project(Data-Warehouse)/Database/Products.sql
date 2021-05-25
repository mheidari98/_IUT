USE [Northwind2007]
GO

/****** Object:  Table [dbo].[Products]    Script Date: 11/11/1399 12:02:58 Þ.Ù ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Products](
	[Supplier IDs] [varchar](8000) NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Product Code] [nvarchar](25) NULL,
	[Product Name] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[Standard Cost] [money] NULL,
	[List Price] [money] NOT NULL,
	[Reorder Level] [smallint] NULL,
	[Target Level] [int] NULL,
	[Quantity Per Unit] [nvarchar](50) NULL,
	[Discontinued] [bit] NOT NULL,
	[Minimum Reorder Quantity] [smallint] NULL,
	[Category] [nvarchar](50) NULL,
	[Attachments] [varchar](8000) NULL,
	[SSMA_TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [Products$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [Standard Cost]
GO

ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [List Price]
GO

ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [Discontinued]
GO

ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Products$Category$disallow_zero_length] CHECK  ((len([Category])>(0)))
GO

ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [SSMA_CC$Products$Category$disallow_zero_length]
GO

ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Products$Description$disallow_zero_length] CHECK  ((len([Description])>(0)))
GO

ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [SSMA_CC$Products$Description$disallow_zero_length]
GO

ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Products$Product Code$disallow_zero_length] CHECK  ((len([Product Code])>(0)))
GO

ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [SSMA_CC$Products$Product Code$disallow_zero_length]
GO

ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Products$Product Name$disallow_zero_length] CHECK  ((len([Product Name])>(0)))
GO

ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [SSMA_CC$Products$Product Name$disallow_zero_length]
GO

ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Products$Quantity Per Unit$disallow_zero_length] CHECK  ((len([Quantity Per Unit])>(0)))
GO

ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [SSMA_CC$Products$Quantity Per Unit$disallow_zero_length]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Products].[Supplier IDs]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'Supplier IDs'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Products].[ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Products].[Product Code]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'Product Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Products].[Product Name]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'Product Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Products].[Description]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Products].[Standard Cost]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'Standard Cost'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Products].[List Price]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'List Price'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Inventory quantity that triggers reordering' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'Reorder Level'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Products].[Reorder Level]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'Reorder Level'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Desired Inventory level after a purchase reorder' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'Target Level'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Products].[Target Level]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'Target Level'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Products].[Quantity Per Unit]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'Quantity Per Unit'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Products].[Discontinued]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'Discontinued'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Products].[Minimum Reorder Quantity]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'Minimum Reorder Quantity'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Products].[Category]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'Category'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Products].[Attachments]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'Attachments'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Products].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'CONSTRAINT',@level2name=N'Products$PrimaryKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Products]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products'
GO


