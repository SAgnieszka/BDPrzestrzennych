-- tworzenie bazy danych
CREATE DATABASE firma;

-- dodanie schematu
CREATE SCHEMA ksiegowosc;

-- tworzenie tabel
CREATE TABLE ksiegowosc.pracownicy(id_pracownika INTEGER PRIMARY KEY, imie VARCHAR(20)  NOT NULL, nazwisko VARCHAR(20)  NOT NULL, adres VARCHAR(50), telefon VARCHAR(10));
CREATE TABLE ksiegowosc.godziny(id_godziny INTEGER PRIMARY KEY, data DATE NOT NULL, liczba_godzin INTEGER  NOT NULL);
CREATE TABLE ksiegowosc.pensje(id_pensji INTEGER PRIMARY KEY, stanowisko VARCHAR(20), kwota MONEY  NOT NULL);
CREATE TABLE ksiegowosc.premie(id_premii INTEGER PRIMARY KEY, rodzaj VARCHAR(20), kwota MONEY NOT NULL);
CREATE TABLE ksiegowosc.wynagrodzenie(id_wynagrodzenia INTEGER PRIMARY KEY, data DATE NOT NULL, id_pracownika INTEGER NOT NULL, id_godziny INTEGER NOT NULL, id_pensji INTEGER NOT NULL, id_premii INTEGER);

-- dodawanie kluczy obcych
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensje(id_pensji);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premie(id_premii);

-- dodanie komentarzy do tabel
COMMENT ON TABLE ksiegowosc.pracownicy IS 'Tabela pracownicy';
COMMENT ON TABLE ksiegowosc.godziny IS 'Tabela godziny';
COMMENT ON TABLE ksiegowosc.pensje IS 'Tabela pensje';
COMMENT ON TABLE ksiegowosc.premie IS 'Tabela premie';
COMMENT ON TABLE ksiegowosc.wynagrodzenie IS 'Tabela wynagrodzenia';

-- wypełnienie tabel danymi
INSERT INTO ksiegowosc.pracownicy VALUES (1, 'Krzysztof', 'Nowak', 'al.Mickiewicza 20, Kraków', '999888777');
INSERT INTO ksiegowosc.pracownicy VALUES (2, 'Jan', 'Wiśniowski', 'al.Słowackiego 123, Kraków', '654321321');
INSERT INTO ksiegowosc.pracownicy VALUES (3, 'Anna', 'Kowalska', 'ul. Długa 12, Wieliczka', '236456789');
INSERT INTO ksiegowosc.pracownicy VALUES (4, 'Alicja', 'Wójcik', 'ul. Krótka 5, Wrocław', '002569845');
INSERT INTO ksiegowosc.pracownicy VALUES (5, 'Piotr', 'Malina', 'ul. Wrocławska 154, Kielce', '885223697');
INSERT INTO ksiegowosc.pracownicy VALUES (6, 'Paweł', 'Stefański', 'ul. Mazowiecka 45, Gdańsk', '789523658');
INSERT INTO ksiegowosc.pracownicy VALUES (7, 'Maria', 'Piotrowska', 'ul. Konopnickiej 15, Katowice', '236985965');
INSERT INTO ksiegowosc.pracownicy VALUES (8, 'Anna', 'Sowa', 'ul. Basztowa 77, Kraków', '669856312');
INSERT INTO ksiegowosc.pracownicy VALUES (9, 'Jadwiga', 'Nowakowska', 'ul. Opolska 54, Warszawa', '895658956');
INSERT INTO ksiegowosc.pracownicy VALUES (10, 'Sebastian', 'Baran', 'ul. Karmelicka 45, Kraków', '777895635');

INSERT INTO ksiegowosc.godziny VALUES (101, '2020-11-25', 150);
INSERT INTO ksiegowosc.godziny VALUES (102, '2020-11-25', 165);
INSERT INTO ksiegowosc.godziny VALUES (103, '2020-11-25', 180);
INSERT INTO ksiegowosc.godziny VALUES (104, '2020-11-25', 142);
INSERT INTO ksiegowosc.godziny VALUES (105, '2020-11-25', 166);
INSERT INTO ksiegowosc.godziny VALUES (106, '2020-11-25', 170);
INSERT INTO ksiegowosc.godziny VALUES (107, '2020-11-25', 120);
INSERT INTO ksiegowosc.godziny VALUES (108, '2020-11-25', 110);
INSERT INTO ksiegowosc.godziny VALUES (109, '2020-11-25', 180);
INSERT INTO ksiegowosc.godziny VALUES (110, '2020-11-25', 161);

