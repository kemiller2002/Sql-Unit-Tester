 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[t_SelectResourceByFuzzyName_SpecificName]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[t_SelectResourceByFuzzyName_SpecificName] AS

SELECT ''SPROC Template'''
GO

ALTER PROCEDURE [t_SelectResourceByFuzzyName_SpecificName]
	@OutputResult INT OUTPUT,
	@OutPutMessage VARCHAR(1000) OUTPUT
AS

DECLARE @count INT

SELECT * INTO #Resource FROM CreateResourceTable()

BEGIN TRY

	INSERT #Resource
		EXEC eventmanager.dbo.SelectResourceByFuzzyName ''

END TRY
BEGIN CATCH

	IF @@ERROR <> 0
	BEGIN
		SET @OutputResult = -1
		SET @OutPutMessage = 'Resource table population error'
	END



END CATCH


SELECT @count = COUNT(*) FROM #Resource


IF @Count = 144 AND @@Error = 0 AND @OutputResult <> -1
	SET @OutputResult	= 1
ELSE IF @OutputResult <> -1
BEGIN
	SET @OutputResult	= -1
	SET @OutPutMessage	= ''
END
DROP TABLE #Resource