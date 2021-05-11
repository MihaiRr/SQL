use [Cars]
go

create table Version(version int)
insert into Version(version) values (0)
select * from Version
go

create procedure createTable
as 
begin
create table Owners(
oid int not null,
name varchar(50) not null)
print 'Table created succesfully'
end
go

create procedure undoCreateTable
as
begin
drop table Owners
print 'Table droped'
end 
go

create procedure addCol
as 
begin 
alter table Owners
add cid int not null 
print 'col added'
end
go

create procedure addPrimaryKey
as
begin
alter table Owners
add constraint pk_Owners primary key(oid)
print 'primary key added'
end
go

create procedure addForeignKey
as
begin
alter table Owners
add constraint fk_Owners foreign key (cid) references Car(cid)
print 'fk added'
end 
go

create procedure undoAddCol
as 
begin
alter table Owners
drop column cid
print 'column dropped'
end 
go

create procedure undoAddPrimaryKey
as
begin
alter table Owners
drop constraint pk_Owners
print 'Owners oid pk deleted'
end 
go

create procedure undoAddForeignKey
as
begin
alter table Owners
drop constraint fk_Owners
print 'Owner oid fk deleted'
end 
go

--test
exec createTable --1st step
select * from owners
exec undoCreateTable 
exec addCol
exec undoAddCol
exec addPrimaryKey
exec undoAddPrimaryKey
exec addForeignKey
exec undoAddForeignKey
--------------------------------------

create procedure changeVersion @version int
as 
begin
declare @current int
set @current =(Select version from Version)
if (@version < 0 or @version >4)
	begin
		print 'invalid'
		return
	end
while @current<@version
begin
	if (@current=0)
		begin
			exec createTable
			set @current=@current+1
		end
	else
	begin
		if (@current=1)
		begin
			exec addCol
			set @current=@current+1
		end
		else
		begin
			if (@current=2)
			begin
				exec addPrimaryKey
				set @current=@current+1
			end
			else
			begin 
				if (@current=3)
				begin
					exec addForeignKey
					set @current=@current+1
				end
			end
		end
	end
end
update Version
set version=@current
end
go

create procedure undoChangedVersion @version int
as 
begin
declare @current int
set @current=(Select version from Version)
if (@version < 0 or @version > 4)
		begin
			print 'invalid'
			return
		end
while (@current>@version)
begin
	if (@current=4)
		begin
			exec undoAddForeignKey
			set @current=@current - 1
		end
		else
		begin
			if (@current=3)
			begin
				exec undoAddPrimaryKey
				set @current=@current -1
			end
			else
			begin
			if (@current=2)
				begin
					exec undoAddCol
					set @current=@current -1
				end
				else
					begin
					if (@current=1)
					begin
						exec undoCreateTable
						set @current=@current - 1
					end
				end
			end
		end
	end
update Version
set version=@current
end
go


exec changeVersion 14
exec undoChangedVersion 1
Select * from Version
Select * from Owners
