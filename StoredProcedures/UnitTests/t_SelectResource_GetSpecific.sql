 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[t_SelectResource_GetSpecific]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[t_SelectResource_GetSpecific] AS

SELECT ''SPROC Template'''
GO

ALTER PROCEDURE t_SelectResource_GetSpecific
	@OutputResult	INT OUTPUT,
	@OutPutMessage	VARCHAR(1000) OUTPUT
AS

DECLARE @TestResourceIdentifier UNIQUEIDENTIFIER
DECLARE @count INT

SELECT * INTO #Resource FROM CreateResourceTable()

SELECT @TestResourceIdentifier = ResourceIdentifier FROM EventManager.dbo.Resource WHERE 
	Name = 'R:0:0:1:1:0:0:0'

BEGIN TRY

	SELECT @Count = COUNT(*)
		EXEC eventmanager.dbo.SelectResource @ResourceIdentifier = @TestResourceIdentifier

END TRY
BEGIN CATCH
	SET @OutputResult = -1
	SELECT @OutPutMessage = ERROR_MESSAGE()
END CATCH


IF @Count = 1 AND @@Error = 0 AND @OutputResult <> -1
	SET @OutputResult	= 1
ELSE IF @OutputResult <> -1 
BEGIN
	SET @OutputResult	= -1
	SET @OutputMessage	= 'Actual count does not meet expected. Expected: 1; Actual: ' + 
		CAST(@Count AS VARCHAR)
END
