-- 1. Stworzenie tabeli obiekty
CREATE TABLE obiekty (nazwa varchar(20), geom geometry);

-- Dodanie do tabeli obiektów

-- obiekt 1
INSERT INTO obiekty 
VALUES (
'obiekt1',
ST_COLLECT(
Array[
'LINESTRING(0 1, 1 1)',
'CIRCULARSTRING(1 1, 2 0, 3 1)',
'CIRCULARSTRING(3 1, 4 2, 5 1)',
'LINESTRING(5 1, 6 1)'
]));

-- obiekt 2
INSERT INTO obiekty 
VALUES (
'obiekt2',
ST_COLLECT(
Array[
'LINESTRING(10 2, 10 6, 14 6)',
'CIRCULARSTRING(14 6, 16 4, 14 2)',
'CIRCULARSTRING(14 2, 12 0, 10 2)',
'CIRCULARSTRING(11 2, 13 2, 11 2)'
]));

-- obiekt 3
INSERT INTO obiekty 
VALUES (
'obiekt3',
ST_MakePolygon(
'LINESTRING(7 15, 10 17, 12 13, 7 15)'
));

-- obiekt 4
INSERT INTO obiekty 
VALUES (
'obiekt4',
ST_LineFromMultiPoint(
'MULTIPOINT(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5)'
));

-- obiekt 5
INSERT INTO obiekty 
VALUES (
'obiekt5',
ST_COLLECT(
'POINT(30 30 59)',
'POINT(38 32 234)'
));

-- obiekt 6
INSERT INTO obiekty 
VALUES (
'obiekt6',
ST_COLLECT(
Array[
'LINESTRING(1 1, 3 2)',
'POINT(4 2)'
]));

-- 2. Pole powierzchni bufora o wielkosci 5 jednostek, 
-- ktory zostal utworzony wokol najkrotszej linii laczacej obiekt 3 i 4 

SELECT ST_Area(ST_Buffer(ST_ShortestLine(ob3.geom, ob4.geom), 5)) AS pole_pow_bufora 
FROM obiekty AS ob3, obiekty AS ob4 
WHERE ob3.nazwa = 'obiekt3' AND ob4.nazwa = 'obiekt4';

-- 3. Zamien obiekt4 na poligon. 
-- Jaki warunek musi byc spelniony aby mozna bylo wykonac to zadanie?
-- ODP. Obiekt 4 nie jest poligonem poniewać nie jest obiektem zamkniętym. Nalezy polaczyc poczatek i koniec.

UPDATE obiekty
SET geom = ST_MakePolygon('LINESTRING(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5, 20 20)')
WHERE obiekty.nazwa = 'obiekt4';

-- 4. W tabeli obiekty, jako obiekt7 zapisz obiekt zlozony z obiekt3 i obiekt4

INSERT INTO obiekty 
VALUES 
('obiekt7', 
(SELECT ST_COLLECT(ob3.geom, ob4.geom)
FROM obiekty AS ob3, obiekty AS ob4 
WHERE ob3.nazwa = 'obiekt3' AND ob4.nazwa = 'obiekt4'));

-- 5. Wyznacz pole powierzchni wszystkich buforow o wielkosci 5 jednostek, 
-- ktore zostaly stworzone wokol obiektow nie zawierajacych lukow.

SELECT SUM(ST_Area(ST_Buffer(obiekty.geom, 5))) as suma_powierzchni
FROM obiekty
WHERE ST_HasArc(obiekty.geom) = 'false';