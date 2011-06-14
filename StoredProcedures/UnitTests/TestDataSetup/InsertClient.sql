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

    declare @ProductInternalIdentifier identifier

    SELECT 
        @ProductInternalIdentifier = ProductView.ProductInternalIdentifier
    FROM
        ProductView
    WHERE
        ProductView.ProductIdentifier = @productIdentifier
    
    IF @ProductInternalIdentifier IS NULL BEGIN
        return PanCoreAdmin.dbo.GetErrorIdentifier( 'ProductDoesNotExist')
    END
    ELSE
    BEGIN
        INSERT INTO Client
            (Name, 
            ProductInternalIdentifier, 
            ShowZeroAvailabilityResources,
            NoShowInterval,
            UseProctorConsole,
            OuterRadius,
            NumberOfDaysToSearch,
            RequireLateWaiver,
            LateWaiverCustomText,
            CreationUser)
        VALUES
            (@name,
            @ProductInternalIdentifier,
            @showZeroAvailabilityResources,
            @noShowInterval,
            @useProctorConsole,
            @outerRadius,
            @numberOfDaysToSearch,
            @requireLateWaiver,
            @lateWaiverCustomText,
            @actorUserName)

        DECLARE @ClientIdentifier uniqueidentifier

        SELECT 
            @ClientIdentifier = ClientIdentifier
        FROM 
            Client with (nolock)
        WHERE 
            Client.ClientInternalIdentifier = scope_identity()

        SELECT @ClientIdentifier as Identifier

        RETURN 0
    END

