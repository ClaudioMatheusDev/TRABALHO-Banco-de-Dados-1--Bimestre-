Create RestauranteCM

use RestauranteCM


CREATE TABLE Cliente 
( 
 Id_Cliente INT PRIMARY KEY,  
 Nome VARCHAR(n),  
 Endereço VARCHAR(n),  
 Telefone VARCHAR(n),  
); 

CREATE TABLE Encomendas 
( 
 idCliente INT,  
 ID_Encomenda INT PRIMARY KEY,  
 Data DATE,  
); 

CREATE TABLE ItemEncomenda 
( 
 ID_ItemEncomenda INT PRIMARY KEY,  
 idEncomendas INT,  
 Quantidade INT,  
 ID_Prato INT,  
); 

CREATE TABLE CompostoPor 
( 
 idTabela INT,  
 idItemEncomenda INT,  
); 

CREATE TABLE Prato 
( 
 ID_Prato INT PRIMARY KEY,  
 Nome VARCHAR(n),  
 Preço FLOAT,  
); 

CREATE TABLE Compra 
( 
 ID_Compra INT PRIMARY KEY,  
 Data DATE,  
 Fornecedor VARCHAR(n),  
 NotaFiscal VARCHAR(n),  
 idCompostoPor INT,  
); 

CREATE TABLE ItemCompra 
( 
 ID_Compra INT,  
 ID_Ingrediente INT,  
 Quantidade INT,  
); 

CREATE TABLE Ingrediente 
( 
 ID_Ingrediente INT PRIMARY KEY,  
 Nome VARCHAR(n),  
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
