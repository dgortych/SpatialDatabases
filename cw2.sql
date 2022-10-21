-- Zad 2
 CREATE DATABASE CW2;

-- Zad 3
CREATE EXTENSION postgis;

-- Zad 4
CREATE TABLE buildings (id int, geom geometry, name varchar);
CREATE TABLE roads (id int, geom geometry, name varchar);
CREATE TABLE poi (id int, geom geometry, name varchar);

-- Zad 5
INSERT INTO buildings VALUES
(1, 'POLYGON((9 9, 10 9, 10 8, 9 8, 9 9))', 'BuildingD'),
(2, 'POLYGON((8 4, 10.5 4, 10.5 1.5, 8 1.5, 8 4))', 'BuildingA'),
(3, 'POLYGON((3 8, 5 8, 5 6, 3 6, 3 8))', 'BuildingC'),
(4, 'POLYGON((4 7, 6 7, 6 5, 4 5, 4 7))', 'BuildingB'),
(5, 'POLYGON((1 2, 2 2, 2 1, 1 1, 1 2))', 'BuildingF');

INSERT INTO roads VALUES
(1, 'LINESTRING(0 4.5, 12 4.5)', 'RoadX'),
(2, 'LINESTRING(7.5 10.5, 7.5 0)', 'RoadY');

INSERT INTO poi VALUES
(1, 'POINT(1 3.5)', 'G'),
(2, 'POINT(6 9.5)', 'K'),
(3, 'POINT(6.5 6)', 'J'),
(4, 'POINT(9.5 6)', 'I'),
(5, 'POINT(5.5 1.5)', 'H');

-- Zad 6
-- a) 
SELECT SUM(ST_LENGTH(geom)) FROM roads;

-- b) 
SELECT ST_ASTEXT(geom), ST_AREA(geom), ST_PERIMETER(geom) FROM buildings WHERE name = 'BuildingA';

-- c) 
SELECT name, ST_AREA(geom) FROM buildings ORDER BY name;

-- d) 
SELECT name, ST_PERIMETER(geom) FROM buildings ORDER BY ST_AREA(geom) DESC LIMIT 2;

-- e) 
SELECT ST_DISTANCE(buildings.geom, poi.geom) FROM buildings, poi
WHERE buildings.name = 'BuildingC' AND poi.name = 'K';

-- f) 
SELECT ST_AREA(ST_DIFFERENCE(b1.geom, ST_BUFFER(b2.geom, 0.5))) FROM buildings b1, buildings b2 WHERE 
b1.name='BuildingC' AND b2.name='BuildingB';

-- g) 
SELECT b.name FROM buildings b, roads r WHERE r.name = 'RoadX' AND ST_Y(ST_CENTROID(b.geom)) - ST_Y(ST_CENTROID(r.geom)) > 0;

-- h) 
SELECT ST_AREA(ST_SymDifference(geom, 'POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))')) FROM buildings WHERE name='BuildingC';
