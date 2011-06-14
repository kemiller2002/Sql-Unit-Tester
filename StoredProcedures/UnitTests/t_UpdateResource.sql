 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[t_UpdateResource]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[t_UpdateResource] AS

SELECT ''SPROC Template'''
GO

ALTER PROCEDURE [t_UpdateResource]
	@OutputResult	INT OUTPUT,
	@OutPutMessage	VARCHAR(1000) OUTPUT
AS

DECLARE @ResouceInternalIdentifier	INT 
DECLARE @resourceIdentifier			uniqueidentifier
DECLARE @name						short_text
DECLARE @locationIdentifier			uniqueIdentifier
DECLARE @showZeroAvailability		bit
DECLARE @actorUserName				user_id
DECLARE	@resourcePriority			INT
DECLARE @FindCount					INT
DEClARE @LocationInternalIdentifier	INT

SELECT	@ResouceInternalIdentifier	= ResourceInternalIdentifier, 
		@resourceIdentifier			= ResourceIdentifier
FROM	EventManager.dbo.Resource
WHERE	Name = 'R:0:0:1:0:0:0:0'

SET @name						= 'TEST_NAME212'
SET @showZeroAvailability		= 0
SET @actorUserName				= 'USER_NAME2'
SET @resourcePriority			= 99

SELECT TOP 1  
	@locationIdentifier			= LocationIdentifier,
	@locationInternalIdentifier = LocationInternalIdentifier 
FROM PanCoreData.dbo.Location

BEGIN TRAN
	BEGIN TRY

			EXEC eventmanager.dbo.UpdateResource 
					@resourceIdentifier			= @resourceIdentifier,
					@name						= @name,
					@locationIdentifier			= @locationIdentifier,
					@showZeroAvailability		= @showZeroAvailability,
					@actorUserName				= @actorUserName,
					@resourcePriority			= @resourcePriority



	IF @OutputResult <> -1
	BEGIN
		SELECT @FindCount = COUNT(*) FROM EventManager.dbo.Resource 
			WHERE 
					ResourceIdentifier = @resourceIdentifier 
					AND
					name = @name

		IF @FindCount <> 1
		BEGIN
			SET @OutputResult	= -1
			SET @OutPutMessage	= 'Name was not updated.'
		END
	END


	IF @OutputResult <> -1
	BEGIN
		SELECT @FindCount = COUNT(*) FROM EventManager.dbo.Resource 
			WHERE 
					ResourceIdentifier		= @resourceIdentifier 
					AND
					ShowZeroAvailability	= @showZeroAvailability

		IF @FindCount <> 1
		BEGIN
			SET @OutputResult	= -1
			SET @OutPutMessage	= 'Show Zero Availability was not updated.'
		END
	END

	IF @OutputResult <> -1
	BEGIN
		SELECT @FindCount = COUNT(*) FROM EventManager.dbo.Resource 
			WHERE 
					ResourceIdentifier		= @resourceIdentifier 
					AND
					ModificationUser		= @actorUserName

		IF @FindCount <> 1
		BEGIN
			SET @OutputResult	= -1
			SET @OutPutMessage	= 'Modified User Name was not updated.'
		END
	END


	IF @OutputResult <> -1
	BEGIN
		SELECT @FindCount = COUNT(*) FROM EventManager.dbo.Resource 
			WHERE 
					ResourceIdentifier		= @resourceIdentifier 
					AND
					ResourcePriority		= @resourcePriority

		IF @FindCount <> 1
		BEGIN
			SET @OutputResult	= -1
			SET @OutPutMessage	= 'Resource Priority was not updated.'
		END
	END

	IF @OutputResult <> -1
	BEGIN
		SELECT @FindCount = COUNT(*) FROM EventManager.dbo.Resource 
			WHERE 
					ResourceIdentifier				= @resourceIdentifier 
					AND
					LocationInternalIdentifier		= @locationInternalIdentifier

		IF @FindCount <> 1
		BEGIN
			SET @OutputResult	= -1
			SET @OutPutMessage	= 'Location was not updated.'
		END
	END



--	SELECT * FROM EventManager.dbo.Resource WHERE ResourceIdentifier = @resourceIdentifier


	END TRY
	BEGIN CATCH
		SET		@OutputResult	= -1
		SELECT	@OutPutMessage	= ERROR_MESSAGE()
	END CATCH



ROLLBACK TRAN

/*
IF @Count = @TestCount AND @@Error = 0 AND @OutputResult <> -1
	SET @OutputResult	= 1
ELSE IF @OutputResult <> -1
BEGIN
	SET @OutputResult	= -1
	SET @OutPutMessage	= 'Expected count does not meet actual count. Expected: ' 
		+ CAST(@TestCount AS VARCHAR) + ' Actual: ' + CAST(@Count AS VARCHAR)
END
*/
