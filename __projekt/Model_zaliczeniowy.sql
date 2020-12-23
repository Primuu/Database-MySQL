-- -----------------------------------------------------
-- Table `trentowskia`.`Pracownik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trentowskia`.`Pracownik` (
  `Pesel` INT UNSIGNED NOT NULL,
  `Imie` VARCHAR(45) NOT NULL,
  `Nazwisko` VARCHAR(45) NOT NULL,
  `Data_ur` DATE NOT NULL,
  `Nr_telefonu` VARCHAR(15) NOT NULL,
  `Email` VARCHAR(70) NULL,
  `Nr_konta_bank` VARCHAR(20) NULL,
  `Data_zatrudnienia` DATE NOT NULL,
  `Data_zwolnienia` DATE NULL,
  PRIMARY KEY (`Pesel`),
  UNIQUE INDEX `Pesel_UNIQUE` (`Pesel` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trentowskia`.`Dostawca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trentowskia`.`Dostawca` (
  `Id_dostawcy` INT UNSIGNED NOT NULL,
  `Nazwa` VARCHAR(70) NOT NULL,
  `Nr_rozliczeniowy` VARCHAR(20) NOT NULL,
  `Nr_kontaktowy` VARCHAR(15) NOT NULL,
  `Miasto` VARCHAR(60) NOT NULL,
  `Ulica` VARCHAR(45) NULL,
  `Kod_pocztowy` VARCHAR(6) NOT NULL,
  PRIMARY KEY (`Id_dostawcy`),
  UNIQUE INDEX `Id_dostawcy_UNIQUE` (`Id_dostawcy` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trentowskia`.`Paliwo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trentowskia`.`Paliwo` (
  `Id_rodzaju` INT UNSIGNED NOT NULL,
  `Rodzaj` ENUM('Benzyna', 'ON', 'LPG') NOT NULL,
  `Cena_l` DECIMAL(4,2) NOT NULL,
  `Stan_objetosci` FLOAT UNSIGNED NOT NULL,
  PRIMARY KEY (`Id_rodzaju`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trentowskia`.`Dostawa_paliwa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trentowskia`.`Dostawa_paliwa` (
  `Id_dostawy_p` INT UNSIGNED NOT NULL,
  `Id_dostawcy` INT UNSIGNED NOT NULL,
  `Id_rodzaju` INT UNSIGNED NOT NULL,
  `Objetosc` FLOAT UNSIGNED NOT NULL,
  `Data_dostawy` DATE NOT NULL,
  `Naleznosc` DECIMAL(8,2) UNSIGNED NOT NULL,
  INDEX `fk_Dostawa_paliwa_Dostawca1_idx` (`Id_dostawcy` ASC) VISIBLE,
  INDEX `fk_Dostawa_paliwa_Paliwo1_idx` (`Id_rodzaju` ASC) VISIBLE,
  CONSTRAINT `fk_Dostawa_paliwa_Dostawca1`
    FOREIGN KEY (`Id_dostawcy`)
    REFERENCES `trentowskia`.`Dostawca` (`Id_dostawcy`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Dostawa_paliwa_Paliwo1`
    FOREIGN KEY (`Id_rodzaju`)
    REFERENCES `trentowskia`.`Paliwo` (`Id_rodzaju`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trentowskia`.`Artykul`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trentowskia`.`Artykul` (
  `Id_artykulu` INT UNSIGNED NOT NULL,
  `Nazwa_artykulu` VARCHAR(255) NOT NULL,
  `Cena_szt` DECIMAL(7,2) NOT NULL,
  `Stan_ilosci` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Id_artykulu`),
  UNIQUE INDEX `Id_artykulu_UNIQUE` (`Id_artykulu` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trentowskia`.`Dostawa_artykulow`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trentowskia`.`Dostawa_artykulow` (
  `Id_dostawy_a` INT UNSIGNED NOT NULL,
  `Id_dostawcy` INT UNSIGNED NOT NULL,
  `Id_artykulu` INT UNSIGNED NOT NULL,
  `Ilosc` INT UNSIGNED NOT NULL,
  `Data_dostawy` DATE NOT NULL,
  `Naleznosc` DECIMAL(8,2) UNSIGNED NOT NULL,
  INDEX `fk_Dostawa_artykolow_Dostawca1_idx` (`Id_dostawcy` ASC) VISIBLE,
  INDEX `fk_Dostawa_artykolow_Artykul1_idx` (`Id_artykulu` ASC) VISIBLE,
  CONSTRAINT `fk_Dostawa_artykolow_Dostawca1`
    FOREIGN KEY (`Id_dostawcy`)
    REFERENCES `trentowskia`.`Dostawca` (`Id_dostawcy`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Dostawa_artykolow_Artykul1`
    FOREIGN KEY (`Id_artykulu`)
    REFERENCES `trentowskia`.`Artykul` (`Id_artykulu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trentowskia`.`Transakcja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trentowskia`.`Transakcja` (
  `Id_transakcji` INT UNSIGNED NOT NULL,
  `Pracownik_Pesel` INT UNSIGNED NOT NULL,
  `Data_transakcji` DATE NOT NULL,
  `Id_artykulu` INT UNSIGNED NULL,
  `Ilosc_zakupiona` INT UNSIGNED NULL,
  `Id_rodzaju` INT UNSIGNED NULL,
  `Objetosc_zakupiona` FLOAT UNSIGNED NULL,
  INDEX `fk_Transakcja_Pracownik1_idx` (`Pracownik_Pesel` ASC) VISIBLE,
  INDEX `fk_Transakcja_Paliwo1_idx` (`Id_rodzaju` ASC) VISIBLE,
  INDEX `fk_Transakcja_Artykul1_idx` (`Id_artykulu` ASC) VISIBLE,
  CONSTRAINT `fk_Transakcja_Pracownik1`
    FOREIGN KEY (`Pracownik_Pesel`)
    REFERENCES `trentowskia`.`Pracownik` (`Pesel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transakcja_Paliwo1`
    FOREIGN KEY (`Id_rodzaju`)
    REFERENCES `trentowskia`.`Paliwo` (`Id_rodzaju`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transakcja_Artykul1`
    FOREIGN KEY (`Id_artykulu`)
    REFERENCES `trentowskia`.`Artykul` (`Id_artykulu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;




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