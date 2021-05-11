use [Cars]
go

--validate engine
create function validateEngine(@n int)
returns int as
begin
	declare @ok int
	if @n>=1 and @n<=4
		set @ok=1
	else
		set @ok=0
	return @ok
end 
go

--validate varchar
create function validateVC(@v varchar(50))
returns int as
begin
	declare @ok int
	if @v like '[a-z]%[a-z]'
		set @ok=1
	else 
		set @ok=0
	return @ok
end
go

create procedure addCar @cid int, @brand varchar(50), @year int, @eID int, @wheels varchar(50), @seat int, @type int
as 
begin 
	if dbo.validateVC(@brand)=1 and dbo.validateEngine(@eID)=1
	begin 
		set identity_insert Car on
		INSERT INTO Car(cid, brand, year, engineId, Wheels, Seats, Type) values (@cid, @brand, @year, @eID, @wheels, @seat, @type)
		print 'values added'
	end
	else
	begin
		print 'sth went wrong'
	end
end 
go

exec addCar 14, 'added brand', 2000, 1, 'wheels add', 1, 1
select * from Car

--Views
create view viewAll
as
	select * from Car
go

create view viewSelect
as
	select*
	from Car
	where Car.year>2005 and Car.engineId in (select Engine.eID 
	from Engine) and Car.Type in (select typeid 
								  from CarTypes
								  Where CarTypes.typeid=3) and Car.Seats in (select seats_id	
																			 from TypeOfSeats
																			 where TypeOfSeats.seats_id= 5)

go 

create table Logs(
TriggerDate datetime,
TriggerType varchar(50),
NameAffectedTable varchar(50),
NoAMDRows int)
go

create trigger addCarTrigger on Car for insert as
begin
	insert into Logs(TriggerDate, TriggerType, NameAffectedTable, NoAMDRows)
	values(getdate(), 'add', 'Car', @@ROWCOUNT)
end
go

create trigger updateCarTrigger on Car for update as
begin
	insert into Logs(TriggerDate, TriggerType, NameAffectedTable, NoAMDRows)
	values(getdate(), 'update', 'Car', @@ROWCOUNT)
end
go

create trigger deleteCarTrigger on Car for delete as
begin
	insert into Logs(TriggerDate, TriggerType, NameAffectedTable, NoAMDRows)
	values(getdate(), 'delete', 'Car', @@ROWCOUNT)
end
go

select * from Car
select * from Logs
drop table Logs
select * from viewAll
select * from viewSelect
set identity_insert Car on
INSERT INTO Car(cid, brand, year, engineId, Wheels, Seats, Type) values (20, 'b added', 2012, 1, 'w added', 5, 2)

update Car
set brand='new brand'
where brand='brand1'

delete from Car where brand='new brand'