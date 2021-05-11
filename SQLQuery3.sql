CREATE DATABASE TEST
GO
USE TEST
GO

CREATE TABLE R(
A int,
B int, 
C int,
)

create table S(
a int,
b int, 
c int
)
drop table R
drop table S

insert into R(a, b, c) values
(1,1,150),
(1,2,150),
(1,3,200),
(4,5,21412),
(123312, 5, 4)

insert into S(a, b, c) values
(3,4,150),
(5,6,150),
(1,5,200),
(4,1,21412),
(12, 5, 4)



select R.a from R,S
where R.b=S.b

Select R.a from R
where R.b in (Select S.b from S)