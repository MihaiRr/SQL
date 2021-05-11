create table M(
PK1 int not null,
PK2 int not null,
M1 varchar(100) not null,
M2 varchar(50) not null,
M3 int,
M4 date,
M5 varchar(20),
CONSTRAINT pk_M PRIMARY KEY(PK1, PK2))
drop table M
insert into M(PK1, PK2, M1, M2, M3, M4, M5) values
(11, 1, 'Marin Preda', 'Editura Didactica', 15, '12/01/2000', 'FB'),
(11, 22, 'Ion Agarbiceanu', 'Humanitas', 5, '01/01/1990', 'B'),
(11, 3, 'Mihai Eminescu', 'Editura Didactica', 8, '4/6/1890', 'FB'),
(12, 1, 'Marin Preda', 'Litera', 10, '4/9/1900', 'B'),
(12, 22, 'Camil Petrescu', 'Carturesti', 1, '6/7/1987', 'B'),
(12, 3, 'Mihai Eminescu', 'Carturesti', 6, '3/5/2002', 'S'),
(13, 1, 'Mircea Eliade', 'Litera', 20, '1/2/2010', 'S'),
(13, 22, 'Mircea Cartrescu', 'Editura Didactica', 10, '3/14/2000', 'E'),
(13, 3, 'Lucian Blaga', 'Litera', 15, '11/25/2000', 'FB'),
(14, 1, 'Lucian Blaga', 'Humanitas', 15, '12/01/2000', 'E'),
(14, 22, 'Mircea Eliade', 'Humanitas', 5, '3/5/2002', 'B'),
(14, 3, 'Dan Lungu', 'Polirom', 10, '4/6/1890', 'S'),
(14, 44, 'Dan Lungu', 'Polirom', 2, '01/01/1990', 'E')

select * from M

SELECT M2, SUM(M3) TotalM3, COUNT(M3) CountM3
FROM M
WHERE YEAR(M4)>= 2000 OR M1 LIKE '%escu%'
GROUP BY M2
HAVING SUM(M3) > 10

SELECT * FROM
(SELECT PK1, PK2, M3 TotalM3 FROM M
WHERE PK1 <= PK2) p1
INNER JOIN (SELECT PK1, PK2, M5
FROM M
WHERE M5 LIKE '%B%') p2 ON p1.PK1 = p2.PK1 AND p1.PK2 = p2.PK2

CREATE OR ALTER TRIGGER TrOnUpdate
ON M
FOR UPDATE AS
DECLARE @no INT = 0
SELECT @no = AVG(d.M3 - i.M3)
FROM deleted d INNER JOIN inserted i ON d.PK1 = i.PK1 AND d.PK2 = i.PK2 WHERE d.M3 > i.M3
PRINT @no

UPDATE M
SET M3 = 3
WHERE PK1 > PK2