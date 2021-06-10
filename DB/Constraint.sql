--#/--------------------------------------------------------------------------------------/
--#/ # MSSQL Server - Constraint / Index / FK - Alarm Datenbank				              /
--#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
--#/--------------------------------------------------------------------------------------/
------------------------------------ Constraint -------------------------------------------

-- Benutzen der DB
use Alarm;
go

-- Unique Check in der DB der gnumber
alter table Gruppe
	add constraint uq_gnumber unique (gnumber);
go

-- Unique Check in der DB des Mediumstyp
alter table "Medium"
	add constraint uq_type unique ("type");
go

-- Check constraints gruppe von 10 - 9999
alter table Gruppe
	add constraint CK_gnumber check (gnumber between 10 and 9999);
go

------------------------------------- Indexes ---------------------------------------------

-- indexieren der Grupennummer in Gruppe
CREATE INDEX ix_Gruppe_gnumber
ON Gruppe(gnumber);
go

-- indexieren der Grupennummer in Alarmstat
CREATE INDEX ix_Alarmstat_GruppeID
ON Alarmstat(GruppeID);
go

-- indexieren der alrnumber in Alarmstat
CREATE INDEX ix_Alarmstat_alrnumber
ON Alarmstat(alrnumber);
go

--------------------------------------- FOREIGN KEYS -------------------------------------------

-- Erstellen GruppeID Referenz
alter table Alarmstat
	add constraint fk_Alarmstat_GruppeID FOREIGN KEY (GruppeID) REFERENCES Gruppe(GruppeID);
go

-- Erstellen GruppeID Referenz / BenutzerID Referenz
alter table BenutzerGruppe
	add constraint fk_BenutzerGruppe_GruppeID FOREIGN KEY (GruppeID) REFERENCES Gruppe(GruppeID),
		constraint fk_BenutzerGruppe_BenutzerID FOREIGN KEY (BenutzerID) REFERENCES Benutzer(BenutzerID);
go

-- Erstellen MediumID Referenz / BenutzerID Referenz
alter table MediumBenutzer
	add constraint fk_MediumBenutzer_BenutzerID FOREIGN KEY (BenutzerID) REFERENCES Benutzer(BenutzerID),
		constraint fk_MediumBenutzer_MediumID FOREIGN KEY (MediumID) REFERENCES "Medium"(MediumID);
go

