 
GO
IF NOT EXISTS(SELECT * FROM sys.types WHERE name = 'address')
BEGIN
	CREATE TYPE [dbo].[address] FROM [nvarchar](100) NULL
END