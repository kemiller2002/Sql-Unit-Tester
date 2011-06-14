 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[InsertNewApplication]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[InsertNewApplication] AS

SELECT ''SPROC Template'''
GO

ALTER PROCEDURE [InsertNewApplication]
	@application VARCHAR(20)
AS

IF(NOT EXISTS(SELECT * FROM Application WHERE Application = @application))
BEGIN

	INSERT INTO Application
	(
		Application
	)
	VALUES
	(
		@application
	)
END