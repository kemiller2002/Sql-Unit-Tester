 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[t_SelectResource_GetByInActiveResourceProvider]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[t_SelectResource_GetByInActiveResourceProvider] AS

SELECT ''SPROC Template'''
GO

ALTER PROCEDURE [t_SelectResource_GetByInActiveResourceProvider]
	@OutputResult	INT OUTPUT,
	@OutPutMessage	VARCHAR(1000) OUTPUT
AS

DECLARE @ResourceProvider						UNIQUEIDENTIFIER
DECLARE @CorrectCount							INT
DECLARE @TestResourceProviderInternalIdentifier INT 
DECLARE @Count INT

SELECT	@ResourceProvider = ResourceProviderIdentifier 
FROM	EventManager.dbo.ResourceProvider 
WHERE	Name = 'RP:0:1:0:0'

SET @CorrectCount = 0

SELECT * INTO #Resource FROM CreateResourceTable()


BEGIN TRY

	INSERT #Resource
		EXEC eventmanager.dbo.SelectResource @ResourceProviderIdentifier = @ResourceProvider

END TRY
BEGIN CATCH
		SET		@OutputResult = -1
		SELECT	@OutPutMessage = CAST(ERROR_MESSAGE() AS VARCHAR(1000))
END CATCH

SELECT @Count = COUNT(*) FROM #Resource

IF @Count = @CorrectCount AND @@Error = 0 AND @OutputResult <> -1
BEGIN
	SET @OutputResult	= 1
END
ELSE IF @OutputResult <> -1
BEGIN 
	SET @OutputResult	= -1
	SET @OutPutMessage	= 'Expected count does not meet actual count. Expected: ' 
		+ CAST(@CorrectCount AS VARCHAR) + ' Actual: ' + CAST(@Count AS VARCHAR)
END



DROP TABLE #Resource