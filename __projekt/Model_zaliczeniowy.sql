# 1.Funkcja podająca ilość transakcji w bieżącym miesiącu


DELIMITER //
CREATE FUNCTION Podaj_ilosc_transakcji_miesiac()
    RETURNS INTEGER
BEGIN
    DECLARE ile INT;
    SELECT COUNT(DISTINCT Id_transakcji) INTO @ile
	FROM Transakcja
	WHERE (MONTH(now())-MONTH(Data_transakcji)) <= 1;
    RETURN @ile;
END //
DELIMITER ;





select Podaj_ilosc_transakcji_miesiac();














# 2.Procedura zmieniająca cenę danego rodzaju paliwa

DELIMITER $$
CREATE PROCEDURE zmiana_ceny(IN id INT, x FLOAT)
BEGIN
UPDATE Paliwo SET Cena_l = x * Cena_l WHERE Id_rodzaju = id;
END
$$
DELIMITER ;






CALL zmiana_ceny(1,1.5);














# 3.Trigger dodający paliwo do stanu

DELIMITER $$
CREATE TRIGGER dodawanie_stanu_after_insert_on_paliwo
AFTER INSERT ON Dostawa_paliwa
FOR EACH ROW
BEGIN
IF NEW.Id_rodzaju=1
THEN
UPDATE Paliwo
SET Paliwo.Stan_objetosci=Paliwo.Stan_objetosci+NEW.Objetosc
WHERE Paliwo.Id_rodzaju=1;

ELSE IF NEW.Id_rodzaju=2
THEN
UPDATE Paliwo
SET Paliwo.Stan_objetosci=Paliwo.Stan_objetosci+NEW.Objetosc
WHERE Paliwo.Id_rodzaju=2;

ELSE IF NEW.Id_rodzaju=3
THEN
UPDATE Paliwo
SET Paliwo.Stan_objetosci=Paliwo.Stan_objetosci+NEW.Objetosc
WHERE Paliwo.Id_rodzaju=3;

END IF;
END IF;
END IF;
END
$$
DELIMITER ;














# 4.Trigger zdejmujący paliwo ze stanu

DELIMITER $$
CREATE TRIGGER zmniejszanie_stanu_after_insert_on_paliwo
AFTER INSERT ON Transakcja
FOR EACH ROW
BEGIN
IF NEW.Id_rodzaju=1
THEN
UPDATE Paliwo
SET Paliwo.Stan_objetosci=Paliwo.Stan_objetosci-NEW.Objetosc
WHERE Paliwo.Id_rodzaju=1;

ELSE IF NEW.Id_rodzaju=2
THEN
UPDATE Paliwo
SET Paliwo.Stan_objetosci=Paliwo.Stan_objetosci-NEW.Objetosc
WHERE Paliwo.Id_rodzaju=2;

IF NEW.Id_rodzaju=3
THEN
UPDATE Paliwo
SET Paliwo.Stan_objetosci=Paliwo.Stan_objetosci-NEW.Objetosc
WHERE Paliwo.Id_rodzaju=3;
END IF;
END IF;
END IF;
END
$$
DELIMITER ;














# 5.Trigger dodający artykuły do stanu

DELIMITER $$
CREATE TRIGGER dodawanie_stanu_after_insert_on_artykul
AFTER INSERT ON Dostawa_artykulow
FOR EACH ROW
BEGIN
IF NEW.Id_artykulu=1
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci+NEW.Ilosc
WHERE Artykul.Id_artykulu=1;

ELSE IF NEW.Id_artykulu=2
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci+NEW.Ilosc
WHERE Artykul.Id_artykulu=2;

ELSE IF NEW.Id_artykulu=3
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci+NEW.Ilosc
WHERE Artykul.Id_artykulu=3;

ELSE IF NEW.Id_artykulu=4
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci+NEW.Ilosc
WHERE Artykul.Id_artykulu=4;

ELSE IF NEW.Id_artykulu=5
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci+NEW.Ilosc
WHERE Artykul.Id_artykulu=5;

ELSE IF NEW.Id_artykulu=6
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci+NEW.Ilosc
WHERE Artykul.Id_artykulu=6;

ELSE IF NEW.Id_artykulu=7
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci+NEW.Ilosc
WHERE Artykul.Id_artykulu=7;

ELSE IF NEW.Id_artykulu=8
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci+NEW.Ilosc
WHERE Artykul.Id_artykulu=8;

ELSE IF NEW.Id_artykulu=9
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci+NEW.Ilosc
WHERE Artykul.Id_artykulu=9;

ELSE IF NEW.Id_artykulu=10
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci+NEW.Ilosc
WHERE Artykul.Id_artykulu=10;

