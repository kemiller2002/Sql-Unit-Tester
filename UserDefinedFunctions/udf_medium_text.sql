 GO
IF NOT EXISTS(SELECT * FROM sys.types WHERE name = 'medium_text')
BEGIN
	CREATE TYPE [dbo].[medium_text] FROM [nvarchar](1024) NULL
END