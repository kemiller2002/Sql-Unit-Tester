 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[InsertResourceIntoResourcePool]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[InsertResourceIntoResourcePool] AS

SELECT ''SPROC Template'''
GO
ALTER PROCEDURE [dbo].[InsertResourceIntoResourcePool]
(
    @resourcePoolIdentifier AS UNIQUEIDENTIFIER,
    @resourceIdentifier AS UNIQUEIDENTIFIER,
    @actorUserName as user_id
)

AS

DECLARE @ResourceProviderXML	NVARCHAR(500)
DECLARE @ResourceIdentifierXML	NVARCHAR(500)

SET @ResourceProviderXML	= '<ArrayOfGuid><guid>' + CAST(@resourcePoolIdentifier AS VARCHAR) + '</guid></ArrayOfGuid>'
SET @ResourceIdentifierXML	= '<ArrayOfGuid><guid>' + CAST(@resourceIdentifier AS VARCHAR) + '</guid></ArrayOfGuid>'

EXEC EventManager.dbo.InsertResourceIntoResourcePool @ResourceProviderXML, @ResourceIdentifierXML, @actorUserName