ELSE IF NEW.Id_artykulu=11
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci+NEW.Ilosc
WHERE Artykul.Id_artykulu=11;

ELSE IF NEW.Id_artykulu=12
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci+NEW.Ilosc
WHERE Artykul.Id_artykulu=12;

ELSE IF NEW.Id_artykulu=13
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci+NEW.Ilosc
WHERE Artykul.Id_artykulu=13;

ELSE IF NEW.Id_artykulu=14
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci+NEW.Ilosc
WHERE Artykul.Id_artykulu=14;

ELSE IF NEW.Id_artykulu=15
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci+NEW.Ilosc
WHERE Artykul.Id_artykulu=15;

ELSE IF NEW.Id_artykulu=16
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci+NEW.Ilosc
WHERE Artykul.Id_artykulu=16;

ELSE IF NEW.Id_artykulu=17
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci+NEW.Ilosc
WHERE Artykul.Id_artykulu=17;

ELSE IF NEW.Id_artykulu=18
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci+NEW.Ilosc
WHERE Artykul.Id_artykulu=18;

ELSE IF NEW.Id_artykulu=19
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci+NEW.Ilosc
WHERE Artykul.Id_artykulu=19;

ELSE IF NEW.Id_artykulu=20
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci+NEW.Ilosc
WHERE Artykul.Id_artykulu=20;

END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END
$$
DELIMITER ;














# 6.Trigger zdejmujący artykuły ze stanu

DELIMITER $$
CREATE TRIGGER zmniejszanie_stanu_after_insert_on_artykul
AFTER INSERT ON Transakcja
FOR EACH ROW
BEGIN
IF NEW.Id_artykulu=1
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci-NEW.Ilosc_zakupiona
WHERE Artykul.Id_artykulu=1;

ELSE IF NEW.Id_artykulu=2
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci-NEW.Ilosc_zakupiona
WHERE Artykul.Id_artykulu=2;

ELSE IF NEW.Id_artykulu=3
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci-NEW.Ilosc_zakupiona
WHERE Artykul.Id_artykulu=3;

ELSE IF NEW.Id_artykulu=4
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci-NEW.Ilosc_zakupiona
WHERE Artykul.Id_artykulu=4;

ELSE IF NEW.Id_artykulu=5
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci-NEW.Ilosc_zakupiona
WHERE Artykul.Id_artykulu=5;

ELSE IF NEW.Id_artykulu=6
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci-NEW.Ilosc_zakupiona
WHERE Artykul.Id_artykulu=6;

ELSE IF NEW.Id_artykulu=7
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci-NEW.Ilosc_zakupiona
WHERE Artykul.Id_artykulu=7;

ELSE IF NEW.Id_artykulu=8
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci-NEW.Ilosc_zakupiona
WHERE Artykul.Id_artykulu=8;

ELSE IF NEW.Id_artykulu=9
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci-NEW.Ilosc_zakupiona
WHERE Artykul.Id_artykulu=9;

ELSE IF NEW.Id_artykulu=10
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci-NEW.Ilosc_zakupiona
WHERE Artykul.Id_artykulu=10;

ELSE IF NEW.Id_artykulu=11
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci-NEW.Ilosc_zakupiona
WHERE Artykul.Id_artykulu=11;

ELSE IF NEW.Id_artykulu=12
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci-NEW.Ilosc_zakupiona
WHERE Artykul.Id_artykulu=12;

ELSE IF NEW.Id_artykulu=13
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci-NEW.Ilosc_zakupiona
WHERE Artykul.Id_artykulu=13;

ELSE IF NEW.Id_artykulu=14
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci-NEW.Ilosc_zakupiona
WHERE Artykul.Id_artykulu=14;

ELSE IF NEW.Id_artykulu=15
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci-NEW.Ilosc_zakupiona
WHERE Artykul.Id_artykulu=15;

ELSE IF NEW.Id_artykulu=16
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci-NEW.Ilosc_zakupiona
WHERE Artykul.Id_artykulu=16;

ELSE IF NEW.Id_artykulu=17
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci-NEW.Ilosc_zakupiona
WHERE Artykul.Id_artykulu=17;

ELSE IF NEW.Id_artykulu=18
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci-NEW.Ilosc_zakupiona
WHERE Artykul.Id_artykulu=18;

ELSE IF NEW.Id_artykulu=19
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci-NEW.Ilosc_zakupiona
WHERE Artykul.Id_artykulu=19;

ELSE IF NEW.Id_artykulu=20
THEN
UPDATE Artykul
SET Artykul.Stan_ilosci=Artykul.Stan_ilosci-NEW.Ilosc_zakupiona
WHERE Artykul.Id_artykulu=20;

END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END
$$
DELIMITER ;