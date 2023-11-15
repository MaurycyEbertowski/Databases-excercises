/*Nie wiem jeszcze do końca jak działa pgAdmin i nie wiem jak znaleźć cały kod użyty do 
tworzenia tej bazy. Starsze polecenia były w Query History, ale gdy odpaliłem program nowego
dnia to jest tam tylko kod, który pisałem dzisiaj. Dlatego w poniższym skrypcie nie ma kodu
z samego początku czyli np. tworzenie tabel*/
ALTER TABLE rozliczenia.pensje
ADD CONSTRAINT klucz_id_premii FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);

INSERT INTO rozliczenia.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
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
INSERT INTO rozliczenia.godziny (id_godziny, data1, liczba_godzin, id_pracownika)
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
INSERT INTO rozliczenia.premie (id_premii, rodzaj, kwota)
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
INSERT INTO rozliczenia.pensje (id_pensji, stanowisko, kwota, id_premii)
VALUES
	('10', 'Kierownik', 1500.0, 'A1'),
	('12', 'Manager', 2500.0, 'A2'),
	('13', 'Intern', 1000.0, 'A3'),
	('14', 'Junior', 1800.0, 'A4'),
	('15', 'Junior', 1800.0, 'A5'),
	('16', 'Ochroniarz', 2000.0, 'A6'),
	('17', 'Mid', 3500.0, 'A7'),
	('18', 'Senior', 4500.0, 'A8'),
	('19', 'Szef', 15000.0, 'A9'),
	('20', 'Mid', 3000.0, 'B1');
	
SELECT nazwisko, adres FROM rozliczenia.pracownicy

SELECT
  id_godziny,
  to_char(data1, 'Day') AS dzien_tygodnia,
  date_part('month', data1) AS miesiac
FROM rozliczenia.godziny;

ALTER TABLE rozliczenia.pensje
RENAME COLUMN kwota TO kwota_brutto;

ALTER TABLE rozliczenia.pensje
ADD COLUMN kwota_netto float;

UPDATE rozliczenia.pensje
SET kwota_netto = kwota_brutto * 0.88;