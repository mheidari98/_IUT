
USE SecureFileSharing
GO 

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY, 
    UserName VARCHAR(50) NOT NULL,
    PasswordHash VARCHAR(200) NOT NULL,
    Salt VARCHAR(100) NOT NULL,
	ConfLable VARCHAR(1) CHECK(ConfLable in ('1','2','3','4') ),
	IntegrityLable VARCHAR(1) CHECK(IntegrityLable in ('1','2','3','4')),
    CreationDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Files (
    FileID INT IDENTITY(1,1) PRIMARY KEY, 
    [FileName] VARCHAR(50) NOT NULL,
    [FileCreatorID] INT NOT NULL,
	ConfLable VARCHAR(1) CHECK(ConfLable IN ('1','2','3','4') ),
	IntegrityLable VARCHAR(1) CHECK(IntegrityLable in ('1','2','3','4')),
	AccessMode INT DEFAULT 30,
	Content VARCHAR(1024),
	[Status] VARCHAR(1) CHECK([Status] IN ('1', '0') ),
	LastModifiedDate DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY ([FileCreatorID]) REFERENCES Users(UserID)
);

CREATE TABLE Connections (
	UserID INT,
	[Ip] VARCHAR(20),
	[Port] VARCHAR(10),
	AouthCode VARCHAR(100),
	[Status] VARCHAR(5) CHECK([Status] IN ('1', '0') ),
	ConnectionDate VARCHAR(30),
	ConnectionCloseDate VARCHAR(30),
	FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE AccessList (
    UserID INT , 
	FileID INT , 
	AccessType VARCHAR(1) CHECK(AccessType IN ('r','w') ),
	PRIMARY KEY(UserID, FileID, AccessType),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
	FOREIGN KEY (FileID) REFERENCES Files(FileID)
);

CREATE TABLE RegisterLogs (
    LogID INT IDENTITY(1,1) PRIMARY KEY, 
    UserName VARCHAR(50) NOT NULL,
	ConfLable VARCHAR(1) CHECK(ConfLable IN ('1','2','3','4') ),
	IntegrityLable VARCHAR(1) CHECK(IntegrityLable in ('1','2','3','4') ),
	[Status] VARCHAR(1) CHECK([Status] IN ('1', '0') ),
    RequestDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE LoginLogs (
    LogID INT IDENTITY(1,1) PRIMARY KEY, 
    UserName VARCHAR(50) NOT NULL,
	[Status] VARCHAR(1) CHECK([Status] in ('1', '0') ),
	[password] VARCHAR(200) NOT NULL,
	ConnectionIp VARCHAR(20) NOT NULL,
	ConnectionPort VARCHAR(20) NOT NULL,
	AuthenticationCode VARCHAR(100),
    RequestDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE PutLogs (
    LogID INT IDENTITY(1,1) PRIMARY KEY, 
    CreatorID INT,
	FileID INT,
	[FileName] VARCHAR(50) NOT NULL, 
	CurFileConfLable VARCHAR(1),
	CurFileIntegrityLable VARCHAR(1),
	Content VARCHAR(1024),
	[Status] VARCHAR(1) CHECK([Status] IN ('1', '0') ),
    RequestDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE GetLogs (
    LogID INT IDENTITY(1,1) PRIMARY KEY, 
    UserID INT,
	FileID INT,
	[FileName] VARCHAR(50) NOT NULL,
	CurFileConfLable VARCHAR(1),
	CurFileIntegrityLable VARCHAR(1),
	[Status] VARCHAR(1) CHECK([Status] IN ('1', '0') ),
    RequestDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ReadLogs (
    LogID INT IDENTITY(1,1) PRIMARY KEY, 
    UserID INT,
	FileID INT,
	[FileName] VARCHAR(50) NOT NULL,
	CurFileConfLable  VARCHAR(1),
	CurFileIntegrityLable VARCHAR(1),
	[Status] VARCHAR(5) CHECK([Status] IN ('1', '0') ),
    RequestDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE WriteLogs (
    LogID INT IDENTITY(1,1) PRIMARY KEY, 
    UserID INT,
	FileID INT,
	[FileName] VARCHAR(50) NOT NULL,
	CurFileConfLable VARCHAR(1),
	CurFileIntegrityLable VARCHAR(1),
	Content VARCHAR(1024),
	[Status] VARCHAR(5) CHECK([Status] IN ('1', '0') ),
    RequestDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE BanUser(
	UserID INT PRIMARY KEY,
	BanLvl INT NOT NULL DEFAULT 0,
	StartBanTime DATETIME, 
);

USE SecureFileSharing 
GO 
INSERT INTO Users ( UserName, PasswordHash, Salt, ConfLable, IntegrityLable)
		VALUES ('admin',
				'D84464181F7F019F3FB10E6BBD06F543D7AC84C4F8E360EBB9402A472AB30EBC', --SHA256(1234password)
				'1234', '4', '4' );
