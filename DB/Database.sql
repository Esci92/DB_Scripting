create Database Alarm;
go

use Alarm;
go

create table AlarmStat(
	AlarmStatID		int	identity(1,1)	not null,
	tstamp			int					not null,
	sstamp			int					not null,
	estamp			int					not null,
	Datum			date				not null,
	msg				varchar(90)			not null,
	launchedby		varchar(30)			not null,
	alrname			varchar(30)			not null,
	alrnumber		int					not null,
	GruppenID		int					not null,
	constraint PK_AlarmStatID primary key (AlarmStatID)
);
go

create table Gruppe(
	GruppenID		int	identity(1,1)	not null,
	GName			varchar(45)			not null,
	GNumber			int					not null,
	constraint PK_GruppenID primary key (GruppenID)
);
go

create table BenutzerGruppe(
	BenutzerGruppeID	int	identity(1,1)	not null,
	BenutzerID			int					not null,
	GruppeID		int					not null,
	constraint PK_BenutzerGruppeID primary key (BenutzerGruppeID)
);
go

create table Benutzer(
	BenutzerID		int	identity(1,1)	not null,
	Nachnme			varchar(45)			not null,
	Vorname			varchar(45)			not null,
	constraint PK_BenutzerID primary key (BenutzerID)
);
go

create table MediumBenutzer(
	MediumBenutzerID		int	identity(1,1)	not null,
	MediumID				int					not null,
	BenutzerID				int					not null,
	Number					int					not null,
	constraint PK_MediumBenutzerID primary key (MediumBenutzerID)
);
go

create table "Medium"(
	MediumID		int	identity(1,1)	not null,
	"Type"			varchar(10)			not null,
	constraint PK_MediumID primary key (MediumID)
);
go