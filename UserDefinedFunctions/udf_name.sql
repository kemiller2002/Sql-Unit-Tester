 GO
IF NOT EXISTS(SELECT * FROM sys.types WHERE name = 'name')
BEGIN
	CREATE TYPE [dbo].[name] FROM [nvarchar](80) NULL
END