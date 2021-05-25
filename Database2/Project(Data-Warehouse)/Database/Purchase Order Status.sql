USE [Northwind2007]
GO

/****** Object:  Table [dbo].[Purchase Order Status]    Script Date: 11/11/1399 12:04:04 Þ.Ù ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Purchase Order Status](
	[Status ID] [int] NOT NULL,
	[Status] [nvarchar](50) NULL,
 CONSTRAINT [Purchase Order Status$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[Status ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Purchase Order Status]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Purchase Order Status$Status$disallow_zero_length] CHECK  ((len([Status])>(0)))
GO

ALTER TABLE [dbo].[Purchase Order Status] CHECK CONSTRAINT [SSMA_CC$Purchase Order Status$Status$disallow_zero_length]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Order Status].[Status ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Order Status', @level2type=N'COLUMN',@level2name=N'Status ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Order Status].[Status]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Order Status', @level2type=N'COLUMN',@level2name=N'Status'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Order Status].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Order Status', @level2type=N'CONSTRAINT',@level2name=N'Purchase Order Status$PrimaryKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Purchase Order Status]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Purchase Order Status'
GO


