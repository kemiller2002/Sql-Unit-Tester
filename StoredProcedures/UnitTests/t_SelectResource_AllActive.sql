 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[t_SelectResource_AllActive]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[t_SelectResource_AllActive] AS

SELECT ''SPROC Template'''
GO

ALTER PROCEDURE t_SelectResource_AllActive
	@OutputResult	INT OUTPUT,
	@OutPutMessage	VARCHAR(1000) OUTPUT
AS

DECLARE @TestCount INT

SELECT * INTO #Resource FROM CreateResourceTable()

SELECT @TestCount = COUNT(*) FROM EventManager.dbo.Resource Where ActiveStatusInternalIdentifier = 1

BEGIN TRY

	INSERT #Resource
		EXEC eventmanager.dbo.SelectResource

END TRY
BEGIN CATCH
	SET @OutputResult = -1
	SET @OutPutMessage = 'Resource table population error'
END CATCH


DECLARE @count INT

SELECT @count = COUNT(*) FROM #Resource


IF @Count = @TestCount AND @@Error = 0 AND @OutputResult <> -1
	SET @OutputResult	= 1
ELSE IF @OutputResult <> -1
BEGIN
	SET @OutputResult	= -1
	SET @OutPutMessage	= 'Expected count does not meet actual count. Expected: ' 
		+ CAST(@TestCount AS VARCHAR) + ' Actual: ' + CAST(@Count AS VARCHAR)
END
DROP TABLE #Resource