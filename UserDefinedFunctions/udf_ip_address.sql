 GO
IF NOT EXISTS(SELECT * FROM sys.types WHERE name = 'ip_address')
BEGIN
	CREATE TYPE [dbo].[ip_address] FROM [varchar](15) NULL
END