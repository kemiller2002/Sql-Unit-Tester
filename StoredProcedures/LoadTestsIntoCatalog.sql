 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[LoadTestsIntoCatalog]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[LoadTestsIntoCatalog] AS

SELECT ''SPROC Template'''
GO

ALTER PROCEDURE [LoadTestsIntoCatalog]
	@Application VARCHAR(20)
AS

	INSERT INTO UnitTestCatalog
	(
		Name,
		Application
	)
	SELECT Name, @Application FROM sys.objects obj WHERE Name like 't_%'
		AND obj.Name NOT IN 
		(SELECT Name From UnitTestCatalog)
