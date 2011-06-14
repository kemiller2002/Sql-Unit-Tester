 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[InsertTestTimeBlock]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[InsertTestTimeBlock] AS

SELECT ''SPROC Template'''
GO


ALTER PROCEDURE [dbo].[InsertTestTimeBlock]
(
    @resourceIdentifier          uniqueidentifier = NULL,
    @resourceProviderIdentifier  uniqueidentifier = NULL,
    @providerResourceIdentifier  external_identifier = NULL,
    @providerTimeBlockIdentifier external_identifier = NULL,
    @startDateTime               date,
    @durationInMinutes           duration,
    @totalSeats                  smallint,
    @timeBlockIdentifier         uniqueidentifier = NULL,
    @actorUserName               user_id,
    @actorPersonIdentifier       uniqueidentifier
)
AS

EXEC EventManager.dbo.[InsertTimeBlock]
@resourceIdentifier						,  
@resourceProviderIdentifier				,
@providerResourceIdentifier				,
@providerTimeBlockIdentifier			,
@startDateTime							,
@durationInMinutes						,
@totalSeats								,
@timeBlockIdentifier					,
@actorUserName							,
@actorPersonIdentifier					
