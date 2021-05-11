create database Car_labs
go
use [Cars]
go

create table Engine(
eID int primary key identity(1,1),
nr_cylinders int,
power int,
fuel nvarchar(50),
)

create table CarTypes(
typeid int primary key identity(1,1),
type_name nvarchar(50),
)


create table Car(
cid int primary key identity(1,1),
brand nvarchar(50),
year int,
engineId int,
foreign key (engineID) references Engine(eID),
Wheels nvarchar(50),
Seats int,
Type int,
foreign key (Type) references CarTypes(typeid))


create table Model(
model_id int primary key identity(1,1),
name nvarchar(50),
id int,
foreign key(id) references car(cid),
)

create table Review(
review_id int primary key identity(1,1),
model nvarchar(50),
review int,
foreign key (review) references model(model_id)
)



create table Seats(
seats_id int primary key identity(1,1),
SeatType nvarchar(50),
)

create table TypeOfSeats(
seats_id int,
car_id int,
primary key(seats_id, car_id),
foreign key(seats_id) references Seats(seats_id),
foreign key(car_id) references Car(cid),
)

/*-------------------- POPULATING THE TABLES------------------------------ */
-- insert into engine 

insert into Engine(eID, nr_cylinders, power , fuel ) values
(1, 4, 140, 'petrol'),
(2, 6, 200, 'diesel');

