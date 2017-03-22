-----------------------------------------
-- Create IRR Tables.sql
-- Created by Moshe Bear Prigal
-- 3/22/2017
-----------------------------------------
USE [IRR]

GO
------------------------------------------------------------------
--  Drop the Tables in this order due to FOREIGN KEY Constraints
------------------------------------------------------------------
DROP TABLE [dbo].[S_S_EP]
DROP TABLE [dbo].[S_EP]
DROP TABLE [dbo].[EP]
DROP TABLE [dbo].[EPG]
DROP TABLE [dbo].[Standards]
DROP TABLE [dbo].[Focus]
DROP TABLE [dbo].[Module]
DROP TABLE [dbo].[Program]
DROP TABLE [dbo].[Application]
-- DROP TABLE [dbo].[Organization]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------------
--  Create the Tables in this order due to FOREIGN KEY Constraints
------------------------------------------------------------------

--CREATE TABLE [dbo].[Organization](
--	[Org_ID] [int] NOT NULL,
--	[Org_Name] [varchar](50) NOT NULL,
--	[Org_POC] [varchar](50) NOT NULL,
--	[Org_Address1] [varchar](50) NOT NULL,
--	[Org_Address2] [varchar](50) NOT NULL,
--	[Org_City] [varchar](50) NOT NULL,
--	[Org_State] [varchar](50) NOT NULL,
--	[Org_Zip] [varchar](10) NOT NULL,
--	[Org_Legal_Name] [varchar](50) NOT NULL,
--	[Org_Headquarter_Address] [varchar](255) NULL,
--	[Org_Web_Address] [varchar](255) NULL,
--	[Org_DBA] [varchar](50) NULL,
-- CONSTRAINT [PK_Org_ID] PRIMARY KEY CLUSTERED 
--(
--	[Org_ID] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]

--GO
----------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE [dbo].[Application](
	[APP_ID] [int] NOT NULL,
	[Org_ID] [int] NOT NULL,
	[APP_Number] [varchar](50)  NULL,
	[APP_Type] [varchar](50)  NULL,
	[ProgramVersion] [varchar](50)  NULL,
	[APP_Status] [varchar](50)  NULL,
	[Accreditation_Status] [varchar](50) NULL,
	[Lead_Reviewer] [varchar](50) NULL,
	[APP_POC] [varchar](50) NULL,
	[Account_Manager] [varchar](50) NULL,
	[Current_Score] [varchar](50) NULL,
	[AC_Score] [varchar](50) NULL,
	[Reviewer] [varchar](50) NULL,
 CONSTRAINT [PK_APP_ID] PRIMARY KEY CLUSTERED 
(
	[APP_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Application]  WITH CHECK ADD  CONSTRAINT [FK_Org_ID] FOREIGN KEY([Org_ID])
REFERENCES [dbo].[Organization] ([Org_ID])
GO

ALTER TABLE [dbo].[Application] CHECK CONSTRAINT [FK_Org_ID]
GO
----------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE [dbo].[Program](
	[Program_ID] [int] NOT NULL,
	[APP_ID] [int]  NULL CONSTRAINT [FK_APP_ID] FOREIGN KEY([APP_ID])  REFERENCES [dbo].[Application] ([APP_ID]),
	[Program_Name] [varchar](50)  NULL,
	[Program_Description] [varchar](200) NULL,
	[Addendum][varchar](50)  NULL,
	[Version] [float]  NULL,
	CONSTRAINT [PK_Program_ID] PRIMARY KEY CLUSTERED 
(
	[Program_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

----------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE [dbo].[Module](
	[Module_ID] [int] NOT NULL,
	[Program_ID] [int]  NULL CONSTRAINT [FK_Program_ID] FOREIGN KEY([Program_ID])  REFERENCES [dbo].[Program] ([Program_ID]),
	[Mod_Name] [varchar](50) NULL,
	[Mod_Description] [varchar](200) NULL,
	[Mod_Number] [int] NULL
	CONSTRAINT [PK_Module_ID] PRIMARY KEY CLUSTERED 
(
	[Module_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

----------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE [dbo].[Focus](
	[Focus_ID] [int] NOT NULL,
	[Module_ID] [int]  NULL  CONSTRAINT [FK_Module_ID] FOREIGN KEY([Module_ID])  REFERENCES [dbo].[Module] ([Module_ID]),
	[Focus_Name] [varchar](50) NULL,
	[Focus_Description] [varchar](200) NULL,
	[Version] [date] NOT NULL,
	[Addendum]  [varchar](200) NULL,
	CONSTRAINT [PK_Focus_ID] PRIMARY KEY CLUSTERED 
(
	[Focus_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
----------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE [dbo].[Standards](
	[Stanard_ID] [int] NOT NULL,
	[Focus_ID] [int] NULL  CONSTRAINT [FK_Focus_ID] FOREIGN KEY([Focus_ID])  REFERENCES [dbo].[Focus] ([Focus_ID]),
	[Prefix][varchar](10) NULL,
	[Number][int]  NULL,
	[Stanard_Name] [varchar](50) NULL,
	[Standard_Description] [varchar](200) NULL,
	[Text][varchar](200) NULL,
	[Version] [float]  NULL,
	[WeightValue] [varchar](50) NULL,
	[Weight] [char](1) NULL,
--	[RatingThreshold][varchar](50) NULL,  -- according to Josh this is not needed
	[Rating] [char](1) NULL,
	[Program_ID] [int] NULL,
	[Module_ID] [int] NULL,
	[APP_ID] [int] NULL,
	[OrgID] [int] NULL,
	[DisplayOrder][int] Null,
	CONSTRAINT [PK_Stanard_ID] PRIMARY KEY CLUSTERED 
(
	[Stanard_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

----------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE [dbo].[EPG](
	[EPG_ID] [int] NOT NULL,
	[Stanard_ID] [int] NULL  CONSTRAINT [FK_Stanard_ID] FOREIGN KEY([Stanard_ID])  REFERENCES [dbo].[Standards] ([Stanard_ID]),
	[Prefix][varchar](10) NULL,
	[EPG_Name] [varchar](50) NULL,
	[EPG_Description] [varchar](200) NULL,
	[DisplayOrder][int] Null,
	CONSTRAINT [PK_EPG_ID] PRIMARY KEY CLUSTERED 
(
	[EPG_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
----------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE [dbo].[EP](
	[EP_ID] [int] NOT NULL,
	[EPG_ID] [int] NULL  CONSTRAINT [FK_EPG_ID] FOREIGN KEY([EPG_ID])  REFERENCES [dbo].[EPG] ([EPG_ID]),
	[Prefix][varchar](10) NULL,
	[EP_Name] [varchar](50) NOT NULL,
	[EP_Description] [varchar](200) NULL,
	[WeightValue] [varchar](50) NULL,
	[Weight] [char](1) NULL,
	[Rating] [char](1) NULL,
	[DisplayOrder][int] Null,
CONSTRAINT [PK_EP_ID] PRIMARY KEY CLUSTERED 
(
	[EP_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
----------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE [dbo].[S_EP](
	[S_EP_ID] [int] NOT NULL,
	[EP_ID] [int] NULL CONSTRAINT [FK_EP_ID] FOREIGN KEY([EP_ID])  REFERENCES [dbo].[EP] ([EP_ID]),
	[S_EP_Name] [varchar](50)  NULL,
	[S_EP_Description] [varchar](50) NULL,
	[Weight] [char](1) NULL,
	[Rating] [char](1) NULL,
	CONSTRAINT [PK_S_EP_ID] PRIMARY KEY CLUSTERED 
(
	[S_EP_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
----------------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE [dbo].[S_S_EP](
	[S_S_EP_ID] [int] NOT NULL,
	[S_EP_ID] [int] NULL  CONSTRAINT [FK_S_EP_ID] FOREIGN KEY([S_EP_ID])  REFERENCES [dbo].[S_EP] ([S_EP_ID]),
	[S_S_EP_Name] [varchar](50) NOT NULL,
	[S_S_EP_Description] [varchar](200) NULL,
	[Weight] [char](1) NULL,
	[Rating] [char](1) NULL,
	CONSTRAINT [PK_S_S_EP_ID] PRIMARY KEY CLUSTERED 
(
	[S_S_EP_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
----------------------------------------------------------------------------------------------------------------------------------------------









