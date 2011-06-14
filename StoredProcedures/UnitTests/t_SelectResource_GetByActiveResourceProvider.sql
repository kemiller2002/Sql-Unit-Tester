 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[t_SelectResource_GetByActiveResourceProvider]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[t_SelectResource_GetByActiveResourceProvider] AS

SELECT ''SPROC Template'''
GO

ALTER PROCEDURE t_SelectResource_GetByActiveResourceProvider
	@OutputResult	INT OUTPUT,
	@OutPutMessage	VARCHAR(1000) OUTPUT
AS

DECLARE @ActiveResourceProvider					UNIQUEIDENTIFIER
DECLARE @CorrectCount							INT
DECLARE @TestResourceProviderInternalIdentifier INT 

SELECT	TOP 1 @ActiveResourceProvider = ResourceProviderIdentifier,
		@TestResourceProviderInternalIdentifier = ResourceProviderInternalIdentifier 
FROM	EventManager.dbo.ResourceProvider 
WHERE	ActiveStatusInternalIdentifier = 1

SELECT	@CorrectCount = COUNT(*)
FROM	EventManager.dbo.Resource r
WHERE	
	ResourceProviderInternalIdentifier = @TestResourceProviderInternalIdentifier
AND
	r.ActiveStatusInternalIdentifier = 1

SELECT * INTO #Resource FROM CreateResourceTable()


BEGIN TRY

	INSERT #Resource
		EXEC eventmanager.dbo.SelectResource @ResourceProviderIdentifier = @ActiveResourceProvider

END TRY
BEGIN CATCH
	IF @@ERROR <> 0
	BEGIN
		SET @OutputResult = -1
		SET @OutPutMessage = 'Resource table population error'
	END

END CATCH

DECLARE @count INT

SELECT @count = COUNT(*) FROM #Resource

IF @Count = @CorrectCount AND @@Error = 0 AND @OutputResult <> -1
	SET @OutputResult	= 1
ELSE IF @OutputResult <> -1
BEGIN
	SET @OutputResult	= -1
	SET @OutPutMessage = 'Expected did not match actual count.  Expected: ' + 
		CAST(@CorrectCount AS VARCHAR) + ' Actual: ' + CAST(@Count AS VARCHAR)
END

DROP TABLE #Resource