-- Trigger: Verifica che l'ordinante sia effettivamente un ordinante
DELIMITER $$
CREATE TRIGGER check_ordinante_role
BEFORE INSERT ON Richiesta_Acquisto
FOR EACH ROW
BEGIN
    DECLARE ruolo VARCHAR(20);
    SELECT tipo_utente INTO ruolo FROM Utente WHERE ID = NEW.ID_ordinante;
    IF ruolo != 'ordinante' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'L''utente specificato non è un ordinante';
    END IF;
END$$
DELIMITER ;

-- Trigger: Verifica che il tecnico sia effettivamente un tecnico
DELIMITER $$
CREATE TRIGGER check_tecnico_role
BEFORE UPDATE ON Richiesta_Acquisto
FOR EACH ROW
BEGIN
    DECLARE ruolo VARCHAR(20);
    IF NEW.ID_tecnico IS NOT NULL THEN
        SELECT tipo_utente INTO ruolo FROM Utente WHERE ID = NEW.ID_tecnico;
        IF ruolo != 'tecnico' THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'L''utente specificato non è un tecnico';
        END IF;
    END IF;
END$$
DELIMITER ;

-- Trigger: Aggiorna automaticamente la data_assegnazione e lo stato
DELIMITER $$
CREATE TRIGGER set_data_assegnazione
BEFORE UPDATE ON Richiesta_Acquisto
FOR EACH ROW
BEGIN
    IF OLD.ID_tecnico IS NULL AND NEW.ID_tecnico IS NOT NULL AND NEW.data_assegnazione IS NULL THEN
        SET NEW.data_assegnazione = CURRENT_TIMESTAMP;
        SET NEW.stato = 'assegnata';
    END IF;
END$$
DELIMITER ;