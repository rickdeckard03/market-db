-- Query 6: Estrazione lista delle richieste di acquisto non ancora assegnate ad alcun tecnico

CREATE VIEW Query_6_RichiesteNonAssegnate AS
SELECT
    ra.ID AS ID_richiesta,
    ra.data_creazione,
    u.nome AS nome_ordinante,
    u.cognome AS cognome_ordinante,
    c.nome AS categoria,
    ra.note_richiesta
FROM Richiesta_Acquisto ra
JOIN Utente u ON ra.ID_ordinante = u.ID
JOIN Categoria c ON ra.ID_categoria = c.ID
WHERE ra.ID_tecnico IS NULL
AND ra.stato = 'in_attesa'
ORDER BY ra.data_creazione ASC;