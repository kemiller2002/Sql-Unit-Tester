 IF NOT EXISTS (SELECT * FROM sys.tables where name = 'Application')
BEGIN
	CREATE Table Application
	(
		Application VARCHAR(20) NOT NULL PRIMARY KEY
	)

END