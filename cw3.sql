-- tworzenie bazy danych
CREATE DATABASE baza2;

-- dodanie funkcjonalności PostGIS
CREATE EXTENSION postgis;

-- import plików shp przez PostGIS DBF Loader

-- 4. Wyznacz liczbe budynków (tabela: popp, atrybut: f_codedesc - reprezentowane jako punkty) 
-- położonych w odległości mniejszej niż 1000 m od głównych rzek. 
-- Budynki spełniające to kryterium zapisz do osobnej tabeli tableB.

SELECT popp.gid, popp.cat, popp.f_codedesc, popp.f_code, popp.type, popp.geom INTO tabelaB
FROM popp
JOIN majrivers
ON ST_Contains(ST_BUFFER(majrivers.geom, 1000), popp.geom)
WHERE popp.f_codedesc = 'Building';

SELECT COUNT(*) as liczba_budynkow 
FROM tabelaB;

-- 5. Utwórz tabelę o nazwie airportsNew. 
-- Z tabeli airports do zaimportuj nazwy lotnisk, ich geometrię, a także atrybut elev reprezentujący wysokość n.p.m.

CREATE TABLE airportsNew AS ( SELECT airports.name, airports.geom, airports.elev FROM airports);

-- a. Znajdź lotnisko, które położone jest najbardziej na zachód i najbardziej na wschód.
-- Uwaga: geodezyjny układ współrzędnych prostokątnych płaskich (x – oś pionowa, y – oś pozioma)

SELECT * FROM airportsNew ORDER BY ST_Y(airportsNew.geom) ASC LIMIT 1;
SELECT * FROM airportsNew ORDER BY ST_Y(airportsNew.geom) DESC LIMIT 1;

-- b. Do tabeli airportsNew dodaj nowy obiekt - lotnisko, które położone jest w punkcie środkowym drogi pomiędzy lotniskami
-- znalezionymi w punkcie a. Lotnisko nazwij airportB. Wysokość n.p.m. przyjmij dowolną. 
-- Uwaga: geodezyjny układ współrzędnych prostokątnych płaskich (x – oś pionowa, y – oś pozioma)

INSERT INTO airportsNew 
VALUES ('airportB', 
		ST_Point(
			((SELECT ST_X(airportsNew.geom) FROM airportsNew ORDER BY ST_Y(airportsNew.geom) ASC LIMIT 1)+(SELECT ST_X(airportsNew.geom) FROM airportsNew ORDER BY ST_Y(airportsNew.geom) DESC LIMIT 1))/2, 
			((SELECT ST_Y(airportsNew.geom) FROM airportsNew ORDER BY ST_Y(airportsNew.geom) ASC LIMIT 1)+(SELECT ST_Y(airportsNew.geom) FROM airportsNew ORDER BY ST_Y(airportsNew.geom) DESC LIMIT 1))/2) , 
		1122);
			
-- 6. Wyznacz pole powierzchni obszaru, który oddalony jest mniej niż 1000 jednostek od najkrótszej linii 
-- łączącej jezioro o nazwie ‘Iliamna Lake’ i lotnisko o nazwie „AMBLER”

SELECT ST_Area(
	ST_Buffer(
		ST_ShortestLine(
			(SELECT lakes.geom FROM lakes WHERE lakes.names = 'Iliamna Lake'), 
			(SELECT airports.geom FROM airports WHERE airports.name = 'AMBLER')
		)
	,1000)
) as pole_powierzchni;

-- 7. Napisz zapytanie, które zwróci sumaryczne pole powierzchni poligonów reprezentujących poszczególne typy drzew 
-- znajdujących się na obszarze tundry i bagien (swamps).

SELECT trees.vegdesc,
	SUM(ST_Area(trees.geom)) as suma
FROM trees
	LEFT JOIN tundra ON ST_Contains(tundra.geom, trees.geom)
	LEFT JOIN swamp ON ST_Contains(swamp.geom, trees.geom)
WHERE ST_Contains(tundra.geom, trees.geom) OR ST_Contains(swamp.geom, trees.geom)
GROUP BY trees.vegdesc;

--suma powierzchni obszarów lasu dla swamp
--SELECT trees.vegdesc, SUM(ST_Area(ST_Intersection(trees.geom, swamp.geom)))
--FROM trees 
--JOIN swamp
--ON ST_Contains(swamp.geom, trees.geom) GROUP BY trees.vegdesc;