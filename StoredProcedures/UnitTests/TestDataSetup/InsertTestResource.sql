 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[InsertTestResource]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[InsertTestResource] AS

SELECT ''SPROC Template'''
GO


ALTER PROCEDURE [dbo].[InsertTestResource]
(
    @resourceProviderIdentifier uniqueidentifier,
    @resourceTypeIdentifier     uniqueIdentifier,
    @name                       short_text,
    @locationIdentifier         uniqueIdentifier,
    @showZeroAvailability       bit,
    @actorUserName              user_id,
    @actorPersonIdentifier      uniqueidentifier,
	@resourcePriority			INT = 0,
	@activeStatusID				INT
)


AS

DECLARE @NewResourceIdentifier UNIQUEIDENTIFIER

DECLARE @ReturnValue TABLE (Identifier UNIQUEIDENTIFIER)

INSERT INTO @ReturnValue 
EXEC EventManager.dbo.InsertResource
@resourceProviderIdentifier,
@resourceTypeIdentifier,
@name,    
@locationIdentifier,
@showZeroAvailability,       
@actorUserName,      
@actorPersonIdentifier,      
@resourcePriority		


UPDATE EventManager.dbo.Resource SET ActiveStatusInternalIdentifier = @activeStatusID WHERE
	ResourceIdentifier IN (SELECT Identifier FROM @ReturnValue)


SELECT TOP 1 Identifier FROM @ReturnValue