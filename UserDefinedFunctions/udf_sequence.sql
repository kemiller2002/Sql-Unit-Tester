 GO
IF NOT EXISTS(SELECT * FROM sys.types WHERE name = 'sequence')
BEGIN
	CREATE TYPE [dbo].[sequence] FROM [smallint] NOT NULL
END