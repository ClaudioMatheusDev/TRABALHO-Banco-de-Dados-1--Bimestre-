# README para o Banco de Dados RestauranteCM

## Visão Geral

O banco de dados `RestauranteCM` foi projetado para gerenciar as operações de um restaurante, incluindo o controle de clientes, encomendas, pratos, ingredientes e compras de ingredientes. Este README descreve a estrutura do banco de dados, as tabelas, e as relações entre elas.

## Estrutura do Banco de Dados

### 1. Tabela `Cliente`

Armazena informações sobre os clientes do restaurante.

```sql
CREATE TABLE Cliente (
    Id_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(255) NOT NULL,
    Telefone VARCHAR(20) NOT NULL
);
```

- **Id_Cliente:** Identificador único do cliente (chave primária).
- **Nome:** Nome completo do cliente.
- **Endereco:** Endereço do cliente.
- **Telefone:** Número de telefone do cliente.

### 2. Tabela `Prato`

Armazena informações sobre os pratos disponíveis no restaurante.

```sql
CREATE TABLE Prato (
    ID_Prato INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Preco DECIMAL(10, 2) NOT NULL
);
```

- **ID_Prato:** Identificador único do prato (chave primária).
- **Nome:** Nome do prato.
- **Preco:** Preço unitário do prato.

### 3. Tabela `Ingrediente`

Armazena informações sobre os ingredientes utilizados para preparar os pratos.

```sql
CREATE TABLE Ingrediente (
    ID_Ingrediente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL
);
```

- **ID_Ingrediente:** Identificador único do ingrediente (chave primária).
- **Nome:** Nome do ingrediente.

### 4. Tabela `Encomenda`

Armazena informações sobre as encomendas feitas pelos clientes.

```sql
CREATE TABLE Encomenda (
    ID_Encomenda INT PRIMARY KEY AUTO_INCREMENT,
    Id_Cliente INT,
    Data DATE,
    FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente)
);
```

- **ID_Encomenda:** Identificador único da encomenda (chave primária).
- **Id_Cliente:** Identificador do cliente que fez a encomenda (chave estrangeira).
- **Data:** Data da encomenda.

### 5. Tabela `ItemEncomenda`

Relaciona encomendas aos pratos solicitados e inclui a quantidade de cada prato na encomenda.

```sql
CREATE TABLE ItemEncomenda (
    ID_ItemEncomenda INT PRIMARY KEY AUTO_INCREMENT,
    ID_Encomenda INT,
    ID_Prato INT,
    Quantidade INT,
    FOREIGN KEY (ID_Encomenda) REFERENCES Encomenda(ID_Encomenda),
    FOREIGN KEY (ID_Prato) REFERENCES Prato(ID_Prato)
);
```

- **ID_ItemEncomenda:** Identificador único do item da encomenda (chave primária).
- **ID_Encomenda:** Identificador da encomenda (chave estrangeira).
- **ID_Prato:** Identificador do prato solicitado (chave estrangeira).
- **Quantidade:** Quantidade do prato solicitado.

### 6. Tabela `CompostoPor`

Define a composição dos pratos, ou seja, os ingredientes necessários para cada prato.

```sql
CREATE TABLE CompostoPor (
    ID_Prato INT,
    ID_Ingrediente INT,
    Quantidade DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (ID_Prato, ID_Ingrediente),
    FOREIGN KEY (ID_Prato) REFERENCES Prato(ID_Prato),
    FOREIGN KEY (ID_Ingrediente) REFERENCES Ingrediente(ID_Ingrediente)
);
```

- **ID_Prato:** Identificador do prato (chave primária composta).
- **ID_Ingrediente:** Identificador do ingrediente (chave primária composta).
- **Quantidade:** Quantidade do ingrediente necessária para o prato.

### 7. Tabela `Compra`

Registra a compra de ingredientes, incluindo detalhes como a data da compra e o fornecedor.

```sql
CREATE TABLE Compra (
    ID_Compra INT PRIMARY KEY AUTO_INCREMENT,
    Data DATETIME NOT NULL,
    Fornecedor VARCHAR(100) NOT NULL,
    NotaFiscal VARCHAR(50) NOT NULL
);
```

- **ID_Compra:** Identificador único da compra (chave primária).
- **Data:** Data e hora da compra.
- **Fornecedor:** Nome do fornecedor dos ingredientes.
- **NotaFiscal:** Número da nota fiscal da compra.

### 8. Tabela `ItemCompra`

Relaciona compras aos ingredientes, especificando a quantidade comprada de cada ingrediente.

```sql
CREATE TABLE ItemCompra (
    ID_ItemCompra INT PRIMARY KEY AUTO_INCREMENT,
    ID_Compra INT,
    ID_Ingrediente INT,
    Quantidade DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ID_Compra) REFERENCES Compra(ID_Compra),
    FOREIGN KEY (ID_Ingrediente) REFERENCES Ingrediente(ID_Ingrediente)
);
```

- **ID_ItemCompra:** Identificador único do item de compra (chave primária).
- **ID_Compra:** Identificador da compra (chave estrangeira).
- **ID_Ingrediente:** Identificador do ingrediente comprado (chave estrangeira).
- **Quantidade:** Quantidade do ingrediente comprada.

## Consultas Exemplares

1. **Obter Encomendas de um Cliente:**

   ```sql
   SELECT e.ID_Encomenda, c.Nome, c.Endereco, c.Telefone, p.Nome AS Prato, ie.Quantidade, p.Preco
   FROM Encomenda e
   JOIN Cliente c ON e.Id_Cliente = c.Id_Cliente
   JOIN ItemEncomenda ie ON e.ID_Encomenda = ie.ID_Encomenda
   JOIN Prato p ON ie.ID_Prato = p.ID_Prato
   WHERE c.Id_Cliente = ?;
   ```

2. **Gerar Relatório de Compras de Ingredientes:**

   ```sql
   SELECT c.NotaFiscal, c.Data, c.Fornecedor, i.Nome AS Ingrediente, ic.Quantidade
   FROM Compra c
   JOIN ItemCompra ic ON c.ID_Compra = ic.ID_Compra
   JOIN Ingrediente i ON ic.ID_Ingrediente = i.ID_Ingrediente;
   ```
