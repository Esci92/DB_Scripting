create procedure uspMediumInsert(@Type varchar(10))
as
begin
	-- Insert wenn nicht vorhanden
	set nocount on; 
	if not exists (select "Type" from "Medium" where "Type" = @Type) begin
		set nocount off; -- Für Powershell Rückgabewert
		insert into "Medium" ("Type")
		values (@Type);
		end
end
go

create procedure uspGruppeUpdateInsert(@GName varchar(45), @GNumber int)
as
begin
	-- Insert wenn Gruppennummer nicht vorhanden ist
	
	set nocount on;
	if not exists (select GName, GNumber from Gruppe where GNumber = @GNumber) begin
		set nocount off; -- Für Powershell Rückgabewert
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

create procedure uspAlarmStatInsert(@tstamp int, @sstamp int, @msg varchar(90), @launchedby varchar(30), @alrname varchar(30), @alrnumber int, @GruppenID int)
as
begin
	-- Insert AlarmStat
	set nocount off; -- Für Powershell Rückgabewert
	insert into AlarmStat (tstamp, sstamp, msg, launchedby, alrname, alrnumber, GruppenID)
	values (@tstamp, @sstamp, @msg, @launchedby, @alrname, @alrnumber, (select GruppenID from Gruppe where GNumber = 8));
	end
go 

drop procedure uspBenutzerUpdateInsert
create procedure uspBenutzerUpdateInsert(@Vorname varchar(45), @Nachname varchar(45), @Kontakt varchar(60), @Medium varchar(10))
as
begin
	-- Insert wenn Benutzer nicht vorhanden ist
	
	set nocount on;
	
	-- Insert new Medium
	if	exists (select Vorname, Nachname, Kontakt, "Type" from Benutzer 
		join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
		join "Medium" on "Medium".MediumID = MediumBenutzer.MediumID 
		where Kontakt = @Kontakt and "Type" != @Medium )begin
        set nocount off; -- Für Powershell Rückgabewert
		
		print 'Insert new Medium' 

		insert into MediumBenutzer (BenutzerID, MediumID, Kontakt )
		values ((select Benutzer.BenutzerID from Benutzer 
			join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
			where Kontakt = @Kontakt), (select MediumID from "Medium" where "Type" = @Medium), @Kontakt);
		end

	-- Update anhand des Namens
	else if	exists (select Vorname, Nachname, Kontakt, "Type" from Benutzer 
		join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
		join "Medium" on "Medium".MediumID = MediumBenutzer.MediumID 
		where Vorname = @Vorname and Nachname = @Nachname and Kontakt != @Kontakt and "Type" = @Medium)begin
        set nocount off; -- Für Powershell Rückgabewert
		
		insert into MediumBenutzer (BenutzerID, MediumID, Kontakt )
		values ((select distinct (Benutzer.BenutzerID) from Benutzer 
			join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
			where Vorname = @Vorname and Nachname = @Nachname ), 
			(select MediumID from "Medium" where "Type" = @Medium), @Kontakt);
		end

	-- Anlegen User und Type
	else if	not exists (select Vorname, Nachname, Kontakt, "Type" from Benutzer 
		join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
		join "Medium" on "Medium".MediumID = MediumBenutzer.MediumID 
		where Kontakt = @Kontakt and "Type" = @Medium)begin
        set nocount off; -- Für Powershell Rückgabewert
		
		insert into Benutzer (Vorname, Nachname )
		values (@Vorname, @Nachname);

		print 'Anlegen User und Type' 
		print @Kontakt
		print @Medium
		select Vorname, Nachname, Kontakt, "Type" from Benutzer 
		join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
		join "Medium" on "Medium".MediumID = MediumBenutzer.MediumID 
		where Kontakt = @Kontakt and "Type" = @Medium

		DECLARE @IDBenutzer BIGINT
		SELECT @IDBenutzer = SCOPE_IDENTITY()

		insert into MediumBenutzer (BenutzerID, MediumID, Kontakt )
		values (@IDBenutzer, (select MediumID from "Medium" where "Type" = @Medium), @Kontakt);
		end

	-- Update name 
	else if	exists (select distinct Vorname, Nachname, Kontakt, "Type" from Benutzer 
		join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
		join "Medium" on "Medium".MediumID = MediumBenutzer.MediumID 
		where Kontakt = @Kontakt and "Type" = @Medium)begin
        set nocount off; -- Für Powershell Rückgabewert
		
		print 'Update' 

		Update Benutzer 
		set Vorname = @Vorname, Nachname = @Nachname
		where BenutzerID = (select distinct Benutzer.BenutzerID from Benutzer 
			join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
			join "Medium" on "Medium".MediumID = MediumBenutzer.MediumID 
			where Kontakt = @Kontakt and "Type" = @Medium)
		end
end
go 

exec uspBenutzerUpdateInsert exec uspBenutzerUpdateInsert @Vorname = '',@Nachname = 'A2 / DECT 1 2562',@Kontakt = '82562',@Medium = 'OAP'

exec uspGruppeUdateInsert @tstamp, @sstamp, @msg, @launchedby, @alrname, @alrnumber, @GruppenID )

exec uspGruppeUdateInsert	@Gname = '3', @Gnumber = 34

drop procedure uspGruppeUdateInsert  

exec uspAlarmStatInsert @tstamp = 1571908429,@sstamp = 1571908429,@msg = 'as',@launchedby = 'ESPA',@alrname = 'Patientenruf A1',@alrnumber = 8201,@GruppenID = 8

select * from Gruppe

