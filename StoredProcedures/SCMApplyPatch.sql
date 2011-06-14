 IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCMApplyPatch]') AND type in (N'P', N'PC'))
BEGIN
exec sp_executesql N'CREATE PROCEDURE [dbo].[SCMApplyPatch] AS SELECT ''PROCEDURE Template'''
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [SCMApplyPatch]
	@version_major [int],
	@version_minor [int],
	@version_build [int],
	@version_patch [int],
	@product [varchar](50)
WITH EXECUTE AS CALLER
AS
/**************************************************************************
R. Feiock
12/7/07

This sproc is called at the end of all migration scripts to log the version
of the patch or build that was applied so that users have a record of what
revision their database is
**************************************************************************/

DECLARE @cur VARCHAR(40)

SELECT @cur = CONVERT(VARCHAR(30),CURRENT_USER)

INSERT INTO SCMCatalogVersionPatch
(
	version_major,
	version_minor,
	version_build,
	version_patch,
	product,
	apply_user,
	date_applied
)
SELECT
	@version_major, 
	@version_minor, 
	@version_build,
	@version_patch,
	@product,
	@cur,
	GETDATE()
	
return (0)




GO
