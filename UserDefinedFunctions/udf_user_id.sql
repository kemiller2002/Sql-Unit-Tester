 
GO
IF NOT EXISTS(SELECT * FROM sys.types WHERE name = 'user_id')
BEGIN
	CREATE TYPE [dbo].[user_id] FROM [nvarchar](32) NULL
END