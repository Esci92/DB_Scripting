--#/--------------------------------------------------------------------------------------/
--#/ # MSSQL Server - Views - Alarm Datenbank		                                      /
--#/ Semester Arbeit - Christian Escolano / Robert Mulder                                 /
--#/--------------------------------------------------------------------------------------/
------------------------------- Views -----------------------------------------------------

-- Benutzen der DB
use Alarm;
go

-- Finden der meist ausgelösene gruppe
CREATE view vMaxAusgeloeseneGruppe 
AS
	select GNumber,Gname,COUNT(*) anzahl from AlarmStat 
	join Gruppe on Gruppe.GruppeID = AlarmStat.GruppeID
	group by AlarmStat.GruppeID, Gname, GNumber
	having COUNT(*) = 
	(select max(a) from 
	(select GruppeID, COUNT(*) a from AlarmStat group by GruppeID) aa)
go

-- Finden der am wenigsten ausgelösene gruppe
CREATE view vMinAusgeloeseneGruppe 
AS
	select GNumber,Gname,COUNT(*) anzahl from AlarmStat 
	join Gruppe on Gruppe.GruppeID = AlarmStat.GruppeID
	group by AlarmStat.GruppeID, Gname, GNumber
	having COUNT(*) = 
	(select min(a) from 
	(select GruppeID, COUNT(*) a from AlarmStat group by GruppeID) aa)
go

-- Finden der am meist ausgelösener Alarm
CREATE view vMaxAusgeloeseneAlarm
AS
	select alrnumber,alrname,COUNT(*) anzahl from AlarmStat 
	group by alrnumber,alrname
	having COUNT(*) = 
	(select max(a) from 
	(select alrnumber, COUNT(*) a from AlarmStat group by alrnumber) aa)
go

-- Finden der am wenigsten ausgelösener Alarm
CREATE view vMinAusgeloeseneAlarm
AS
	select alrnumber,alrname,COUNT(*) anzahl from AlarmStat 
	group by alrnumber,alrname
	having COUNT(*) = 
	(select min(a) from 
	(select alrnumber, COUNT(*) a from AlarmStat group by alrnumber) aa)
go

-- Finden der des User/Schnittstelle die die meisten Alarme ausgelöset hat
CREATE view vMaxLanuchedBy
AS
	-- am wenigsten ausgelösene gruppe
	select launchedby ,COUNT(*) anzahl from AlarmStat 
	group by launchedby
	having COUNT(*) = 
	(select max(a) from 
	(select launchedby, COUNT(*) a from AlarmStat group by launchedby) aa)
go

-- Finden der Gruppe mit den meisten Usern
CREATE view vMaxUserinGruppe
AS
	select GNumber,GName,count(*) anzahl from Gruppe 
	join BenutzerGruppe on Gruppe.GruppeID = BenutzerGruppe.GruppeID 
	join Benutzer on BenutzerGruppe.BenutzerID = Benutzer.BenutzerID group by Gruppe.GNumber, GName
	having count(*) = 
	(select max(a) from
	(select GNumber,count(*) a from Gruppe 
	join BenutzerGruppe on Gruppe.GruppeID = BenutzerGruppe.GruppeID 
	join Benutzer on BenutzerGruppe.BenutzerID = Benutzer.BenutzerID group by Gruppe.GNumber) aa)
go

-- Finden der Gruppe mit den wenigsten Usern
CREATE view vMinUserinGruppe
AS
	select GNumber,GName,count(*) anzahl from Gruppe 
	join BenutzerGruppe on Gruppe.GruppeID = BenutzerGruppe.GruppeID 
	join Benutzer on BenutzerGruppe.BenutzerID = Benutzer.BenutzerID group by Gruppe.GNumber, GName
	having count(*) = 
	(select min(a) from
	(select GNumber,count(*) a from Gruppe 
	join BenutzerGruppe on Gruppe.GruppeID = BenutzerGruppe.GruppeID 
	join Benutzer on BenutzerGruppe.BenutzerID = Benutzer.BenutzerID group by Gruppe.GNumber) aa)
