 GO
IF NOT EXISTS(SELECT * FROM sys.types WHERE name = 'national_identification_number')
BEGIN
	CREATE TYPE [dbo].[national_identification_number] FROM [nvarchar](9) NULL
END