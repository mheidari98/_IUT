USE [Northwind2007]
GO

/****** Object:  Table [dbo].[EmployeeSalary]    Script Date: 11/11/1399 12:01:09 Þ.Ù ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EmployeeSalary](
	[EmployeeID] [int] NOT NULL,
	[BaseSalary] [money] NULL,
	[OvertimePaid] [money] NULL,
	[PerformanceBonus] [money] NULL,
	[IncentiveAllowance] [money] NULL,
	[PaymentDate] [date] NULL,
	[PaymentMethod] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


