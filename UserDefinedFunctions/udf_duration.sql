 
GO
IF NOT EXISTS(SELECT * FROM sys.types WHERE name = 'duration')
BEGIN
CREATE TYPE [dbo].[duration] FROM [smallint] NULL
END