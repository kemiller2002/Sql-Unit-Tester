 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[InsertTestClient]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[InsertTestClient] AS

SELECT ''SPROC Template'''
GO


ALTER PROCEDURE [dbo].[InsertTestClient]
(
    @name                           short_text,
    @productIdentifier              uniqueIdentifier,
    @showZeroAvailabilityResources  bit,
    @noShowInterval					integer,
    @useProctorConsole				bit,
    @outerRadius                    SMALLINT,
    @numberOfDaysToSearch           TINYINT,
    @requireLateWaiver              bit,
    @lateWaiverCustomText           nvarchar(4000),
    @actorUserName                  user_id
)
AS

EXEC EventManager.dbo.[InsertClient]
 @name                          ,
 @productIdentifier             ,
 @showZeroAvailabilityResources ,
 @noShowInterval				,	
 @useProctorConsole				,
 @outerRadius                   ,
 @numberOfDaysToSearch          ,
 @requireLateWaiver             ,
 @lateWaiverCustomText          ,
 @actorUserName                 