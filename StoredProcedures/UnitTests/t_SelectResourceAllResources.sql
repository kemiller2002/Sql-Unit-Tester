 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[t_SelectAllResource]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[t_SelectAllResource] AS

SELECT ''SPROC Template'''
GO

ALTER PROCEDURE [t_SelectAllResource]
	@OutPutResult INT OUTPUT,
	@OutPutMessage VARCHAR(1000) OUTPUT
AS

DECLARE @TestCount	INT 
DECLARE @count		INT

SELECT @TestCount = COUNT(*) FROM EventManager.dbo.Resource

SELECT * INTO #Resource FROM CreateResourceTable()

BEGIN TRY

	INSERT #Resource
		EXEC eventmanager.dbo.SelectAllResource

END TRY
BEGIN CATCH

	IF @@ERROR <> 0
	BEGIN
		SET @OutputResult = -1
		SET @OutPutMessage = 'Resource table population error'
	END


END CATCH


SELECT @Count = COUNT(*) FROM #Resource

DROP TABLE #Resource

IF @Count = @TestCount AND @OutputResult <> -1
	SET @OutputResult	= 1
ELSE IF @OutputResult <> -1
BEGIN 
	SET @OutputResult	= -1
	SET @OutPutMessage	= 'Expected count does not meet actual count. Expected: ' 
		+ CAST(@TestCount AS VARCHAR) + ' Actual: ' + CAST(@Count AS VARCHAR)
END

