 --delete from unittest where name = 'SelectAllResources'
--InsertNewUnitTest 'SelectAllResource_UnitTest', 'EvM'

DECLARE @ID UNIQUEIDENTIFIER

EXEC LoadTests NULL,'EvM', @RunID = @ID OUTPUT


EXEC RunUnitTests @ID


EXEC SelectTestResults @ID