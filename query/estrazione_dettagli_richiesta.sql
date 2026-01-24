-- Query 8: Estrazione di tutti i dettagli di una richiesta di acquisto

DELIMITER $$
CREATE PROCEDURE Query_8_DettagliRichiesta (
    IN ID_Richiesta_Input INT
)
BEGIN
    SELECT 
        ra.ID AS ID_richiesta,
        ra.data_creazione,
        ra.data_assegnazione,
        ra.data_ordinazione,
        ra.data_chiusura,
        ra.stato,
        ra.esito_chiusura,
        ra.note_richiesta,
        ord.username AS ordinante_username,
        CONCAT(ord.nome, ' ', ord.cognome) AS ordinante_nome_completo,
        tec.username AS tecnico_username,
        CONCAT(tec.nome, ' ', tec.cognome) AS tecnico_nome_completo,
        c.nome AS categoria
    FROM Richiesta_Acquisto ra
    JOIN Utente ord ON ra.ID_ordinante = ord.ID
    LEFT JOIN Utente tec ON ra.ID_tecnico = tec.ID 
    JOIN Categoria c ON ra.ID_categoria = c.ID
    WHERE ra.ID = ID_Richiesta_Input;
    
    SELECT 
        car.nome AS caratteristica,
        vc.valore,
        car.obbligatoria
    FROM Valore_Caratteristica vc
    JOIN Caratteristica car ON vc.ID_caratteristica = car.ID
    WHERE vc.ID_richiesta = ID_Richiesta_Input
    ORDER BY car.obbligatoria DESC, car.nome;
    
    SELECT 
        pc.ID AS ID_prodotto,
        pc.nome_produttore,
        pc.nome_prodotto,
        pc.codice_prodotto,
        pc.prezzo,
        pc.URL,
        pc.note,
        pc.data_proposta,
        pc.approvato,
        pc.motivazione_rifiuto,
        pc.data_risposta
    FROM Prodotto_Candidato pc
    WHERE pc.ID_richiesta = ID_Richiesta_Input
    ORDER BY pc.data_proposta DESC;
END$$
DELIMITER ;
