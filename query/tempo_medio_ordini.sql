-- Query 11: Calcolo tempo medio di evasione ordini per tecnico

CREATE VIEW Query_11_TempoMedioEvasione AS
SELECT 
    u.ID AS ID_Tecnico,
    CONCAT(u.nome, ' ', u.cognome) AS Nome_Completo_Tecnico,
    COUNT(ra.ID) AS Numero_Ordini_Evasi,
    AVG(TIMESTAMPDIFF(HOUR, ra.data_creazione, ra.data_ordinazione)) AS Media_Ore_Evasione,
    AVG(TIMESTAMPDIFF(DAY, ra.data_creazione, ra.data_ordinazione)) AS Media_Giorni_Evasione
FROM Utente u
JOIN Richiesta_Acquisto ra ON u.ID = ra.ID_tecnico
WHERE u.tipo_utente = 'tecnico'
  AND ra.data_ordinazione IS NOT NULL
GROUP BY u.ID, u.nome, u.cognome
ORDER BY Media_Giorni_Evasione ASC;
