 
GO
IF NOT EXISTS(SELECT * FROM sys.types WHERE name = 'identifier')
BEGIN
	CREATE TYPE [dbo].[identifier] FROM [int] NULL
END