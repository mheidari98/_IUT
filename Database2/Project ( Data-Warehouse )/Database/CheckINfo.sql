USE [Northwind2007]
GO

/****** Object:  Table [dbo].[CheckINfo]    Script Date: 11/11/1399 12:00:17 Þ.Ù ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CheckINfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CheckNumber] [nvarchar](20) NULL,
	[CheckType] [int] NULL,
	[Status] [int] NULL,
	[AccountNumber] [nvarchar](20) NULL,
	[Amount] [money] NULL,
	[branch] [nvarchar](20) NULL,
	[IBAN] [nvarchar](20) NULL,
	[DueDate] [date] NULL,
	[Note] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


