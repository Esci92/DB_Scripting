--#/--------------------------------------------------------------------------------------/
--#/ # MSSQL Server - Constraint / Index / FK - Alarm Datenbank					              /
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
	add constraint CK_gnumbe