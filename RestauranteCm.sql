-- Criação do banco de dados
CREATE DATABASE RestauranteCM;
USE RestauranteCM;

-- Tabela de Clientes
CREATE TABLE Cliente (
    Id_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(255) NOT NULL,
    Telefone VARCHAR(20) NOT NULL
);

-- Tabela de Pratos
CREATE TABLE Prato (
    ID_Prato INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Preco DECIMAL(10, 2) NOT NULL
);

-- Tabela de Ingredientes
CREATE TABLE Ingrediente (
    ID_Ingrediente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL
);

-- Tabela de Encomendas
CREATE TABLE Encomenda (
    ID_Encomenda INT PRIMARY KEY AUTO_INCREMENT,
    Id_Cliente INT,
    Data DATE,
    FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente)
);

-- Tabela de Itens da Encomenda
CREATE TABLE ItemEncomenda (
    ID_ItemEncomenda INT PRIMARY KEY AUTO_INCREMENT,
    ID_Encomenda INT,
    ID_Prato INT,
    Quantidade INT,
    FOREIGN KEY (ID_Encomenda) REFERENCES Encomenda(ID_Encomenda),
    FOREIGN KEY (ID_Prato) REFERENCES Prato(ID_Prato)
);

-- Tabela de Composição de Pratos (ingredientes usados em pratos)
CREATE TABLE CompostoPor (
    ID_Prato INT,
    ID_Ingrediente INT,
    Quantidade DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (ID_Prato, ID_Ingrediente),
    FOREIGN KEY (ID_Prato) REFERENCES Prato(ID_Prato),
    FOREIGN KEY (ID_Ingrediente) REFERENCES Ingrediente(ID_Ingrediente)
);

-- Tabela de Compras
CREATE TABLE Compra (
    ID_Compra INT PRIMARY KEY AUTO_INCREMENT,
    Data DATETIME NOT NULL,
    Fornecedor VARCHAR(100) NOT NULL,
    NotaFiscal VARCHAR(50) NOT NULL
);

-- Tabela de Itens de Compra
CREATE TABLE ItemCompra (
    ID_ItemCompra INT PRIMARY KEY AUTO_INCREMENT,
    ID_Compra INT,
    ID_Ingrediente INT,
    Quantidade DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ID_Compra) REFERENCES Compra(ID_Compra),
    FOREIGN KEY (ID_Ingrediente) REFERENCES Ingrediente(ID_Ingrediente)
);

ALTER TABLE Encomendas ADD FOREIGN KEY(idCliente) REFERENCES Cliente (idCliente)
ALTER TABLE Encomendas ADD FOREIGN KEY(Data) REFERENCES undefined (Data)
ALTER TABLE ItemEncomenda ADD FOREIGN KEY(idEncomendas) REFERENCES Encomendas (idEncomendas)
ALTER TABLE ItemEncomenda ADD FOREIGN KEY(ID_Prato) REFERENCES Prato (ID_Prato)
ALTER TABLE CompostoPor ADD FOREIGN KEY(idTabela) REFERENCES Prato (idTabela)
ALTER TABLE CompostoPor ADD FOREIGN KEY(idItemEncomenda) REFERENCES ItemEncomenda (idItemEncomenda)
ALTER TABLE Compra ADD FOREIGN KEY(idCompostoPor) REFERENCES CompostoPor (idCompostoPor)
ALTER TABLE ItemCompra ADD FOREIGN KEY(ID_Compra) REFERENCES Compra (ID_Compra)
ALTER TABLE ItemCompra ADD FOREIGN KEY(ID_Ingrediente) REFERENCES Ingrediente (ID_Ingrediente)
