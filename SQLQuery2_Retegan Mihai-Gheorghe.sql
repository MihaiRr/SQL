use [Cars]
go


--INSERT
SET IDENTITY_INSERT Engine ON
INSERT INTO Engine(eID, nr_cylinders, power, fuel) values (1, 4, 150, 'fuel1')
INSERT INTO Engine(eID, nr_cylinders, power, fuel) values (2, 6, 100, 'fuel2')
INSERT INTO Engine(eID, nr_cylinders, power, fuel) values (3, 8, 300, 'fuel1')
INSERT INTO Engine(eID, nr_cylinders, power, fuel) values (4, 6, 200, 'fuel2')
INSERT INTO Engine(eID, nr_cylinders, power, fuel) values (5, 4, 500, 'fuel3')


SET IDENTITY_INSERT Engine OFF
SET IDENTITY_INSERT CarTypes ON
INSERT INTO CarTypes(typeid, type_name) values (1, 'sport')
INSERT INTO CarTypes(typeid, type_name) values (2, 'comfort')
INSERT INTO CarTypes(typeid, type_name) values (3, 'cabrio')

SET IDENTITY_INSERT CarTypes OFF
SET IDENTITY_INSERT Car ON
INSERT INTO Car(cid, brand, year, engineId, Wheels, Seats, Type) values (1, 'brand1', 2000, 1, 'wheels1', 1, 1)
INSERT INTO Car(cid, brand, year, engineId, Wheels, Seats, Type) values (2, 'brand2', 2001, 2, 'wheels2', 2, 2)
INSERT INTO Car(cid, brand, year, engineId, Wheels, Seats, Type) values (3, 'brand3', 2002, 3, 'wheels3', 3, 3)
INSERT INTO Car(cid, brand, year, engineId, Wheels, Seats, Type) values (4, 'brand4', 2003, 4, 'wheels4', 4, 1)
INSERT INTO Car(cid, brand, year, engineId, Wheels, Seats, Type) values (5, 'brand1', 2004, 1, 'wheels5', 5, 2)
INSERT INTO Car(cid, brand, year, engineId, Wheels, Seats, Type) values (6, 'brand2', 2005, 2, 'wheels5', 5, 3)
INSERT INTO Car(cid, brand, year, engineId, Wheels, Seats, Type) values (7, 'brand3', 2006, 3, 'wheels5', 5, 2)
INSERT INTO Car(cid, brand, year, engineId, Wheels, Seats, Type) values (8, 'brand4', 2007, 4, 'wheels5', 5, 1)
INSERT INTO Car(cid, brand, year, engineId, Wheels, Seats, Type) values (9, 'brand5', 2007, 1, 'wheels5', 5, 3)
INSERT INTO Car(cid, brand, year, engineId, Wheels, Seats, Type) values (10, 'brand1', 2008, 2, 'wheels5', 5, 2)
INSERT INTO Car(cid, brand, year, engineId, Wheels, Seats, Type) values (11, 'brand1', 2007, 3, 'wheels5', 5, 3)
INSERT INTO Car(cid, brand, year, engineId, Wheels, Seats, Type) values (12, 'brand2', 2011, 4, 'wheels5', 5, 1)
INSERT INTO Car(cid, brand, year, engineId, Wheels, Seats, Type) values (13, 'brand1', 2012, 1, 'wheels5', 5, 2)


SELECT * FROM Engine
SELECT * FROM CarTypes
SELECT * FROM Car
SET IDENTITY_INSERT Car OFF
DELETE FROM Car
DELETE FROM Engine
DELETE FROM CarTypes

--UPDATE 

UPDATE Car
SET year=2222
WHERE YEAR>2003
SELECT * FROM Car

UPDATE Engine
SET fuel='FUEL UPDATED'
WHERE fuel='fuel1'
SELECT * FROM Engine

UPDATE CarTypes
SET type_name='TYPE UPDATED'
WHERE type_name LIKE 'S%'
SELECT * FROM CarTypes

--DELETE 

DELETE FROM Car WHERE year=2222 OR year=2001

--UNION
SELECT c1.cid FROM Car c1
WHERE brand='brand1'
UNION
SELECT c2.cid FROM Car c2
WHERE year BETWEEN 2005 AND 2006
ORDER BY c1.cid DESC

--INTERSECT
SELECT * FROM Car 
WHERE brand='brand1'
INTERSECT
SELECT * FROM Car 
WHERE year BETWEEN 2005 AND 2007

--EXCEPT 
SELECT * FROM Car
WHERE year=2007 
EXCEPT 
SELECT * FROM Car
WHERE brand='brand5' 


SELECT *
FROM Car c INNER JOIN CarTypes ct ON c.Type=ct.typeid

--all engines that are on a car 
SELECT Engine.eID, Car.cid
FROM Engine
LEFT JOIN Car ON Engine.eID=Car.engineId

SELECT * 
FROM Car
RIGHT JOIN Engine ON Engine.eID=Car.engineId

-- all engine with power>=200 that are on a car
SELECT Engine.eID, Engine.power
FROM Engine
WHERE Engine.power>=200 AND Engine.eID IN (
SELECT Car.engineId
FROM Car)

SELECT e.eID, e.power
FROM Engine e
WHERE e.power>=200 AND EXISTS ( SELECT *
									 FROM Car c
									 WHERE e.eID=c.engineId
									 )
-- GROUP BY YEAR								 
SELECT COUNT(Car.year), Car.year
FROM Car
GROUP BY Car.year

-- GROUP BY YEAR BELOW 2005
SELECT COUNT(Car.year), Car.year
FROM Car
GROUP BY Car.year
HAVING Car.year BETWEEN 2005 AND 2007