INSERT INTO ksiegowosc.premie VALUES (201, 'uznaniowa', 0);
INSERT INTO ksiegowosc.premie VALUES (202, 'regulaminowa', 200);
INSERT INTO ksiegowosc.premie VALUES (203, 'uznaniowa', 150);
INSERT INTO ksiegowosc.premie VALUES (204, 'uznaniowa', 100);
INSERT INTO ksiegowosc.premie VALUES (205, 'uznaniowa', 70);
INSERT INTO ksiegowosc.premie VALUES (206, 'regulaminowa', 170);
INSERT INTO ksiegowosc.premie VALUES (207, 'uznaniowa', 0);
INSERT INTO ksiegowosc.premie VALUES (208, 'uznaniowa', 0);
INSERT INTO ksiegowosc.premie VALUES (209, 'regulaminowa', 180);
INSERT INTO ksiegowosc.premie VALUES (210, 'regulaminowa', 200);

INSERT INTO ksiegowosc.pensje VALUES (51, 'kelner', 900);
INSERT INTO ksiegowosc.pensje VALUES (52, 'kucharz', 2500);
INSERT INTO ksiegowosc.pensje VALUES (53, 'kelner', 1600);
INSERT INTO ksiegowosc.pensje VALUES (54, 'kelner', 2800);
INSERT INTO ksiegowosc.pensje VALUES (55, 'cukiernik', 3100);
INSERT INTO ksiegowosc.pensje VALUES (56, 'kucharz', 2900);
INSERT INTO ksiegowosc.pensje VALUES (57, 'kierownik', 3500);
INSERT INTO ksiegowosc.pensje VALUES (58, 'kierownik', 4000);
INSERT INTO ksiegowosc.pensje VALUES (59, 'szef kuchni', 3200);
INSERT INTO ksiegowosc.pensje VALUES (60, 'barman', 999);

INSERT INTO ksiegowosc.wynagrodzenie VALUES (1001, '2020-11-25', 1, 101, 51, 201);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (1002, '2020-11-25', 2, 102, 52, 202);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (1003, '2020-11-25', 3, 103, 53, 203);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (1004, '2020-11-25', 4, 104, 54, 204);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (1005, '2020-11-25', 5, 105, 55, 205);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (1006, '2020-11-25', 6, 106, 56, 206);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (1007, '2020-11-25', 7, 107, 57, 207);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (1008, '2020-11-25', 8, 108, 58, 208);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (1009, '2020-11-25', 9, 109, 59, 209);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (10010, '2020-11-25', 10, 110, 60, 210);


-- a. id pracownika + jego nazwisko
SELECT pracownicy.id_pracownika, pracownicy.nazwisko
FROM ksiegowosc.pracownicy;

-- b. id pracowników, których płaca wieksza niż 1000
SELECT wynagrodzenie.id_pracownika, pensje.kwota 
FROM ksiegowosc.wynagrodzenie 
JOIN ksiegowosc.pensje 
ON wynagrodzenie.id_pensji = pensje.id_pensji 
WHERE pensje.kwota > '1000';

-- c. id pracowników nieposiadających premii, których płaca większa niż 2000
SELECT wynagrodzenie.id_pracownika, premie.kwota as premia, pensje.kwota as pensja
FROM ksiegowosc.pensje JOIN (ksiegowosc.wynagrodzenie JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii) ON pensje.id_pensji = wynagrodzenie.id_pensji 
WHERE pensje.kwota > '2000' AND premie.kwota = '0';

-- d. pracownicy - 1 litera imienia na J
SELECT pracownicy.id_pracownika, pracownicy.imie, pracownicy.nazwisko 
FROM ksiegowosc.pracownicy 
WHERE pracownicy.imie 
LIKE 'J%';

-- e. pracownicy - nazwisko zawiera n, imie kończy się na A
SELECT pracownicy.id_pracownika, pracownicy.imie, pracownicy.nazwisko 
FROM ksiegowosc.pracownicy 
WHERE pracownicy.nazwisko 
LIKE '%n%'
AND pracownicy.imie
LIKE '%a';

