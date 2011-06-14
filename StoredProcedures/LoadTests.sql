 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[LoadTests]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[LoadTests] AS

SELECT ''SPROC Template'''
GO

ALTER PROCEDURE LoadTests
	@TestName		VARCHAR(75)			= NULL,
	@Application	VARCHAR(20)			= NULL,
	@RunID			UNIQUEIDENTIFIER	OUTPUT
AS

SELECT @RunID = NEWID()

INSERT INTO UnitTestResult
(
	RunID,
	UnitTestName
)
SELECT 
	@RunID,
	Name
FROM UnitTestCatalog
	WHERE 
(
	Name = @TestName
	OR
	@TestName IS NULL
)
AND
(
	Application = @Application
	OR
	@Application IS NULL
)