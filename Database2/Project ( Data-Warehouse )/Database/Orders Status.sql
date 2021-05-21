USE [Northwind2007]
GO

/****** Object:  Table [dbo].[Orders Status]    Script Date: 11/11/1399 12:02:28 Þ.Ù ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Orders Status](
	[Status ID] [tinyint] NOT NULL,
	[Status Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [Orders Status$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[Status ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Orders Status]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Orders Status$Status Name$disallow_zero_length] CHECK  ((len([Status Name])>(0)))
GO

ALTER TABLE [dbo].[Orders Status] CHECK CONSTRAINT [SSMA_CC$Orders Status$Status Name$disallow_zero_length]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders Status].[Status ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders Status', @level2type=N'COLUMN',@level2name=N'Status ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders Status].[Status Name]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders Status', @level2type=N'COLUMN',@level2name=N'Status Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders Status].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders Status', @level2type=N'CONSTRAINT',@level2name=N'Orders Status$PrimaryKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Orders Status]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders Status'
GO


