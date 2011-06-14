 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[InsertTestResourceProvider]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[InsertTestResourceProvider] AS

SELECT ''SPROC Template'''
GO


ALTER PROCEDURE [dbo].[InsertTestResourceProvider]
(
    @name           short_text,
    @requireResourceIPValidation bit = 0,
    @actorUserName  user_id,
    @actorPersonIdentifier uniqueidentifier,
	@ActiveStatusInternalIdentifier	int = 1
)
AS

DECLARE @output TABLE (identifier UNIQUEIDENTIFIER)

INSERT INTO @output EXEC EventManager.dbo.[InsertResourceProvider]
 @name,
 @requireResourceIPValidation,
 @actorUserName,
 @actorPersonIdentifier


UPDATE EventManager.dbo.ResourceProvider SET ActiveStatusInternalIdentifier = @ActiveStatusInternalIdentifier 
WHERE ResourceProviderIdentifier IN (SELECT identifier FROM @output)


SELECT identifier FROM @output 
