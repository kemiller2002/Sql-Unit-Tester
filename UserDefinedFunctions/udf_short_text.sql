 
GO
IF NOT EXISTS(SELECT * FROM sys.types WHERE name = 'short_text')
BEGIN
	CREATE TYPE [dbo].[short_text] FROM [nvarchar](200) NULL
END