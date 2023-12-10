--1
CREATE OR REPLACE FUNCTION fibonacci(n INT) RETURNS INT AS $$
DECLARE
    a INT := 0;
    b INT := 1;
    i INT := 0;
BEGIN
    WHILE i < n LOOP
        RAISE NOTICE '%', a;
        i := i + 1;
        b := a + b;
        a := b - a;
    END LOOP;
    RETURN a;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE printFibonacci(n INT) AS $$
BEGIN
    SELECT fibonacci(n);
END;
$$ LANGUAGE plpgsql;

CALL printFibonacci(10);


--2
CREATE OR REPLACE FUNCTION lastnameUP()
RETURNS TRIGGER AS $$
BEGIN
    NEW.person.lastname := UPPER(NEW.person.lastname);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER lastnameUP_trigger
BEFORE INSERT OR UPDATE ON person
FOR EACH ROW
EXECUTE FUNCTION lastnameUP();


--3
CREATE OR REPLACE FUNCTION taxRateMonitoring()
RETURNS TRIGGER AS $$
DECLARE
    oldTaxrate numeric;
    newTaxrate numeric;
    maxChange numeric;
BEGIN
    oldTaxrate := COALESCE(OLD.taxrate, 0);
    newTaxrate := COALESCE(NEW.taxrate, 0);
    
    maxChange := oldTaxrate * 0.3; -- 30% zmiana

    IF ABS(oldTaxrate - newTaxrate) > max_change THEN
        RAISE EXCEPTION 'Zmiana wartości w polu TaxRate o więcej niż 30%%!';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER taxRateMonitoring
BEFORE UPDATE ON salestaxrate
FOR EACH ROW
WHEN (NEW.taxrate IS NOT NULL)
EXECUTE FUNCTION taxRateMonitoring();