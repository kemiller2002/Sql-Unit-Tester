 IF NOT EXISTS(SELECT * FROM sys.types WHERE name = 'external_identifier')
BEGIN
/****** Object:  UserDefinedDataType [dbo].[external_identifier]    Script Date: 05/21/2009 13:00:45 ******/
CREATE TYPE [dbo].[external_identifier] FROM [nvarchar](400) NULL
END