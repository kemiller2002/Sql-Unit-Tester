 GO
IF NOT EXISTS(SELECT * FROM sys.types WHERE name = 'long_text')
BEGIN
	CREATE TYPE [dbo].[long_text] FROM [nvarchar](3000) NULL
END