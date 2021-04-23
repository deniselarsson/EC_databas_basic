USE master;
GO

DROP DATABASE ECUtbildning;
GO

CREATE DATABASE ECUtbildning;
GO

USE ECUtbildning;

CREATE TABLE Ort(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Namn varchar(100)NOT NULL
);

CREATE TABLE Utbildning(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Namn varchar (100)NOT NULL
);

CREATE TABLE Anstalld(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Fornamn varchar (100) NOT NULL,
	Efternamn varchar (100) NOT NULL,
	Adress varchar (100) NOT NULL,
	PostNr char(6) NOT NULL,
	Ort varchar(100) NOT NULL
);

CREATE TABLE Kurs(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Namn varchar (100)NOT NULL
);

CREATE TABLE Klass(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	OrtId INT NOT NULL,
	UtbildningId INT NOT NULL,
	UtbildningledareId INT NOT NULL,
	Start date, 
	Slut date,
	
	CONSTRAINT FK_Klass_OrtId FOREIGN KEY (OrtId) REFERENCES Ort(Id),
	CONSTRAINT FK_Klass_UtbildningId FOREIGN KEY (UtbildningId) REFERENCES Utbildning(Id),
	CONSTRAINT FK_Klass_UtbildningledareId FOREIGN KEY (UtbildningledareId) REFERENCES Anstalld(Id)
);

CREATE TABLE UtbildningKurs(
	UtbildningId INT NOT NULL,
	KursId INT NOT NULL,

	CONSTRAINT FK_UtbildningKurs_UtbildningId FOREIGN KEY (UtbildningId) REFERENCES Utbildning(Id),
	CONSTRAINT FK_UtbildningKurs_KursId FOREIGN KEY (KursId) REFERENCES Kurs(Id)
);

CREATE TABLE KlassKurs(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	KlassId INT NOT NULL,
	KursId INT NOT NULL,
	LarareId INT NOT NULL,
	Start date,
	Slut date,
	
	CONSTRAINT FK_KlassKurs_KursId FOREIGN KEY (KursId) REFERENCES Kurs(Id),
	CONSTRAINT FK_KlassKurs_KlassId FOREIGN KEY (KlassId) REFERENCES Klass(Id),
	CONSTRAINT FK_KlassKurs_LarareId FOREIGN KEY (LarareId) REFERENCES Anstalld(Id)
);


CREATE TABLE Studerande(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	KlassId INT NOT NULL,
	Fornamn varchar (100) NOT NULL,
	Efternamn varchar (100) NOT NULL,
	Adress varchar (100) NOT NULL,
	PostNr char(6) NOT NULL,
	Ort varchar (100) NOT NULL,
	
	CONSTRAINT FK_Studerande_KlassId FOREIGN KEY (KlassId) REFERENCES Klass(Id)
);

CREATE TABLE Betyg(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	KlassKursId INT NOT NULL,
	StuderandeId INT NOT NULL,
	Betyg char (2),
	Datum date,
	
	CONSTRAINT FK_Betyg_KlassKursId FOREIGN KEY (KlassKursId) REFERENCES KlassKurs(Id),
	CONSTRAINT FK_Betyg_StuderandeId FOREIGN KEY (StuderandeId) REFERENCES Studerande(Id)
);

CREATE TABLE InAktivStuderande (
	Id INT PRIMARY KEY,
	KlassId INT NOT NULL,
	Fornamn varchar (100) NOT NULL,
	Efternamn varchar (100) NOT NULL,
	Adress varchar (100) NOT NULL,
	PostNr char(6) NOT NULL,
	Ort varchar (100),
	
	CONSTRAINT FK_InAktivStuderande_KlassId FOREIGN KEY (KlassId) REFERENCES Klass(Id)
);

CREATE TABLE InAktivBetyg(
	KlassKursId INT NOT NULL,
	InAktivStuderandeId INT NOT NULL,
	KursBetyg char (2) NOT NULL,
	Datum date,
	
	CONSTRAINT FK_InAktivBetyg_KlassKursId FOREIGN KEY (KlassKursId) REFERENCES KlassKurs(Id),
	CONSTRAINT FK_InAktivBetyg_InAktivStuderandeId FOREIGN KEY (InAktivStuderandeId) REFERENCES InAktivStuderande(Id)
	
);
