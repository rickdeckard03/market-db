-- Query 3: Approvazione del prodotto candidato relativo a una richiesta di acquisto

DELIMITER $$
CREATE PROCEDURE Query_3_Gestisci_Approvazione_Prodotto (
    IN ID_Prodotto_Da_Giudicare INT,       
    IN Decisione_Approvato BOOLEAN,        
    IN Motivazione_Eventuale_Rifiuto TEXT  
)
BEGIN
    DECLARE ID_Richiesta_Collegata INT;
    
    UPDATE Prodotto_Candidato
    SET 
        approvato = Decisione_Approvato, 
        motivazione_rifiuto = IF(Decisione_Approvato = FALSE, Motivazione_Eventuale_Rifiuto, NULL),
        
        data_risposta = CURRENT_TIMESTAMP
    WHERE ID = ID_Prodotto_Da_Giudicare;
    
    SELECT ID_richiesta INTO ID_Richiesta_Collegata
    FROM Prodotto_Candidato
    WHERE ID = ID_Prodotto_Da_Giudicare;

    IF Decisione_Approvato = TRUE THEN
    
        UPDATE Richiesta_Acquisto
        SET stato = 'approvata'
        WHERE ID = ID_Richiesta_Collegata;
    ELSE
        UPDATE Richiesta_Acquisto
        SET stato = 'respinta'
        WHERE ID = ID_Richiesta_Collegata;
    END IF;
    
    SELECT 'Decisione sul prodotto registrata con successo' AS Esito;
END$$
DELIMITER ;