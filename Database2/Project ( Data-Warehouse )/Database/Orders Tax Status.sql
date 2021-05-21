USE [Northwind2007]
GO

/****** Object:  Table [dbo].[Orders Tax Status]    Script Date: 11/11/1399 12:02:43 Þ.Ù ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Orders Tax Status](
	[ID] [tinyint] NOT NULL,
	[Tax Status Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [Orders Tax Status$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Orders Tax Status]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Orders Tax Status$Tax Status Name$disallow_zero_length] CHECK  ((len([Tax Status Name])>(0)))
GO

ALTER TABLE [dbo].[Orders Tax Status] CHECK CONSTRAINT [SSMA_CC$Orders Tax Status$Tax Status Name$disallow_zero_length]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders Tax Status].[ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders Tax Status', @level2type=N'COLUMN',@level2name=N'ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders Tax Status].[Tax Status Name]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders Tax Status', @level2type=N'COLUMN',@level2name=N'Tax Status Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders Tax Status].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders Tax Status', @level2type=N'CONSTRAINT',@level2name=N'Orders Tax Status$PrimaryKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders Tax Status]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders Tax Status'
GO


