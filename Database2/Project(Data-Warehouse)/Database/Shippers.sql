USE [Northwind2007]
GO

/****** Object:  Table [dbo].[Shippers]    Script Date: 11/11/1399 12:04:47 Þ.Ù ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Shippers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Company] [nvarchar](50) NULL,
	[Last Name] [nvarchar](50) NULL,
	[First Name] [nvarchar](50) NULL,
	[E-mail Address] [nvarchar](50) NULL,
	[Job Title] [nvarchar](50) NULL,
	[Business Phone] [nvarchar](25) NULL,
	[Home Phone] [nvarchar](25) NULL,
	[Mobile Phone] [nvarchar](25) NULL,
	[Fax Number] [nvarchar](25) NULL,
	[Address] [nvarchar](max) NULL,
	[City] [nvarchar](50) NULL,
	[State/Province] [nvarchar](50) NULL,
	[ZIP/Postal Code] [nvarchar](15) NULL,
	[Country/Region] [nvarchar](50) NULL,
	[Web Page] [nvarchar](max) NULL,
	[Notes] [nvarchar](max) NULL,
	[Attachments] [varchar](8000) NULL,
	[SSMA_TimeStamp] [timestamp] NOT NULL,
	[CreditCard Number] [nvarchar](20) NULL,
 CONSTRAINT [Shippers$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Shippers]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Shippers$Address$disallow_zero_length] CHECK  ((len([Address])>(0)))
GO

ALTER TABLE [dbo].[Shippers] CHECK CONSTRAINT [SSMA_CC$Shippers$Address$disallow_zero_length]
GO

ALTER TABLE [dbo].[Shippers]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Shippers$Business Phone$disallow_zero_length] CHECK  ((len([Business Phone])>(0)))
GO

ALTER TABLE [dbo].[Shippers] CHECK CONSTRAINT [SSMA_CC$Shippers$Business Phone$disallow_zero_length]
GO

ALTER TABLE [dbo].[Shippers]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Shippers$City$disallow_zero_length] CHECK  ((len([City])>(0)))
GO

ALTER TABLE [dbo].[Shippers] CHECK CONSTRAINT [SSMA_CC$Shippers$City$disallow_zero_length]
GO

ALTER TABLE [dbo].[Shippers]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Shippers$Company$disallow_zero_length] CHECK  ((len([Company])>(0)))
GO

ALTER TABLE [dbo].[Shippers] CHECK CONSTRAINT [SSMA_CC$Shippers$Company$disallow_zero_length]
GO

ALTER TABLE [dbo].[Shippers]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Shippers$Country/Region$disallow_zero_length] CHECK  ((len([Country/Region])>(0)))
GO

ALTER TABLE [dbo].[Shippers] CHECK CONSTRAINT [SSMA_CC$Shippers$Country/Region$disallow_zero_length]
GO

ALTER TABLE [dbo].[Shippers]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Shippers$E-mail Address$disallow_zero_length] CHECK  ((len([E-mail Address])>(0)))
GO

ALTER TABLE [dbo].[Shippers] CHECK CONSTRAINT [SSMA_CC$Shippers$E-mail Address$disallow_zero_length]
GO

ALTER TABLE [dbo].[Shippers]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Shippers$Fax Number$disallow_zero_length] CHECK  ((len([Fax Number])>(0)))
GO

ALTER TABLE [dbo].[Shippers] CHECK CONSTRAINT [SSMA_CC$Shippers$Fax Number$disallow_zero_length]
GO

ALTER TABLE [dbo].[Shippers]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Shippers$First Name$disallow_zero_length] CHECK  ((len([First Name])>(0)))
GO

ALTER TABLE [dbo].[Shippers] CHECK CONSTRAINT [SSMA_CC$Shippers$First Name$disallow_zero_length]
GO

ALTER TABLE [dbo].[Shippers]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Shippers$Home Phone$disallow_zero_length] CHECK  ((len([Home Phone])>(0)))
GO

ALTER TABLE [dbo].[Shippers] CHECK CONSTRAINT [SSMA_CC$Shippers$Home Phone$disallow_zero_length]
GO

ALTER TABLE [dbo].[Shippers]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Shippers$Job Title$disallow_zero_length] CHECK  ((len([Job Title])>(0)))
GO

ALTER TABLE [dbo].[Shippers] CHECK CONSTRAINT [SSMA_CC$Shippers$Job Title$disallow_zero_length]
GO

ALTER TABLE [dbo].[Shippers]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Shippers$Last Name$disallow_zero_length] CHECK  ((len([Last Name])>(0)))
GO

ALTER TABLE [dbo].[Shippers] CHECK CONSTRAINT [SSMA_CC$Shippers$Last Name$disallow_zero_length]
GO

ALTER TABLE [dbo].[Shippers]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Shippers$Mobile Phone$disallow_zero_length] CHECK  ((len([Mobile Phone])>(0)))
GO

ALTER TABLE [dbo].[Shippers] CHECK CONSTRAINT [SSMA_CC$Shippers$Mobile Phone$disallow_zero_length]
GO

ALTER TABLE [dbo].[Shippers]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Shippers$Notes$disallow_zero_length] CHECK  ((len([Notes])>(0)))
GO

ALTER TABLE [dbo].[Shippers] CHECK CONSTRAINT [SSMA_CC$Shippers$Notes$disallow_zero_length]
GO

ALTER TABLE [dbo].[Shippers]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Shippers$State/Province$disallow_zero_length] CHECK  ((len([State/Province])>(0)))
GO

ALTER TABLE [dbo].[Shippers] CHECK CONSTRAINT [SSMA_CC$Shippers$State/Province$disallow_zero_length]
GO

ALTER TABLE [dbo].[Shippers]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Shippers$Web Page$disallow_zero_length] CHECK  ((len([Web Page])>(0)))
GO

ALTER TABLE [dbo].[Shippers] CHECK CONSTRAINT [SSMA_CC$Shippers$Web Page$disallow_zero_length]
GO

ALTER TABLE [dbo].[Shippers]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Shippers$ZIP/Postal Code$disallow_zero_length] CHECK  ((len([ZIP/Postal Code])>(0)))
GO

ALTER TABLE [dbo].[Shippers] CHECK CONSTRAINT [SSMA_CC$Shippers$ZIP/Postal Code$disallow_zero_length]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Shippers].[ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shippers', @level2type=N'COLUMN',@level2name=N'ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Shippers].[Company]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shippers', @level2type=N'COLUMN',@level2name=N'Company'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Shippers].[Last Name]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shippers', @level2type=N'COLUMN',@level2name=N'Last Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Shippers].[First Name]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shippers', @level2type=N'COLUMN',@level2name=N'First Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Shippers].[E-mail Address]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shippers', @level2type=N'COLUMN',@level2name=N'E-mail Address'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Shippers].[Job Title]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shippers', @level2type=N'COLUMN',@level2name=N'Job Title'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Shippers].[Business Phone]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shippers', @level2type=N'COLUMN',@level2name=N'Business Phone'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Shippers].[Home Phone]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shippers', @level2type=N'COLUMN',@level2name=N'Home Phone'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Shippers].[Mobile Phone]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shippers', @level2type=N'COLUMN',@level2name=N'Mobile Phone'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Shippers].[Fax Number]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shippers', @level2type=N'COLUMN',@level2name=N'Fax Number'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Shippers].[Address]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shippers', @level2type=N'COLUMN',@level2name=N'Address'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Shippers].[City]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shippers', @level2type=N'COLUMN',@level2name=N'City'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Shippers].[State/Province]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shippers', @level2type=N'COLUMN',@level2name=N'State/Province'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Shippers].[ZIP/Postal Code]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shippers', @level2type=N'COLUMN',@level2name=N'ZIP/Postal Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Shippers].[Country/Region]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shippers', @level2type=N'COLUMN',@level2name=N'Country/Region'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Shippers].[Web Page]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shippers', @level2type=N'COLUMN',@level2name=N'Web Page'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Shippers].[Notes]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shippers', @level2type=N'COLUMN',@level2name=N'Notes'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Shippers].[Attachments]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shippers', @level2type=N'COLUMN',@level2name=N'Attachments'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Shippers].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shippers', @level2type=N'CONSTRAINT',@level2name=N'Shippers$PrimaryKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Database1 (2).[Shippers]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shippers'
GO


