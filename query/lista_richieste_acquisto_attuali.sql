-- Query 5: Estrazione lista delle richieste di acquisto in corso di un determinato ordin
-- aventi un prodotto candidato associato ma non ancora approvato o respinto

CREATE VIEW Query_5_RichiesteInCorsoConCandidato AS
SELECT
    ra.ID AS ID_richiesta,
    ra.data_creazione,
    c.nome AS categoria,
    u.nome AS nome_tecnico,
    u.cognome AS cognome_tecnico,
    pc.nome_prodotto,
    pc.nome_produttore,
    pc.prezzo,
    pc.data_proposta
FROM Richiesta_Acquisto ra
JOIN Categoria c ON ra.ID_categoria = c.ID
LEFT JOIN Utente u ON ra.ID_tecnico = u.ID
JOIN Prodotto_Candidato pc ON ra.ID = pc.ID_richiesta
WHERE ra.stato NOT IN ('chiusa')
AND pc.approvato IS NULL
AND ra.ID_ordinante = 2 -- Parametro: sostituire con l'ID dell'ordinante desiderato
ORDER BY ra.data_creazione DESC;