 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[InsertNewUnitTest]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[InsertNewUnitTest] AS

SELECT ''SPROC Template'''
GO



ALTER PROCEDURE InsertNewUnitTest
	@name VARCHAR(75),
	@application VARCHAR(20)
AS


INSERT INTO UnitTest
(
	Name,
	Application
)
VALUEs
(
	@name,
	@application
)
