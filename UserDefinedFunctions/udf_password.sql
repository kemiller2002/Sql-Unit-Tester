 GO
IF NOT EXISTS(SELECT * FROM sys.types WHERE name = 'password')
BEGIN
	CREATE TYPE [dbo].[password] FROM [nvarchar](64) NULL
END