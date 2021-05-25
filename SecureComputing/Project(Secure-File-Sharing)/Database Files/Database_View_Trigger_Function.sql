
USE SecureFileSharing 
GO 
CREATE VIEW ValidFiles AS
(
SELECT *
FROM Files 
WHERE   [Status] = '1'
);

GO 
CREATE VIEW ValidConnections AS
(
SELECT *
FROM Connections 
WHERE   [Status] = '1' AND
		CONVERT(DATETIME, ConnectionDate) >= DATEADD(minute, -10, GETDATE())
);

GO
IF OBJECT_ID (N'dbo.IsBan', N'FN') IS NOT NULL
	DROP FUNCTION IsBan;
GO
CREATE FUNCTION dbo.IsBan(@UName varchar(255))
RETURNS int
AS
BEGIN
	DECLARE @ret INT;
	DECLARE @BanLvl INT;
	DECLARE @StartBanTime DATETIME;

	SELECT @BanLvl=BanLvl , @StartBanTime=StartBanTime
	from BanUser
	WHERE UserID=(SELECT UserID FROM Users WHERE UserName=@UName)
	
	IF(@StartBanTime IS NULL OR @BanLvl=0)
		SET @ret=0;
	ELSE 
		SELECT @ret=DATEDIFF( minute, DATEADD(mi, POWER(2, @BanLvl), @StartBanTime), CURRENT_TIMESTAMP )
		
	RETURN @ret;
END;

GO
IF OBJECT_ID (N'dbo.FindLastFailedLogin', N'FN') IS NOT NULL
	DROP FUNCTION FindLastFailedLogin;
GO
CREATE FUNCTION dbo.FindLastFailedLogin(@UserName VARCHAR(255))
RETURNS INT
AS
BEGIN
	DECLARE @ret INT;
	DECLARE @OneDayBeforNow DATETIME;
	DECLARE @LastSuccessLogin DATETIME;
	DECLARE @MaxDate DATETIME;
	
	SELECT @OneDayBeforNow = DATEADD(DAY, -1, GETDATE())

	SELECT @LastSuccessLogin = RequestDate
	FROM LoginLogs
	WHERE UserName=@UserName AND [Status]='1';

	SELECT  @MaxDate=(	CASE 
						WHEN @LastSuccessLogin > @OneDayBeforNow THEN @LastSuccessLogin 
						ELSE @OneDayBeforNow END )

	SELECT @ret = count(*)
	FROM LoginLogs
	WHERE UserName=@UserName AND [Status]='0' AND RequestDate>@MaxDate;

	RETURN @ret;
END;

GO
IF OBJECT_ID (N'dbo.CheckPassHash', N'FN') IS NOT NULL
	DROP FUNCTION CheckPassHash;
GO
CREATE FUNCTION dbo.CheckPassHash(@UName VARCHAR(255), @PassHash VARCHAR(500))
RETURNS INT
AS
BEGIN

	DECLARE @ret int;
	SET @ret = 0;

	DECLARE @MyHash VARCHAR(500);

	SELECT @MyHash=PasswordHash 
	FROM Users
	WHERE UserName=@UName

	IF @MyHash = @PassHash
		SET @ret = 1;

	RETURN @ret;
END;

GO
CREATE TRIGGER AutoUpdateLastModified
ON Files
AFTER UPDATE AS  
  UPDATE Files
  SET LastModifiedDate = CURRENT_TIMESTAMP
  WHERE FileID IN (SELECT DISTINCT FileID FROM Inserted)

GO
CREATE TRIGGER AutoInsertBanUser
ON Users
AFTER INSERT AS
	Insert BanUser ( UserID, BanLvl)
		SELECT UserID,0 FROM Inserted