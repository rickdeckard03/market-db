-- Utenti
INSERT INTO Utente (username, password, email, nome, cognome, tipo_utente) VALUES
('admin', SHA2('admin123', 256), 'admin@market.it', 'Admin', 'Sistema', 'amministratore'),
('mario.rossi', SHA2('pass123', 256), 'mario.rossi@prova.it', 'Mario', 'Rossi', 'ordinante'),
('laura.bianchi', SHA2('pass123', 256), 'laura.bianchi@prova.it', 'Laura', 'Bianchi', 'ordinante'),
('paolo.verdi', SHA2('pass123', 256), 'paolo.verdi@prova.it', 'Paolo', 'Verdi', 'tecnico'),
('anna.neri', SHA2('pass123', 256), 'anna.neri@prova.it', 'Anna', 'Neri', 'tecnico');

INSERT INTO Categoria (nome, descrizione, ID_padre) VALUES
('Informatica', 'Categoria generale per prodotti informatici', NULL), 
('Computer', 'Computer desktop e portatili', 1),                     
('PC Desktop', 'Computer fissi da scrivania', 2),                    
('Notebook', 'Computer portatili', 2),                              
('Arredamento', 'Mobili e arredi per ufficio', NULL),               
('Scrivania', 'Scrivanie di vario tipo', 5);                        

INSERT INTO Caratteristica (nome, tipo_dato, obbligatoria, ID_categoria) VALUES
('RAM (GB)', 'numero', TRUE, 3),        
('Processore', 'testo', TRUE, 3),    
('Hard Disk (GB)', 'numero', TRUE, 3),
('Scheda Video', 'testo', FALSE, 3),  
('Sistema Operativo', 'testo', TRUE, 3); 

INSERT INTO Caratteristica (nome, tipo_dato, obbligatoria, ID_categoria) VALUES
('RAM (GB)', 'numero', TRUE, 4),
('Processore', 'testo', TRUE, 4),
('Dimensione schermo (pollici)', 'numero', TRUE, 4),
('SSD (GB)', 'numero', TRUE, 4),
('Peso (kg)', 'numero', FALSE, 4);

INSERT INTO Caratteristica (nome, tipo_dato, obbligatoria, ID_categoria) VALUES
('Larghezza (cm)', 'numero', TRUE, 6),
('Profondità (cm)', 'numero', TRUE, 6),
('Altezza (cm)', 'numero', TRUE, 6),
('Materiale', 'testo', TRUE, 6),
('Colore', 'testo', FALSE, 6);