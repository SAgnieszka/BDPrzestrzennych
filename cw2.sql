-- tworzenie bazy danych
CREATE DATABASE baza1;

-- dodanie funkcjonalności PostGIS
CREATE EXTENSION postgis;

-- utworzenie tabel
CREATE TABLE buildings(id INTEGER PRIMARY KEY, geometry GEOMETRY, name VARCHAR(20));
CREATE TABLE roads(id INTEGER PRIMARY KEY, geometry GEOMETRY, name VARCHAR(20));
CREATE TABLE poi(id INTEGER PRIMARY KEY, geometry GEOMETRY, name VARCHAR(20));

-- wprowadzenie danych do tabel
INSERT INTO poi VALUES (1, ST_Point(1, 3.5), 'G');
INSERT INTO poi VALUES (2, ST_Point(5.5, 1.5), 'H');
INSERT INTO poi VALUES (3, ST_Point(9.5, 6), 'I');
INSERT INTO poi VALUES (4, ST_Point(6.5, 6), 'J');
INSERT INTO poi VALUES (5, ST_Point(6, 9.5), 'K');

INSERT INTO roads VALUES (1, ST_MakeLine(ST_Point(0, 4.5),ST_Point(12, 4.5)), 'RoadX');
INSERT INTO roads VALUES (2, ST_MakeLine(ST_Point(7.5, 0),ST_Point(7.5, 10.5)), 'RoadY');

INSERT INTO buildings VALUES (1, ST_MakePolygon(ST_GeomFromText('LINESTRING(8 1.5, 10.5 1.5, 10.5 4, 8 4, 8 1.5)')), 'BuildingA');
INSERT INTO buildings VALUES (2, ST_MakePolygon(ST_GeomFromText('LINESTRING(4 5, 6 5, 6 7, 4 7, 4 5)')), 'BuildingB');
INSERT INTO buildings VALUES (3, ST_MakePolygon(ST_GeomFromText('LINESTRING(3 6, 5 6, 5 8, 3 8, 3 6)')), 'BuildingC');
INSERT INTO buildings VALUES (4, ST_MakePolygon(ST_GeomFromText('LINESTRING(9 8, 10 8, 10 9, 9 9, 9 8)')), 'BuildingD');
INSERT INTO buildings VALUES (5, ST_MakePolygon(ST_GeomFromText('LINESTRING(1 1, 2 1, 2 2, 1 2, 1 1)')), 'BuildingF');

-- a. calkowita dlugosc drog
SELECT SUM(ST_Length(roads.geometry)) as suma
FROM roads;
	
-- b. geometria WKT, pole powierzchni, obwod poligonu BudynekA
SELECT ST_AsText(buildings.geometry) as geometria, ST_Area(buildings.geometry) as pole_powierzchni, ST_Perimeter(buildings.geometry) as obwod
FROM buildings 
WHERE buildings.name = 'BuildingA';

-- c. wypisz nazwy i pola powierzchni wszystkich poligonów na warstwie budynki, sortowanie alfabetyczne
SELECT buildings.name as nazwa, ST_Area(buildings.geometry) as pole_powierzchni
FROM buildings
ORDER BY buildings.name ASC;

-- d. wypisz nazwy i obwody 2 budynkow o najwiekszej powierzchni
SELECT buildings.name as nazwa, ST_Perimeter(buildings.geometry) as obwod
FROM buildings
ORDER BY ST_Area(buildings.geometry) DESC
LIMIT 2;

-- e. wyznacz najkrotsza odleglosc miedzy BuildingC, a pkt G
SELECT ST_Distance((SELECT buildings.geometry FROM buildings WHERE buildings.name = 'BuildingC'), (SELECT poi.geometry FROM poi WHERE poi.name = 'G')) as odleglosc 
FROM buildings
ORDER BY odleglosc ASC
LIMIT 1;

-- f. wypisz pole powierzchni tej czesci BuildingC, ktora znajduje sie w odleglosci wiekszej niz 0.5 od BuildingB
SELECT ST_Area(ST_Difference((SELECT buildings.geometry FROM buildings WHERE buildings.name = 'BuildingC'), (ST_BUFFER((SELECT buildings.geometry FROM buildings WHERE buildings.name = 'BuildingB'),0.5)))) as pole_powierzchni
FROM buildings
LIMIT 1;

-- g. wybierz te budynki ktorych centroid (ST_Centroid) znajduje sie powyzej RoadX
SELECT * 
FROM buildings
WHERE (ST_Y(ST_Centroid(buildings.geometry))) > (SELECT ST_Y(ST_Centroid(roads.geometry)) FROM roads WHERE roads.name = 'RoadX');

-- h. oblicz pole powierzchni tych czesci BuildingC i poligonu o wsp (4 7, 6 7, 6 8, 4 8, 4 7) ktore nie sa wspolne dla tych dwoch obiektow
SELECT ST_Area(ST_SymDifference((SELECT buildings.geometry FROM buildings WHERE buildings.name = 'BuildingC'), ST_MakePolygon(ST_GeomFromText('LINESTRING(4 7, 6 7, 6 8, 4 8, 4 7)')))) as pole_powierzchni
FROM buildings
LIMIT 1;