-- Query 9: Conteggio richieste di acquisto gestite globalmente da un determinato tecnico

CREATE VIEW Query_9_ConteggioRichiesteTecnico AS
SELECT 
    u.ID AS ID_Tecnico,
    CONCAT(u.nome, ' ', u.cognome) AS Nome_Completo_Tecnico,
    COUNT(ra.ID) AS Numero_Richieste_Gestite
FROM Utente u
LEFT JOIN Richiesta_Acquisto ra ON u.ID = ra.ID_tecnico
WHERE u.tipo_utente = 'tecnico'
GROUP BY u.ID, u.nome, u.cognome
ORDER BY Numero_Richieste_Gestite DESC;
