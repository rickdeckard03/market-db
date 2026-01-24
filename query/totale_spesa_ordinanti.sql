-- Query 10: Calcolo somma totale spesa da ordinanti per anno solare

CREATE VIEW Query_10_SpesaAnnualeOrdinante AS
SELECT 
    u.ID AS ID_Ordinante,
    CONCAT(u.nome, ' ', u.cognome) AS Nome_Completo_Ordinante,
    YEAR(ra.data_chiusura) AS Anno_Riferimento,
    SUM(pc.prezzo) AS Spesa_Totale
FROM Utente u
JOIN Richiesta_Acquisto ra ON u.ID = ra.ID_ordinante
JOIN Prodotto_Candidato pc ON ra.ID = pc.ID_richiesta
WHERE u.tipo_utente = 'ordinante'
  AND pc.approvato = TRUE
  AND ra.stato = 'chiusa'
  AND ra.esito_chiusura = 'accettato'
GROUP BY u.ID, u.nome, u.cognome, YEAR(ra.data_chiusura)
ORDER BY Spesa_Totale DESC;
