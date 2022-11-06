-- 1
--shp2pgsql -D -I C:/Users/THINK/Desktop/T2018_KAR_GERMANY/T2018_KAR_BUILDINGS.shp t2018_kar_buildings | psql -U postgres -h localhost -p 5432 -d cw3
--shp2pgsql -D -I C:/Users/THINK/Desktop/T2019_KAR_GERMANY/T2019_KAR_BUILDINGS.shp t2019_kar_buildings | psql -U postgres -h localhost -p 5432 -d cw3

--select b1.geom, b1.name from t2019_kar_buildings as b1
--left join t2018_kar_buildings as b2
--on b1.geom = b2.geom
--where b1.gid is null

-- 2
--shp2pgsql -D -I C:/Users/THINK/Desktop/T2018_KAR_GERMANY/T2018_KAR_POI_TABLE.shp t2018_kar_poi | psql -U postgres -h localhost -p 5432 -d cw3
--shp2pgsql -D -I C:/Users/THINK/Desktop/T2019_KAR_GERMANY/T2019_KAR_POI_TABLE.shp t2019_kar_poi | psql -U postgres -h localhost -p 5432 -d cw3

--create view new_points as 
--select b.*  from t2019_kar_poi b left join t2018_kar_poi b2 on b.geom = b2.geom 
--where b2.gid is null;

--create view new_buildings as
--select b1.gid, b1.polygon_id, b1.name, b1.type, b1.height, b1.geom 
--from t2019_kar_buildings b1
--left join t2018_kar_buildings b2 on b2.geom = b1.geom
--where b2.gid is null;
--
--create view buffer_points as 
--select * from new_points a, (select ST_buffer(b.geom, 0.005) as buffer  from  new_buildings b ) a2 
--where ST_contains(a2.buffer,a.geom ) = true;
--
--select type, count(type) from buffer_points group by type

-- 3
--shp2pgsql -D -I C:/Users/THINK/Desktop/T2019_KAR_GERMANY/T2019_KAR_STREETS.shp t2019_kar_streets | psql -U postgres -h localhost -p 5432 -d cw3

--create table streets_reprojected(gid_id int, link_id numeric, st_name varchar(254), ref_in_id numeric,
--nref_in_id numeric, func_class varchar(1), speed_cat varchar(1), 
--fr_speed_I numeric, to_speed_I numeric, dir_travel varchar(1), geom geometry);

--insert into streets_reprojected 
--select s.gid, s.link_id, s.st_name, s.ref_in_id, s.nref_in_id, s.func_class, s.speed_cat, 
--s.fr_speed_l, s.to_speed_l, s.dir_travel, ST_Transform(ST_SetSRID(s.geom,4326), 3068)
--from t2019_kar_streets s

--select * from streets_reprojected;

-- 4
--create table input_points (id int primary key, geom geometry, name char(1));

--insert into input_points values  (1, 'POINT(8.36093 49.03174)', 'A'),
--                                 (2, 'POINT(8.39876 49.00644)', 'B');

--select * from input_points 

---- 5
--update input_points
--set geom = ST_Transform(ST_SetSRID(geom,4326), 3068);

--select * from input_points;

---- 6
----shp2pgsql -D -I C:/Users/THINK/Desktop/T2019_KAR_GERMANY/T2019_KAR_STREET_NODE.shp t2019_street_node | psql -U postgres -h localhost -p 5432 -d cw3

--update t2019_street_node
--set geom = ST_Transform(ST_SetSRID(geom,4326), 3068);

--create view lines as
--select ST_Makeline(geom) as line from input_points;

--select * from t2019_street_node as sn
--cross join lines l
--where ST_Contains(ST_Buffer(l.line, 0.002),sn.geom);

---- 7
----shp2pgsql -D -I C:/Users/THINK/Desktop/T2019_KAR_GERMANY/T2019_KAR_LAND_USE_A.shp t2019_land_use_A | psql -U postgres -h localhost -p 5432 -d cw3

--create view stores as 
--select * from t2019_kar_poi where type = 'Sporting Goods Store';
--
--select count(distinct stores.gid) from stores
--join t2019_land_use_a as parks
--on st_dwithin(stores.geom, parks.geom, 300);

---- 8
----shp2pgsql -D -I C:/Users/THINK/Desktop/T2019_KAR_GERMANY/T2019_KAR_RAILWAYS.shp t2019_railways | psql -U postgres -h localhost -p 5432 -d cw3
----shp2pgsql -D -I C:/Users/THINK/Desktop/T2019_KAR_GERMANY/T2019_KAR_WATER_LINES.shp t2019_water_lines | psql -U postgres -h localhost -p 5432 -d cw3


--select distinct st_intersection(r.geom, wl.geom) into T2019_KAR_BRIDGES
--from t2019_railways as r, t2019_water_lines as wl;

--select  * from T2019_KAR_BRIDGES;





