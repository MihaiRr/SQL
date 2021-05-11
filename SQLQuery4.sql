create database Practic
go
use Practic
go 

create table Institution(
iID int primary key,
name varchar(50) not null,
website varchar(50) not null,
budget int not null
)

create table Researchers(
rID int primary key,
name varchar(50) not null,
birth_date date,
papers int,
iID int foreign key references Institution(iID)
)

create table Conference(
cID int primary key,
name varchar(50),
location varchar(50),
list_papers int,
fee int
)

create table Papers(
pID int primary key,
title varchar(50),
rID int foreign key references Researchers(rID),
cID int foreign key references Conference(cID)
)

drop table Institution
drop table Papers
drop table Conference
drop table Researchers

--b. Implement a stored procedure that receives a researcher and a paper, and adds the researcher as one of the paper's authors.
--If the researcher is already associated with the paper, a warning message is displayed to the user

create or alter procedure Add_Researcher @rID int, @pID int
as
	declare @nr int
	set @nr=0
	select @nr=COUNT(*) FROM Papers  WHERE rID=@rID and pID=@pID
	if (nr<>0) begin
		update Papers
		set 
--toDO

--c. Create a view that shows the names of the institutions with at least 2 accepted papers in the "Very Large Data Bases" conference.

create view vInstitutionWithTwo
as
select iID, pid
From Institution i Inner Join Papers p on s.iID=p.pID
group by iID
Having s.papers>=2
--toDO

--d. Implement a function that returns the names of the conferences with at least P accepted papers, where P is a function parameter.

