 
GO
IF NOT EXISTS(SELECT * FROM sys.types WHERE name = 'statistic')
BEGIN
	CREATE TYPE [dbo].[statistic] FROM [decimal](9, 6) NOT NULL
END