-- f. imie i nazwisko + liczba nadgodzin (st. czas pracy 160h/miesiąc)
SELECT pracownicy.imie, pracownicy.nazwisko, godziny.liczba_godzin-160 AS nadgodziny
FROM ksiegowosc.pracownicy
JOIN (ksiegowosc.wynagrodzenie JOIN ksiegowosc.godziny ON wynagrodzenie.id_godziny = godziny.id_godziny)
ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
WHERE godziny.liczba_godzin > 160;

-- g. imie i nazwisko, których pensja jest w przedziale 1500-3000
SELECT pracownicy.imie, pracownicy.nazwisko, pensje.kwota 
FROM ksiegowosc.pracownicy 
JOIN (ksiegowosc.wynagrodzenie JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji) ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
WHERE pensje.kwota >= '1500' AND pensje.kwota <= '3000';

-- h. imie i nazwisko, którzy pracowali w nadgodzinach i nie mają premii
SELECT pracownicy.imie, pracownicy.nazwisko, godziny.liczba_godzin-160 AS nadgodziny, premie.kwota
FROM ksiegowosc.pracownicy
JOIN ((ksiegowosc.wynagrodzenie 
	  JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii) 
	  JOIN ksiegowosc.godziny ON wynagrodzenie.id_godziny = godziny.id_godziny) ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
WHERE godziny.liczba_godzin > 160 AND premie.kwota = '0';

SELECT pracownicy.imie, pracownicy.nazwisko, godziny.liczba_godzin-160 AS nadgodziny, premie.kwota
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie 
	JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii
	JOIN ksiegowosc.godziny ON wynagrodzenie.id_godziny = godziny.id_godziny ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
WHERE godziny.liczba_godzin > 160 AND premie.kwota = '0';

-- i. uszeregowani pracownicy wg pensji
SELECT pracownicy.id_pracownika, pracownicy.imie, pracownicy.nazwisko, pensje.kwota
FROM ksiegowosc.pracownicy 
JOIN (ksiegowosc.wynagrodzenie JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji) ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
ORDER BY pensje.kwota;

-- j. uszeregowani pracownicy wg pensji i premii malejąco
SELECT pracownicy.id_pracownika, pracownicy.imie, pracownicy.nazwisko, pensje.kwota, premie.kwota
FROM ksiegowosc.pracownicy 
JOIN ((ksiegowosc.wynagrodzenie JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii) JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji) ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
ORDER BY pensje.kwota DESC, premie.kwota DESC;

-- k. zlicz + pogrupuj wg pola 'stanowisko'
SELECT pensje.stanowisko, COUNT (*)
FROM ksiegowosc.pensje
GROUP BY pensje.stanowisko;

-- l. policz średnią, minimalną i maksymalną płacę dla stanowiska 'kierownik'
SELECT AVG(pensje.kwota::numeric), MIN(pensje.kwota), MAX(pensje.kwota)
FROM ksiegowosc.pensje
GROUP BY pensje.stanowisko
HAVING pensje.stanowisko = 'kierownik';

-- m. policz sumę wszystkich wynagrodzeń
SELECT SUM(pensje.kwota)
FROM ksiegowosc.pensje;

-- n. policz sumę wszystkich wynagrodzeń w ramach danego stanowiska
SELECT pensje.stanowisko, SUM(pensje.kwota)
FROM ksiegowosc.pensje
GROUP BY pensje.stanowisko;

-- o. wyznacz liczbe premii przyznanych dla pracowników danego stanowiska
SELECT pensje.stanowisko, COUNT(premie.kwota)
FROM ksiegowosc.pensje
JOIN (ksiegowosc.wynagrodzenie JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii) ON pensje.id_pensji = wynagrodzenie.id_pensji
WHERE premie.kwota > '0'
GROUP BY pensje.stanowisko;

-- p. usuń pracowników mających pensję mniejszą niż 1200
SELECT pracownicy.id_pracownika, pracownicy.imie, pracownicy.nazwisko, pracownicy.adres, pracownicy.telefon
FROM ksiegowosc.pracownicy
JOIN (ksiegowosc.wynagrodzenie JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji) ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
WHERE pensje.kwota < '1200';











