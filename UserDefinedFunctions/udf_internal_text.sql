 GO
IF NOT EXISTS(SELECT * FROM sys.types WHERE name = 'internal_text')
BEGIN
	CREATE TYPE [dbo].[internal_text] FROM [nvarchar](100) NOT NULL
END