-- Query 4: Eliminazione di una richiesta di acquisto dal sistema

CREATE VIEW Query_4_EliminaRichiesta AS
SELECT
'DELETE FROM Richiesta_Acquisto WHERE ID = ?' AS query_template;