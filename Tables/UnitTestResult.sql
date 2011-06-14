 IF NOT EXISTS (SELECT * FROM sys.tables where name = 'UnitTestResult')
BEGIN

	CREATE TABLE UnitTestResult
	(
		ID				INT IDENTITY(1,1),
		RunID			UNIQUEIDENTIFIER	NOT NULL,
		UnitTestName	NVARCHAR(75)		NOT NULL 
			CONSTRAINT FK_UnitTest_ID REFERENCES UnitTestCatalog(Name),
		LoadDateTime	DATETIME			NOT NULL DEFAULT(GETDATE()),
		RunDateTime		DATETIME			NULL,
		FinishDateTime	DATETIME			NULL,
		Message			VARCHAR(1000)		NULL,
		Result			INT					NOT NULL 
			DEFAULT(0)
	)

END