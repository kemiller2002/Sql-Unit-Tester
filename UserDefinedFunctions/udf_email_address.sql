 
GO
IF NOT EXISTS(SELECT * FROM sys.types WHERE name = 'email_address')
BEGIN
	CREATE TYPE [dbo].[email_address] FROM [nvarchar](100) NULL
END