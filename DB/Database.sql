--#/--------------------------------------------------------------------------------------/
--#/ # MSSQL Server - SQL um die DB Strucktur aufzubauen - Alarm Datenbank	              /
--#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
--#/--------------------------------------------------------------------------------------/
-------------------------------------- SQL -----------------------------------------------

-- Erstellen der DB
create Database Alarm;
go

-- Benutzen der DB
use Alarm;
go

-- Erstellen der Tabelle AlarmStat
create table AlarmStat(
	AlarmStatID		int	identity(1,1)	not null,
	tstamp			int					not null,
	sstamp			int					not null,
	msg				varchar(90)			not null,
	launchedby		varchar(30)			not null,
	alrname			varchar(30)			not null,
	alrnumber		int					not null,
	GruppeID		int					not null,
	constraint PK_AlarmStatID primary key (AlarmStatID)
);
go

-- Erstellen der Tabelle Gruppe
create table Gruppe(
	GruppeID		int	identity(1,1)	not null,
	GName			varchar(45)			not null,
	GNumber			int					not null,
	constraint PK_GruppeID primary key (GruppeID)
);
go

-- Erstellen der Tabelle BenutzerGruppe
create table BenutzerGruppe(
	BenutzerGruppeID	int	identity(1,1)	not null,
	BenutzerID			int					not null,
	GruppeID			int					not null,
	constraint PK_BenutzerGruppeID primary key (BenutzerGruppeID)
);
go

-- Erstellen der Tabelle Benutzer
create table Benutzer(
	BenutzerID		int	identity(1,1)	not null,
	Nachname		varchar(45)			not null,
	Vorname			varchar(45)			not null,
	constraint PK_BenutzerID primary key (BenutzerID)
);
go

-- Erstellen der Tabelle MediumBenutzer
create table MediumBenutzer(
	MediumBenutzerID		int	identity(1,1)	not null,
	MediumID				int					not null,
	BenutzerID				int					not null,
	Kontakt					Varchar(60)			not null,
	constraint PK_MediumBenutzerID primary key (MediumBenutzerID)
);
go

-- Erstellen der Tabelle Medium
create table "Medium"(
	MediumID		int	identity(1,1)	not null,
	"Type"			varchar(10)			not null,
	constraint PK_MediumID primary key (MediumID)
);
go
