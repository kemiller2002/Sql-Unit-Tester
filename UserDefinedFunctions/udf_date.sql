 
GO
IF NOT EXISTS(SELECT * FROM sys.types WHERE name = 'date')
BEGIN
	CREATE TYPE [dbo].[date] FROM [datetime] NULL
END
