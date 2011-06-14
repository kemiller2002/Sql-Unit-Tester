 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[RunTestAndReturnRecordset]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[RunTestAndReturnRecordset] AS

SELECT ''SPROC Template'''
GO

ALTER PROCEDURE [RunTestAndReturnRecordset]
	@ProcedureName VARCHAR(100)

AS
DECLARE @SQLCode			NVARCHAR(1000)
DECLARE @ResultCode			INT
DECLARE @MessageResponse	VARCHAR(1000)



SET @SQLCode = 'EXECUTE	'+ @ProcedureName +' @OutPutResult = @Result OUTPUT, @OutPutMessage = @Message OUTPUT;'

SET @ResultCode = 0

	BEGIN TRY
		EXECUTE sp_executesql @SQLCode, 
			N'@Result INT OUTPUT, @Message VARCHAR(1000) OUTPUT', 
			@Result		= @ResultCode		OUTPUT,
			@Message	= @MessageResponse	OUTPUT 

	END TRY
	BEGIN CATCH
			SET @ResultCode = -1
			SELECT @MessageResponse = CAST(ERROR_MESSAGE() AS VARCHAR(1000))
	END CATCH


SELECT @ResultCode, @MessageResponse

