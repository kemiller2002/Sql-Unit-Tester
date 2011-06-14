 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[t_SelectResource_GetSpecificFromList]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[t_SelectResource_GetSpecificFromList] AS

SELECT ''SPROC Template'''
GO

ALTER PROCEDURE [t_SelectResource_GetSpecificFromList]
	@OutputResult	INT OUTPUT,
	@OutPutMessage	VARCHAR(1000) OUTPUT
AS

DECLARE @ResourceIdentifier UNIQUEIDENTIFIER
DECLARE @Array	NVARCHAR(1000)
DECLARE @count INT

SELECT 
		@ResourceIdentifier = ResourceIdentifier 
FROM	EventManager.dbo.Resource
WHERE	Name = 'R:0:1:1:0:0:0:0'

SET @Array = '<ArrayOfGuid><guid>' + CAST(@ResourceIdentifier AS NVARCHAR(50)) + '</guid></ArrayOfGuid>'

BEGIN TRY
SELECT @count = COUNT(*)
		EXEC eventmanager.dbo.SelectResource @ResourceIdentifiers = @Array
END TRY
BEGIN CATCH
		SET @OutputResult = -1
		SELECT @OutPutMessage = ERROR_MESSAGE()
END CATCH


IF @Count = 1 AND @@Error = 0 AND @OutputResult <> -1
	SET @OutputResult	= 1
ELSE IF @OutputResult <> -1
BEGIN
	SET @OutputMessage	= 'Expected count does not match actual count. Expected: 1; Actual: ' + 
		CAST(@Count AS VARCHAR)
	SET @OutputResult	= -1
END