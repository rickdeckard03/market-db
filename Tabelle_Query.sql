DROP DATABASE IF EXISTS Market;
CREATE DATABASE Market CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE Market;

CREATE TABLE Utente (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR (50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR (100) NOT NULL UNIQUE,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    tipo_utente ENUM('amministratore', 'ordinante', 'tecnico') NOT NULL,
    INDEX idx_tipo_utente (tipo_utente)
) ENGINE=InnoDB;

CREATE TABLE Categoria (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descrizione TEXT,
    ID_padre INT NULL,
    FOREIGN KEY (ID_padre) REFERENCES Categoria (ID) ON DELETE SET NULL ON UPDATE CASCADE,
    INDEX idx_padre (ID_padre)
) ENGINE=InnoDB;

CREATE TABLE Caratteristica (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo_dato ENUM ('testo', 'numero', 'booleano') DEFAULT 'testo',
    obbligatoria BOOLEAN DEFAULT FALSE,
    ID_categoria INT NOT NULL,
    FOREIGN KEY (ID_categoria) REFERENCES Categoria (ID) ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX idx_categoria (ID_categoria)
) ENGINE=InnoDB;

CREATE TABLE Richiesta_Acquisto (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_ordinante INT NOT NULL,
    ID_tecnico INT NULL,
    ID_categoria INT NOT NULL,
    note_richiesta TEXT,
    data_creazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_assegnazione TIMESTAMP NULL,
    data_ordinazione TIMESTAMP NULL,
    data_chiusura TIMESTAMP NULL,
    stato ENUM('in_attesa', 'assegnata', 'prodotto_proposto', 'approvata',
               'respinta', 'ordinata', 'consegnata', 'chiusa') DEFAULT 'in_attesa',
    esito_chiusura ENUM('accettato', 'non_conforme', 'non_funzionante') NULL,
    FOREIGN KEY (ID_ordinante) REFERENCES Utente (ID) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (ID_tecnico) REFERENCES Utente (ID) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (ID_categoria) REFERENCES Categoria (ID) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX idx_ordinante (ID_ordinante),
    INDEX idx_tecnico (ID_tecnico),
    INDEX idx_stato (stato),
    INDEX idx_data_creazione (data_creazione)
) ENGINE=InnoDB;

CREATE TABLE Valore_Caratteristica (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_richiesta INT NOT NULL,
    ID_caratteristica INT NOT NULL,
    valore TEXT NOT NULL,
    FOREIGN KEY (ID_richiesta) REFERENCES Richiesta_Acquisto (ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ID_caratteristica) REFERENCES Caratteristica (ID) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE KEY unique_valore (ID_richiesta, ID_caratteristica)
) ENGINE=InnoDB;

CREATE TABLE Prodotto_Candidato (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_richiesta INT NOT NULL,
    nome_produttore VARCHAR(100) NOT NULL,
    nome_prodotto VARCHAR(200) NOT NULL,
    codice_prodotto VARCHAR(100) NOT NULL,
    prezzo DECIMAL (10,2) NOT NULL,
    URL VARCHAR(500),
    note TEXT,
    data_proposta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    approvato BOOLEAN NULL,
    motivazione_rifiuto TEXT NULL,
    data_risposta TIMESTAMP NULL,
    FOREIGN KEY (ID_richiesta) REFERENCES Richiesta_Acquisto (ID) ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX idx_richiesta (ID_richiesta),
    INDEX idx_approvato (approvato)
) ENGINE=InnoDB;