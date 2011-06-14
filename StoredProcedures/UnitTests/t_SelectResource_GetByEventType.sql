 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[t_SelectResource_GetByInActiveResourceProvider]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[t_SelectResource_GetByInActiveResourceProvider] AS

SELECT ''SPROC Template'''
GO

ALTER PROCEDURE [t_SelectResource_GetByInActiveResourceProvider]
	@OutputResult	INT OUTPUT,
	@OutPutMessage	VARCHAR(1000) OUTPUT
AS

DECLARE @TestEventTypeIdentifier				UNIQUEIDENTIFIER
DECLARE @CorrectCount							INT
DECLARE @TestResourceProviderInternalIdentifier INT 


SELECT @TestEventTypeIdentifier = EventTypeIdentifier FROM EventManager.dbo.EventType 
	WHERE [Name] = 'E:7cd7kevi151205/5/00'

SET @CorrectCount = 0

SELECT * INTO #Resource FROM CreateResourceTable()


BEGIN TRY

	INSERT #Resource
		EXEC eventmanager.dbo.SelectResource @EventTypeIdentifier = @TestEventTypeIdentifier

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
	SET @OutPutMessage	= 'Expected count does not meet actual count. Expected: ' 
		+ CAST(@CorrectCount AS VARCHAR) + ' Actual: ' + CAST(@Count AS VARCHAR)
END



DROP TABLE #Resource