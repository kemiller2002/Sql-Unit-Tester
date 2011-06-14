 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SelectTestResults]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[SelectTestResults] AS

SELECT ''SPROC Template'''
GO

ALTER PROCEDURE [SelectTestResults]
	@RunID	UNIQUEIDENTIFIER
AS

SELECT * FROM UnitTestResult WHERE RunID = @RunID