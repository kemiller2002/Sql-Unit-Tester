 IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[t_SelectResourceByFuzzyNameAndResourceProvider_ProviderNotActive]') 
	AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
EXEC sp_executesql N'CREATE PROCEDURE [dbo].[t_SelectResourceByFuzzyNameAndResourceProvider_ProviderNotActive] AS

SELECT ''SPROC Template'''
GO

ALTER PROCEDURE [t_SelectResourceByFuzzyNameAndResourceProvider_ProviderNotActive]
	@OutputResult INT OUTPUT,
	@OutPutMessage VARCHAR(1000) OUTPUT
AS

DECLARE @ResourceProviderIdentifier UNIQUEIDENTIFIER
DECLARE @ResourceCount INT

--Get ID Because Insertion is randomized.
SELECT TOP 1 @ResourceProviderIdentifier = ResourceProviderIdentifier 
	FROM EventManager.dbo.ResourceProvider WHERE ActiveStatusInternalIdentifier = 2


--Get Count that should return.
SELECT	@ResourceCount = COUNT(*) 

FROM	EventManager.dbo.Resource r 
	LEFT JOIN EventManager.dbo.ResourceProvider rp	ON 
		r.ResourceProviderInternalIdentifier = rp.ResourceProviderInternalIdentifier

WHERE	rp.ResourceProviderIdentifier = @ResourceProviderIdentifier


SELECT * INTO #Resource FROM CreateResourceTable()

BEGIN TRY

	INSERT #Resource
		EXEC eventmanager.dbo.SelectResourceByFuzzyNameAndProvider '', @ResourceProviderIdentifier

END TRY
BEGIN CATCH

	IF @@ERROR <> 0
	BEGIN
		SET @OutputResult = -1
		SET @OutPutMessage = 'Resource table population error'
	END



END CATCH


DECLARE @count INT

SELECT @count = COUNT(*) FROM #Resource


IF @Count = @ResourceCount AND @OutputResult <> -1
	SET @OutputResult	= 1
ELSE IF @OutputResult <> -1
BEGIN
	SET @OutputResult	= -1
	SET @OutPutMessage  = 'Exepected does not meet actual count. Expected: ' + 
		CAST(@ResourceCount AS VARCHAR) + ' Actual: ' + @Count
END
DROP TABLE #Resource