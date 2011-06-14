 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[RunUnitTests]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[RunUnitTests] AS

SELECT ''SPROC Template'''
GO

ALTER PROCEDURE RunUnitTests
	@RunID	UNIQUEIDENTIFIER
AS

DECLARE @ProcedureName	NVARCHAR(75)
DECLARE @SQLCode		NVARCHAR(1000)

DECLARE @ID					INT
DECLARE @ResultCode			INT
DECLARE @MessageResponse	VARCHAR(1000)
DECLARE @StartDateTime		DATETIME

DECLARE Procedures CURSOR FOR 
	SELECT ID, UnitTestName FROM UnitTestResult WHERE RunID = @RunID
OPEN Procedures 


FETCH NEXT FROM Procedures INTO @ID, @ProcedureName

WHILE @@FETCH_STATUS = 0
BEGIN

	SET @SQLCode = 'EXECUTE	'+ @ProcedureName +' @OutPutResult = @Result OUTPUT, @OutPutMessage = @Message OUTPUT;'
	SET @ResultCode = 0
	SET @StartDateTime = GETDATE();

	BEGIN TRY
		EXECUTE sp_executesql @SQLCode, 
			N'@Result INT OUTPUT, @Message VARCHAR(1000) OUTPUT', 
			@Result		= @ResultCode		OUTPUT,
			@Message	= @MessageResponse	OUTPUT 
	END TRY
	BEGIN CATCH
			SET @ResultCode			= -1
			SELECT @MessageResponse = CAST(ERROR_MESSAGE() AS VARCHAR(1000))
	END CATCH


	UPDATE 
		UnitTestResult 
	SET 
		Result = @ResultCode, 
		RunDateTime = @StartDateTime,
		FinishDateTime = GETDATE(),
		Message = @MessageResponse

	WHERE ID = @ID


	FETCH NEXT FROM Procedures INTO @ID, @ProcedureName
END

CLOSE Procedures
DEALLOCATE Procedures
