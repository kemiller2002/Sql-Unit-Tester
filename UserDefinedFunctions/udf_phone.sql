 GO
IF NOT EXISTS(SELECT * FROM sys.types WHERE name = 'phone')
BEGIN
	CREATE TYPE [dbo].[phone] FROM [varchar](40) NULL
END