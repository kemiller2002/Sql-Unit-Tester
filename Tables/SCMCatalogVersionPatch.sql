 IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCMCatalogVersionPatch]') AND type in (N'U'))
BEGIN
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SCMCatalogVersionPatch](
	[patch_id] [int] IDENTITY(1,1) NOT NULL,
	[version_major] [int] NOT NULL,
	[version_minor] [int] NOT NULL,
	[version_build] [int] NOT NULL,
	[version_patch] [int] NOT NULL,
	[product] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[apply_user] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[date_applied] [datetime] NOT NULL,
 CONSTRAINT [PK_SCMCatalogVersionPatch] PRIMARY KEY CLUSTERED 
(
	[patch_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

END
GO