go

-- Finden des Altesten Alarms
CREATE view vErsterAusgeloesterAlarm
AS
	select alrnumber, alrname, dbo.fTimeStampToDate(tstamp) Datum from AlarmStat 
	group by tstamp, alrnumber, alrname
	having tstamp = 
	(select min(tstamp) from 
	(select tstamp from AlarmStat group by tstamp) aa)
go

-- Finden des Jungsten Alarms
CREATE view vLetzterAusgeloesterAlarm
AS
	select alrnumber, alrname, dbo.fTimeStampToDate(tstamp) Datum from AlarmStat 
	group by tstamp, alrnumber, alrname
	having tstamp = 
	(select max(tstamp) from 
	(select tstamp from AlarmStat group by tstamp) aa)
go

-- Finden des Mediums der am meisten verwendet wird
CREATE view vMaxVerwendetesMedium
AS
	select "Type",count(*) Anzahl from Benutzer
		join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
		join "Medium" on "Medium".MediumID = MediumBenutzer.MediumID 
		left Join BenutzerGruppe on  Benutzer.BenutzerID = BenutzerGruppe.BenutzerID  group by "Type"
		having count(*) = 
		(select max(a) from
		(select "Type",count(*) a from Benutzer
		join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
		join "Medium" on "Medium".MediumID = MediumBenutzer.MediumID 
		left Join BenutzerGruppe on  Benutzer.BenutzerID = BenutzerGruppe.BenutzerID  group by "Type") aa)
go

-- Finden des Mediums der am wenigsten verwendet wird
CREATE view vMinVerwendetesMedium
AS
	select "Type",count(*) Anzahl from Benutzer
		join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
		join "Medium" on "Medium".MediumID = MediumBenutzer.MediumID 
		left Join BenutzerGruppe on  Benutzer.BenutzerID = BenutzerGruppe.BenutzerID  group by "Type"
		having count(*) = 
		(select min(a) from
		(select "Type",count(*) a from Benutzer
		join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
		join "Medium" on "Medium".MediumID = MediumBenutzer.MediumID 
		left Join BenutzerGruppe on  Benutzer.BenutzerID = BenutzerGruppe.BenutzerID  group by "Type") aa)
go

-- Finden der User die nicht verwendet werden
CREATE view vNichtVerwendeteUser
AS
	select Benutzer.BenutzerID, Vorname, Nachname, "Type"  from Benutzer 
		join MediumBenutzer on Benutzer.BenutzerID = MediumBenutzer.BenutzerID
		join "Medium" on "Medium".MediumID = MediumBenutzer.MediumID 
		left Join BenutzerGruppe on  Benutzer.BenutzerID = BenutzerGruppe.BenutzerID
		where BenutzerGruppe.BenutzerID is Null
go

-- Finden von usern mit leeren Namen/Vornamen
CREATE view vLeereNamen
AS
	select BenutzerID,Vorname,Nachname from Benutzer 
	where Vorname = '' or Nachname = ''
go

-- Finden des Alarms der am meisten Zeitverbraucht hat, bis er alarmiert hat.
CREATE view vLangsamsterAlarm
AS
	select Distinct alrnumber, alrname, abs(tstamp - sstamp) sekunden from AlarmStat 
	group by tstamp, alrnumber, alrname,sstamp
	having (tstamp - sstamp) = 
	(select max(a) from 
	(select (tstamp - sstamp) a from AlarmStat) aa)
go

-- Finden des Alarms der am wenigsten Zeitverbraucht hat, bis er alarmiert hat.
CREATE view vSchnellsterAlarm
AS
	select Distinct alrnumber, alrname, abs(tstamp - sstamp) sekunden from AlarmStat 
	group by tstamp, alrnumber, alrname,sstamp
	having (tstamp - sstamp) = 
	(select min(a) from 
	(select (tstamp - sstamp) a from AlarmStat) aa)
go
