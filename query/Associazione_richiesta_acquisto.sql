-- Query 2: Associazione di una richiesta di acquisto a un tecnico incaricato

DELIMITER $$
CREATE PROCEDURE Query_2_AssegnaTecnico (
    IN ID_Tecnico_Scelto INT,       
    IN ID_Richiesta_Da_Assegnare INT
)
BEGIN
    UPDATE Richiesta_Acquisto 
    SET ID_tecnico = ID_Tecnico_Scelto
    WHERE ID = ID_Richiesta_Da_Assegnare;

    SELECT CONCAT('Richiesta ', ID_Richiesta_Da_Assegnare, ' assegnata al tecnico ', ID_Tecnico_Scelto) AS Esito;
END$$
DELIMITER ;