 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[InsertTestResourcePool]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[InsertTestResourcePool] AS

SELECT ''SPROC Template'''
GO


ALTER PROCEDURE [dbo].[InsertTestResourcePool]
(
    @name							short_text,
    @effectiveStartDate				datetime,
    @effectiveEndDate				datetime,
    @policyFileInternalIdentifier	identifier, 
    @actorUserName					user_id,
    @actorPersonIdentifier			uniqueidentifier
)
AS

EXEC EventManager.dbo.[InsertResourcePool]
@name							,
@effectiveStartDate				,
@effectiveEndDate				,
@policyFileInternalIdentifier	,
@actorUserName					,
@actorPersonIdentifier			