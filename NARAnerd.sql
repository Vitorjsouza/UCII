CREATE DATABASE naranerd;

USE naranerd;

CREATE TABLE clientes (
 id_cliente INT PRIMARY KEY,
 nome VARCHAR(100) NOT NULL,
 email VARCHAR(100),
 cidade VARCHAR(100)
);

CREATE TABLE vendedores (
 id_vendedor INT PRIMARY KEY,
 nome VARCHAR(100) NOT NULL,
 loja VARCHAR(100)
);

CREATE TABLE produtos (
 id_produto INT PRIMARY KEY,
 nome VARCHAR(100) NOT NULL,
 categoria VARCHAR(100),
 preco DECIMAL (8,2)
);

CREATE TABLE vendas (
 id_venda INT PRIMARY KEY,
 id_cliente INT NOT NULL,
 id_vendedor INT NOT NULL,
id_produto INT NOT NULL,
 quantidade INT,
 valor DECIMAL(8,2),
 data_venda DATE,
 FOREIGN KEY (id_cliente)
 REFERENCES clientes(id_cliente),
 FOREIGN KEY (id_vendedor)
 REFERENCES vendedores(id_vendedor),
  FOREIGN KEY (id_produto)
 REFERENCES produtos(id_produto)
);

SET GLOBAL local_infile = 1;

LOAD DATA INFILE "C:/Users/vitor.jsouza/Downloads/naranerd_clientes.csv"
INTO TABLE clientes
FIELDS TERMINATED BY ','    -- delimitador do CSV
LINES TERMINATED BY '\n'
IGNORE 1 ROWS               -- ignora a primeira linha do CSV
(id_cliente, nome, email, cidade);

LOAD DATA INFILE "C:/Users/vitor.jsouza/Downloads/naranerd_vendedores.csv"
INTO TABLE vendedores
FIELDS TERMINATED BY ','    -- delimitador do CSV
LINES TERMINATED BY '\n'
IGNORE 1 ROWS               -- ignora a primeira linha do CSV
(id_vendedor, nome, loja);

LOAD DATA INFILE "C:/Users/vitor.jsouza/Downloads/naranerd_produtos.csv"
INTO TABLE produtos
FIELDS TERMINATED BY ','    -- delimitador do CSV
LINES TERMINATED BY '\n'
IGNORE 1 ROWS               -- ignora a primeira linha do CSV
(id_produto, nome, categoria, preco);

LOAD DATA INFILE "C:/Users/vitor.jsouza/Downloads/naranerd_vendas.csv"
INTO TABLE vendas
FIELDS TERMINATED BY ','    -- delimitador do CSV
LINES TERMINATED BY '\n'
IGNORE 1 ROWS               -- ignora a primeira linha do CSV
(id_venda, id_cliente, id_vendedor, id_produto, quantidade, valor, data_venda);

SELECT c.nome, SUM(v.valor) AS faturamento
FROM vendas v
JOIN clientes c ON v.id_cliente = c.id_cliente
GROUP BY c.nome
ORDER BY faturamento DESC;

SELECT ven.nome, COUNT(v.id_venda) AS total_vendas
FROM vendas v
JOIN vendedores ven ON v.id_vendedor = ven.id_vendedor
GROUP BY ven.nome
ORDER BY total_vendas DESC;

SELECT p.categoria, SUM(v.valor) AS faturamento
FROM vendas v
JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY p.categoria
ORDER BY faturamento DESC;


