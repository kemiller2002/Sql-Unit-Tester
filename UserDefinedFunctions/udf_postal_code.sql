 GO
IF NOT EXISTS(SELECT * FROM sys.types WHERE name = 'postal_code')
BEGIN
	CREATE TYPE [dbo].[postal_code] FROM [nvarchar](20) NOT NULL
END