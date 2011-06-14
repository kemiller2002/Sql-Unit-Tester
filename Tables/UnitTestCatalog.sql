 IF NOT EXISTS (SELECT * FROM sys.tables where name = 'UnitTestCatalog')
BEGIN
	CREATE TABLE UnitTestCatalog
	(
		Name		NVARCHAR(75)	NOT NULL PRIMARY KEY,
		Application VARCHAR(20)		NOT NULL CONSTRAINT FK_Application_Application REFERENCES Application(Application)
	)
END