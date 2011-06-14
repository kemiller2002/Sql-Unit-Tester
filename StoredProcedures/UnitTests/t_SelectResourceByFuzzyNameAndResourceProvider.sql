 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[t_SelectResourceByFuzzyNameAndResourceProvider]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[t_SelectResourceByFuzzyNameAndResourceProvider] AS

SELECT ''SPROC Template'''
GO

ALTER PROCEDURE [t_SelectResourceByFuzzyNameAndResourceProvider]
	@OutputResult INT OUTPUT,
	@OutPutMessage VARCHAR(1000) OUTPUT
AS

DECLARE @ResourceProviderIdentifier UNIQUEIDENTIFIER
DECLARE @ResourceCount INT
DECLARE @count INT

SELECT @ResourceProviderIdentifier = ResourceProviderIdentifier
FROM EventManager.dbo.ResourceProvider WHERE 
Name = 'RP:1:1'


--Get Count that should return.
SELECT	@ResourceCount = COUNT(*) 

FROM	EventManager.dbo.Resource r 
	LEFT JOIN EventManager.dbo.ResourceProvider rp	ON 
		r.ResourceProviderInternalIdentifier = rp.ResourceProviderInternalIdentifier

WHERE	rp.ResourceProviderIdentifier = @ResourceProviderIdentifier
AND		r.ActiveStatusInternalIdentifier = 1

SELECT * INTO #Resource FROM CreateResourceTable()

BEGIN TRY

	INSERT #Resource
		EXEC eventmanager.dbo.SelectResourceByFuzzyNameAndProvider '', @ResourceProviderIdentifier

END TRY
BEGIN CATCH
	SET @OutputResult = -1
	SET @OutPutMessage = 'Resource table population error'
END CATCH

BEGIN TRY

SELECT @count = COUNT(*) FROM #Resource

IF @Count = @ResourceCount AND @OutputResult <> -1
	SET @OutputResult	= 1
ELSE IF @OutputResult <> -1
BEGIN 
	SET @OutputResult	= -1
	SET @OutPutMessage	= 'Expected count does not meet actual count. Expected: ' 
		+ CAST(@ResourceCount AS VARCHAR) + ' Actual: ' + CAST(@Count AS VARCHAR)
END



END TRY
BEGIN CATCH
	SET @OutputResult = -1
	SET @OutPutMessage = 'Resource table population error'
END CATCH

DROP TABLE #Resource