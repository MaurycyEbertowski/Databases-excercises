SET search_path TO ksiegowosc;

CREATE TABLE pracownicy (
	id_pracownika varchar PRIMARY KEY NOT NULL,
	imie varchar,
	nazwisko varchar,
	adres varchar,
	telefon varchar
);

CREATE TABLE godziny (
	id_godziny varchar PRIMARY KEY NOT NULL,
	data1 date,
	liczba_godzin decimal,
	id_pracownika varchar REFERENCES ksiegowosc.pracownicy(id_pracownika)
);

CREATE TABLE pensja (
	id_pensji varchar PRIMARY KEY NOT NULL,
	stanowisko varchar,
	kwota decimal
);

CREATE TABLE premia (
	id_premii varchar PRIMARY KEY NOT NULL,
	rodzaj varchar,
	kwota decimal
);

CREATE TABLE wynagrodzenie (
	id_wynagrodzenia varchar PRIMARY KEY NOT NULL,
	data1 date,
	id_pracownika varchar REFERENCES ksiegowosc.pracownicy(id_pracownika) NOT NULL,
	id_godziny varchar REFERENCES ksiegowosc.godziny(id_godziny) NOT NULL,
	id_pensji varchar REFERENCES ksiegowosc.pensja(id_pensji) NOT NULL,
	id_premii varchar REFERENCES ksiegowosc.premia(id_premii) NOT NULL
);
COMMENT ON TABLE ksiegowosc.godziny is 'Godziny';
COMMENT ON TABLE ksiegowosc.pensja is 'Pensja';
COMMENT ON TABLE ksiegowosc.pracownicy is 'Pracownicy';
COMMENT ON TABLE ksiegowosc.premia is 'Premia';
COMMENT ON TABLE ksiegowosc.wynagrodzenie is 'Wynagrodzenie';

INSERT INTO ksiegowosc.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES
    ('AA', 'Jan', 'Kowalski', 'Mickiewicza 10', '123456789'),
    ('AB', 'Maciej', 'Nowak', 'Świętojańska 30', '987654321'),
    ('AC', 'Robert', 'Lewandowski', 'Sucha 45', '176354298'),
    ('AD', 'Maria', 'Tomczyk', 'Czarna 1', '984034763'),
    ('AE', 'Andrzej', 'Duda', 'Prezydencka 20', '303404505'),
    ('AF', 'Aleksandra', 'Majewska', 'Jasna 12', '123234345'),
    ('AG', 'Michał', 'Michalczyk', 'Asfaltowa 8', '874563290'),
    ('AH', 'Dawid', 'Pawelski', 'Krakowska 9', '123567901'),
    ('AI', 'Marek', 'Jóźwiak', 'Zielona 7', '184093276'),
    ('AJ', 'Maja', 'Tokarska', 'Ulicowa 65', '111111111');
INSERT INTO ksiegowosc.godziny (id_godziny, data1, liczba_godzin, id_pracownika)
VALUES
	('07:00:00', '2023-11-01', 10.0, 'AA'),
    ('08:00:00', '2023-11-02', 10.5, 'AB'),
    ('09:00:00', '2023-11-03', 6.0, 'AC'),
    ('10:00:00', '2023-11-04', 10.0, 'AD'),
    ('11:00:00', '2023-11-05', 7.5, 'AE'),
    ('12:00:00', '2023-11-06', 7.5, 'AF'),
    ('13:00:00', '2023-11-07', 20.0, 'AG'),
    ('14:00:00', '2023-11-08', 30.5, 'AH'),
    ('15:00:00', '2023-11-09', 1.0, 'AI'),
    ('16:00:00', '2023-11-10', 0.5, 'AJ');
INSERT INTO ksiegowosc.premia (id_premii, rodzaj, kwota)
VALUES
	('A1', 'Świąteczna', 100.0),
	('A2', 'Motywacyjna', 150.0),
	('A3', 'Bonus powitalny', 500.0),
	('A4', 'Świąteczna', 100.0),
	('A5', 'Awans', 1000.0),
	('A6', 'Świąteczna', 100.0),
	('A7', 'Motywacyjna', 300.0),
	('A8', 'Awans', 600.0),
	('A9', 'Świąteczna', 100.0),
	('B1', 'Bonus powitalny', 1100.0);
INSERT INTO ksiegowosc.pensja (id_pensji, stanowisko, kwota)
VALUES
	('10', 'Kierownik', 1500.0),
	('12', 'Manager', 2500.0),
	('13', 'Intern', 1000.0),
	('14', 'Junior', 1800.0),
	('15', 'Junior', 1800.0),
	('16', 'Ochroniarz', 2000.0),
	('17', 'Mid', 3500.0),
	('18', 'Senior', 4500.0),
	('19', 'Szef', 15000.0),
	('20', 'Mid', 3000.0);
INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data1, id_pracownika, id_pensji, id_premii)
VALUES
	('1A', '2023-10-10', 'AA', '10', 'A1'),
	('1B', '2023-10-10', 'AB', '12', 'A2'),
	('1C', '2023-10-10', 'AC', '13', 'A3'),
	('1D', '2023-10-10', 'AD', '14', 'A4'),
	('1E', '2023-10-10', 'AE', '15', 'A5'),
	('1F', '2023-10-10', 'AF', '16', 'A6'),
	('1G', '2023-10-10', 'AG', '17', 'A7'),
	('1H', '2023-10-10', 'AH', '18', 'A8'),
	('1I', '2023-10-10', 'AI', '19', 'A9'),
	('1J', '2023-10-10', 'AJ', '20', 'B1');
/*a*/
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy

/*b*/
SELECT pracownicy.id_pracownika, 
       COALESCE(SUM(pensja.kwota), 0) + COALESCE(SUM(premia.kwota), 0) AS suma_wynagrodzenia
FROM ksiegowosc.pracownicy
LEFT JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
LEFT JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
LEFT JOIN ksiegowosc.premia ON wynagrodzenie.id_premii = premia.id_premii
GROUP BY pracownicy.id_pracownika
HAVING COALESCE(SUM(pensja.kwota), 0) + COALESCE(SUM(premia.kwota), 0) > 1000;

/*c*/
SELECT ksiegowosc.wynagrodzenie.id_pracownika
FROM ksiegowosc.wynagrodzenie
LEFT JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
LEFT JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii
GROUP BY wynagrodzenie.id_pracownika
HAVING COALESCE(SUM(ksiegowosc.pensja.kwota), 0) > 2000 AND SUM(ksiegowosc.premia.kwota) IS NULL;

/*d*/
SELECT *
FROM ksiegowosc.pracownicy
WHERE imie LIKE 'J%';

/*e*/
SELECT *
FROM ksiegowosc.pracownicy
WHERE imie LIKE '%n%' AND imie LIKE '%a';

/*f*/
SELECT pracownicy.imie, pracownicy.nazwisko, 
       CASE 
           WHEN SUM(godziny.liczba_godzin - 10) < 0 THEN 0 
           ELSE SUM(godziny.liczba_godzin - 10) 
       END
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.godziny ON pracownicy.id_pracownika = godziny.id_pracownika
GROUP BY pracownicy.imie, pracownicy.nazwisko;

/*g*/
SELECT imie, nazwisko from pracownicy
JOIN wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
WHERE pensja.kwota BETWEEN 1500 AND 3000;

/*h*/
SELECT imie, nazwisko from pracownicy
JOIN godziny ON pracownicy.id_pracownika = godziny.id_pracownika
JOIN premia ON pracownicy.id_pracownika = premia.id_premii
WHERE liczba_godzin > 10 AND premia.kwota = 0;

/*i*/
SELECT imie, nazwisko, kwota FROM pracownicy
JOIN wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
ORDER BY kwota;

--j
SELECT imie, nazwisko, pensja.kwota, premia.kwota FROM pracownicy
JOIN wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
JOIN premia ON wynagrodzenie.id_premii = premia.id_premii
ORDER BY pensja.kwota + premia.kwota DESC;

--k
SELECT stanowisko, COUNT(*) AS liczba_pracownikow
FROM pensja
GROUP BY stanowisko;

--l
SELECT
  AVG(kwota) AS srednia,
  MIN(kwota) AS minimalna,
  MAX(kwota) AS maksymalna
FROM pensja
WHERE stanowisko = 'Mid';

--m
SELECT SUM(pensja.kwota) + SUM(premia.kwota) FROM wynagrodzenie
JOIN pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
JOIN premia ON wynagrodzenie.id_premii = premia.id_premii;

--n
SELECT pensja.stanowisko, SUM(pensja.kwota) + SUM(premia.kwota) FROM wynagrodzenie
JOIN pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
JOIN premia ON wynagrodzenie.id_premii = premia.id_premii
GROUP BY stanowisko;

--o
SELECT stanowisko, COUNT(premia.id_premii) AS liczba_premii
FROM pensja
JOIN wynagrodzenie ON pensja.id_pensji = wynagrodzenie.id_pensji
JOIN premia ON wynagrodzenie.id_premii = premia.id_premii
GROUP BY stanowisko;

--p
DELETE FROM pracownicy WHERE nazwisko IN (
	SELECT nazwisko FROM pracownicy
	JOIN wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
	JOIN pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
	WHERE pensja.kwota < 1200
);