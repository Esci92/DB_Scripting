--#/--------------------------------------------------------------------------------------/
--#/ # MSSQL Server - Proceduren / Functionen - Alarm Datenbank	                          /
--#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
--#/--------------------------------------------------------------------------------------/
------------------------------- Proceduren -----------------------------------------------

-- Benutzen der DB
use Alarm;
go

-- Insert wenn das Medium nicht vorhanden ist
create procedure uspMediumInsert(@Type varchar(10))
as
begin
	set nocount on; 
	if not exists (select "Type" from "Medium" where "Type" = @Type) begin
		
		-- Für Powershell Rückgabewert
		set nocount off;

		insert into "Medium" ("Type")
		values (@Type);
		end
	end
go

-- Insert wenn Gruppennummer wenn nicht vorhanden und Update der Werte anhand der GruppenNumber
create procedure uspGruppeUpdateInsert(@GName varchar(45), @GNumber int)
as
begin

	-- Insert wenn Gruppennummer nicht vorhanden ist
	set nocount on;
	if not exists (select GName, GNumber from Gruppe where GNumber = @GNumber) begin
		set nocount off; -- Für Powershell Rückgabewert Aktivieren
		insert into Gruppe (GName, GNumber)
		values (@GName, @GNumber);
		end
	
	-- Update Value anhand der GruppenNumber
	else
		update Gruppe
		set GName = @GName
		where GNumber = @GNumber
	end
go 

-- Insert der Alarmstatistiken in die Tabelle
create procedure uspAlarmStatInsert(@tstamp int, @sstamp int, @msg varchar(90), @launchedby varchar(30), @alrname varchar(30), @alrnumber int, @GruppeID int)
as
begin
	-- Insert AlarmStat
	set nocount off; -- Für Powershell Rückgabewert
	insert into AlarmStat (tstamp, sstamp, msg, launchedby, alrname, alrnumber, GruppeID)
	values (@tstamp, @sstamp, @msg, @launchedby, @alrname, @alrnumber, (select GruppeID from Gruppe where GNumber = @GruppeID));
	end
go 

-- 
create procedure uspBenutzerUpdateInsert(@Vorname varchar(45), @Nachname varchar(45), @Kontakt varchar(60), @Medium varchar(10))
as
begin
	-- Insert wenn Benutzer nicht vorhanden ist
	set nocount on;
	
	-- Anlegen User und Type
	if	not exists (select Vorname, Nachname, Kontakt, "Type" from Benutzer 
		join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
		join "Medium" on "Medium".MediumID = MediumBenutzer.MediumID 
		where Vorname = @Vorname and Nachname = @Nachname)begin
        set nocount off; -- Für Powershell Rückgabewert
		
		-- Insert der Daten in die Benutzer Tabelle
		insert into Benutzer (Vorname, Nachname )
		values (@Vorname, @Nachname);

		-- erstellen und befühlen der letzen eingesetzten ID
		DECLARE @IDBenutzer BIGINT
		SELECT @IDBenutzer = SCOPE_IDENTITY()

		-- Insert des Medium / Benutzer mit der Mediums ID
		insert into MediumBenutzer (BenutzerID, MediumID, Kontakt )
		values (@IDBenutzer, (select MediumID from "Medium" where "Type" = @Medium), @Kontakt);
		end

	-- Insert new Medium
	else if	not exists (select Vorname, Nachname, Kontakt, "Type" from Benutzer 
		join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
		join "Medium" on "Medium".MediumID = MediumBenutzer.MediumID 
		where Vorname = @Vorname and Nachname = @Nachname  and "Type" = @Medium)begin
        
		-- Für Powershell Rückgabewert
		set nocount off; 
		
		-- Insert des MediumsBenutzer Zwischentabelle
		insert into MediumBenutzer (BenutzerID, MediumID, Kontakt )
		values ((select Distinct Benutzer.BenutzerID from Benutzer 
			join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
			where Kontakt = @Kontakt  or (Vorname = @Vorname and Nachname = @Nachname )), (select MediumID from "Medium" where "Type" = @Medium), @Kontakt);
		end

	-- Insert anhand des Namens
	else if	exists (select Vorname, Nachname, Kontakt, "Type" from Benutzer 
		join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
		join "Medium" on "Medium".MediumID = MediumBenutzer.MediumID 
		where Vorname = @Vorname and Nachname = @Nachname and Kontakt != @Kontakt and "Type" = @Medium)begin
        
		-- Für Powershell Rückgabewert
		set nocount off; 

		-- Insert anhand des Namens
		insert into MediumBenutzer (BenutzerID, MediumID, Kontakt )
		values ((select distinct (Benutzer.BenutzerID) from Benutzer 
			join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
			join "Medium" on "Medium".MediumID = MediumBenutzer.MediumID 
			where Vorname = @Vorname and Nachname = @Nachname and "Type" = @Medium ), 
			(select MediumID from "Medium" where "Type" = @Medium), @Kontakt);
		end

	-- Update name 
	else if	exists (select distinct Vorname, Nachname, Kontakt, "Type" from Benutzer 
		join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
		join "Medium" on "Medium".MediumID = MediumBenutzer.MediumID 
		where Kontakt = @Kontakt and "Type" = @Medium)begin

		 -- Für Powershell Rückgabewert
        set nocount off;

		-- Updaten des Datensatzes
		Update Benutzer 
		set Vorname = @Vorname, Nachname = @Nachname
		where BenutzerID = (select distinct Benutzer.BenutzerID from Benutzer 
			join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
			join "Medium" on "Medium".MediumID = MediumBenutzer.MediumID 
			where Kontakt = @Kontakt and "Type" = @Medium)
		end
	end
go 

-- Befühlung der BenutzerGruppe Tabelle 
create procedure uspBenutzerGruppeInsert(@GNumber int, @Kontakt varchar(60), @Medium varchar(10))
as
begin
	set nocount on;
	-- Insert wenn Kontakt, Type und Gruppenummer nicht vorhanden sind
	if not exists (select distinct Benutzer.BenutzerID from Benutzer
			join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
			join "Medium" on "Medium".MediumID = MediumBenutzer.MediumID
			join BenutzerGruppe on BenutzerGruppe.BenutzerID = Benutzer.BenutzerID
			join Gruppe on BenutzerGruppe.GruppeID = Gruppe.GruppeID
			where Kontakt = @Kontakt and "Type" = @Medium and Gruppe.GNumber = @GNumber )
			
		-- Für Powershell Rückgabewert
		set nocount off; 

		-- Insert Benutzer und Gruppen ID in die Datenbank
		insert into BenutzerGruppe (BenutzerID,GruppeID )
		values ((select distinct Benutzer.BenutzerID from Benutzer
			join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
			join "Medium" on "Medium".MediumID = MediumBenutzer.MediumID
			where Kontakt = @Kontakt and "Type" = @Medium),
			(select GruppeID from Gruppe where GNumber = @GNumber ));
	end
go 

------------------------------- Functionen -----------------------------------------------

-- Wandel eines Zeitstempls zum Datum
CREATE FUNCTION fTimeStampToDate (@timestamp int)
        RETURNS datetime
AS
BEGIN
        DECLARE @ret datetime
        SELECT @ret = DATEADD(second, @timestamp, '1970/01/01 00:00:00')
        RETURN @ret
END
GO