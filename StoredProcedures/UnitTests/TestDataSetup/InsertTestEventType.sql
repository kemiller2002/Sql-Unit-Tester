 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].InsertTestEventType') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].InsertTestEventType AS

SELECT ''SPROC Template'''
GO


ALTER PROCEDURE [dbo].InsertTestEventType
(
	@eventTypeIdentifier			uniqueidentifier = NULL,
	@clientIdentifier				uniqueidentifier,
	@name							short_text,
	@maximumDuration				smallint,
	@noShowInterval					integer = NULL,
	@resourcePoolIdentifier			uniqueidentifier,
	@requireResourceIPValidation	bit = 1,
    @actorUserName					user_id,
    @actorPersonIdentifier			uniqueidentifier
)
AS

EXEC EventManager.dbo.InsertEventType
@eventTypeIdentifier					,
@clientIdentifier						,
@name									,
@maximumDuration						,
@noShowInterval							,
@resourcePoolIdentifier					,
@requireResourceIPValidation			,
@actorUserName							,
@actorPersonIdentifier		