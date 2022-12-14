
--1

--a

create table obiekty(id int, geometry geometry, name varchar);

insert into obiekty values (1, ST_COLLECT(array[ST_GeomFromText('LINESTRING(0 1, 1 1)'),
												ST_GeomFromText('CIRCULARSTRING(1 1, 2 0, 3 1)'),
												ST_GeomFromText('CIRCULARSTRING(3 1, 4 2, 5 1)'),
												ST_GeomFromText('LINESTRING(5 1, 6 1)')]), 'obiekt1');
												
--b											
insert into obiekty values (2, ST_COLLECT(array[ST_GeomFromText('LINESTRING(10 6, 14 6)'),
												ST_GeomFromText('CIRCULARSTRING(14 6, 16 4, 14 2)'),
												ST_GeomFromText('CIRCULARSTRING(14 2, 12 0, 10 2)'),
												ST_GeomFromText('LINESTRING(10 2, 10 6)'),
												ST_GeomFromText('CIRCULARSTRING(11 2, 12 2, 11 2)')]), 'obiekt2');
												
--c
insert into obiekty values (3, ST_GeomFromText('POLYGON((10 17, 12 13, 7 15, 10 17))'),'obiekt3');
--d
insert into obiekty values (4, ST_LineFromMultiPoint('MULTIPOINT(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5)'), 'obiekt4');
--e
insert into obiekty values (5, ST_Collect( ST_GeomFromText('POINT(30 30 59)'),
                                           ST_GeomFromText('POINT(38 32 234)')) , 'obiekt5');
--f
insert into obiekty values (6, ST_COLLECT(array[ST_GeomFromText('LINESTRING(1 1, 3 2)'),
												ST_GeomFromText('POINT(4 2)')]), 'obiekt6');
												
	
--2

select st_area(st_buffer(st_shortestline(( select geometry from obiekty where name='obiekt3' ),
										 ( select geometry from obiekty where name='obiekt4' )), 5))
										
--3 
update obiekty 
set geometry= ST_MakePolygon(ST_GeomFromText('LINESTRING(25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5, 20 20, 25 25)'))
where id = 4

-- Warunek : punkt poczatkowy i koncowy musza byc takie same

--4
insert into obiekty values (7, ST_COLLECT(array[(select geometry from obiekty where name='obiekt3'),
												(select geometry from obiekty where name='obiekt4')]), 'obiekt7');
											
--5
select sum(st_area(st_buffer(geometry, 5)))
from obiekty
where not st_HasArc(geometry)

										









