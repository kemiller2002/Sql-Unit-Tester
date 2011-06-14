 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[InsertTestResourcesIntoResourcePools]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[InsertTestResourcesIntoResourcePools] AS

SELECT ''SPROC Template'''
GO
ALTER PROCEDURE [dbo].[InsertTestResourcesIntoResourcePools]
AS

DECLARE @ResourcePoolInternalIdentifier INT
DECLARE @ResourceInternalIdentifier INT

SELECT @ResourcePoolInternalIdentifier = rp.ResourcePoolInternalIdentifier
FROM	EventManager.dbo.ResourcePool rp 
JOIN	EventManager.dbo.EventType et ON rp.ResourcePoolInternalIdentifier = et.ResourcePoolInternalIdentifier
WHERE
	et.Name = 'E:0:0:0:0:0:0:0'


SELECT @ResourceInternalIdentifier = ResourceInternalIdentifier FROM 
EventManager.dbo.Resource WHERE Name = 'R:0:0:0:0:0:0:0'


INSERT INTO EventManager.dbo.resourcepool_resource
(
	ResourcePoolInternalIdentifier,
	ResourceInternalIdentifier,
	CreationUser
)
VALUES
(
	@ResourcePoolInternalIdentifier,
	@ResourceInternalIdentifier,
	'kevin.miller'
)