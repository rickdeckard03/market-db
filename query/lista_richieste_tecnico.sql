-- Query 7: Estrazione lista delle richieste associate a un determinato tecnico
-- con prodotto accettato ma non ancora ordinato

CREATE VIEW Query_7_RichiesteDaOrdinare AS
SELECT
    ra.ID AS ID_richiesta,
    ra.data_creazione,
    ra.data_assegnazione,
    u.nome AS nome_ordinante,
    u.cognome AS cognome_ordinante,
    c.nome AS categoria,
    pc.nome_prodotto,
    pc.nome_produttore,
    pc.codice_prodotto,
    pc.prezzo,
    pc.URL
FROM Richiesta_Acquisto ra
JOIN Utente u ON ra.ID_ordinante = u.ID
JOIN Categoria c ON ra.ID_categoria = c.ID
JOIN Prodotto_Candidato pc ON ra.ID = pc.ID_richiesta
WHERE ra.ID_tecnico = 4 -- Parametro: sostituire con l'ID del tecnico desiderato
AND ra.stato = 'approvata'
AND pc.approvato = TRUE
AND ra.data_ordinazione IS NULL
ORDER BY ra.data_creazione ASC;