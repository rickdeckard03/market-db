-- Query 1: Inserimento di una richiesta di acquisto

DELIMITER $$
CREATE PROCEDURE Query_1_InserisciRichiesta (
    IN ID_Cliente_Ordinante INT,
    IN ID_Categoria INT,
    IN Note_Testuali TEXT,
    IN Stringa_Dati_Caratteristiche TEXT 
)
BEGIN
    DECLARE ID_Nuova_Richiesta INT;
    DECLARE Stringa_Residua TEXT;
    DECLARE Coppia_Corrente TEXT;
    DECLARE Posizione_Separatore INT;
    DECLARE ID_Caratteristica_Temp INT;
    DECLARE Valore_Caratteristica_Temp TEXT;

    INSERT INTO Richiesta_Acquisto (ID_ordinante, ID_categoria, note_richiesta, stato)
    VALUES (ID_Cliente_Ordinante, ID_Categoria, Note_Testuali, 'in_attesa');
    
    SET ID_Nuova_Richiesta = LAST_INSERT_ID();

    SET Stringa_Residua = Stringa_Dati_Caratteristiche;
    
    WHILE LENGTH(Stringa_Residua) > 0 DO
        
        SET Posizione_Separatore = INSTR(Stringa_Residua, '|');
        
        IF Posizione_Separatore = 0 THEN
            SET Coppia_Corrente = Stringa_Residua;
            SET Stringa_Residua = '';
        ELSE
            SET Coppia_Corrente = LEFT(Stringa_Residua, Posizione_Separatore - 1);
            SET Stringa_Residua = SUBSTRING(Stringa_Residua, Posizione_Separatore + 1);
        END IF;
        
        SET ID_Caratteristica_Temp = SUBSTRING_INDEX(Coppia_Corrente, ':', 1);
        SET Valore_Caratteristica_Temp = SUBSTRING_INDEX(Coppia_Corrente, ':', -1);
        
        INSERT INTO Valore_Caratteristica (ID_richiesta, ID_caratteristica, valore)
        VALUES (ID_Nuova_Richiesta, ID_Caratteristica_Temp, Valore_Caratteristica_Temp);
        
    END WHILE;
    
    SELECT ID_Nuova_Richiesta AS ID_richiesta_creata;
END$$
DELIMITER ;
