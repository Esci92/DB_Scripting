use Alarm;
go

alter table Gruppe
	add constraint uq_gnumber unique (gnumber);

alter table "Medium"
	add constraint uq_type unique ("type");
