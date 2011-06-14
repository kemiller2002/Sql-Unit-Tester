 GO

IF NOT EXISTS(SELECT * FROM sys.objects WHERE name = 'CreateResourceTable')
BEGIN
	EXEC sp_executesql N'CREATE FUNCTION [dbo].CreateResourceTable () RETURNS @Resources TABLE(s varchar) AS BEGIN RETURN END'
END

GO

ALTER FUNCTION [dbo].[CreateResourceTable]
    ()
RETURNS @Resources TABLE   
(
		ResourceIdentifier						UNIQUEIDENTIFIER, 
        ResourceProviderIdentifier				UNIQUEIDENTIFIER, 
        ResourceProviderName					short_text, 
        ResourceTypeIdentifier					UNIQUEIDENTIFIER, 
        ResourceTypeName						short_text, 
        PersistentResource						BIT, 
        ResourceName							short_text, 
        LocationIdentifier						UNIQUEIDENTIFIER, 
        LocationName							short_text, 
        Address1								address, 
        Address2								address, 
        City									address, 
        StateOrProvince							address, 
        PostalCode								postal_code, 
        PostalCodeExtension						postal_code	NULL, 
        CountryInternalIdentifier				INT, 
        CountryTextInternalIdentifier			INT,
        CountryNameCode							NVARCHAR(40),
        GmtOffset								DECIMAL(4,2), 
        Phone									phone, 
		Fax										phone,
        ProviderResourceIdentifier				external_identifier,
        ShowZeroAvailability					BIT,
        IsWebCamCertified						BIT,
        WebCamBrand								short_text,
        WebCamModel								short_text,
        WebCamCertifierFirstName				short_text,
        WebCamCertifierLastName					name,
        WebCamCertifierUserName					name,
        WebCamCertifiedDateTime					DATETIME,
		ActiveStatusIdentifier					UNIQUEIDENTIFIER,
		Latitude								FLOAT,
		Longitude								FLOAT,
		ResourceInternalIdentifier				INT,
		ResourcePriority						INT,
		WaiveSchedulingRules					BIT
) AS

BEGIN


RETURN 

END
