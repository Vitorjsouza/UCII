CREATE DATABASE naramarket;

USE naramarket;

CREATE TABLE lojas (
 id_loja INT PRIMARY KEY,
 nome VARCHAR(100) NOT NULL,
 bairro VARCHAR(50)
);

CREATE TABLE produtos ( 
id_produto INT PRIMARY KEY,
nome VARCHAR (150) NOT NULL,
categoria VARCHAR (100) NOT NULL,
preco DECIMAL (10,2));

CREATE TABLE vendas (
 id_venda INT PRIMARY KEY,
 id_produto INT NOT NULL,
 id_loja INT NOT NULL,
 quantidade INT,
 valor DECIMAL(8,2),
 data_venda DATE,
 FOREIGN KEY (id_produto)
 REFERENCES produtos(id_produto),
 FOREIGN KEY (id_loja)
 REFERENCES lojas(id_loja)
);

DROP TABLE lojas; # DROP apaga a informação

SET GLOBAL local_infile = 1;

LOAD DATA INFILE "C:/Users/vitor.jsouza/Downloads/naramarket_lojas.csv"
INTO TABLE lojas
FIELDS TERMINATED BY ','    -- delimitador do CSV
LINES TERMINATED BY '\n'
IGNORE 1 ROWS               -- ignora a primeira linha do CSV
(id_loja, nome, bairro);

LOAD DATA INFILE "C:/Users/vitor.jsouza/Downloads/naramarket_produtos.csv"
INTO TABLE produtos
FIELDS TERMINATED BY ','    -- delimitador do CSV
LINES TERMINATED BY '\n'
IGNORE 1 ROWS               -- ignora a primeira linha do CSV
(id_produto, nome, categoria, preco);

LOAD DATA INFILE "C:/Users/vitor.jsouza/Downloads/naramarket_vendas.csv"
INTO TABLE vendas
FIELDS TERMINATED BY ','    -- delimitador do CSV
LINES TERMINATED BY '\n'
IGNORE 1 ROWS               -- ignora a primeira linha do CSV
(id_venda, id_produto, id_loja, quantidade, valor, data_venda);

SELECT * FROM vendas
WHERE valor > 100;          -- filtro

SELECT id_produto, valor FROM vendas
ORDER BY valor DESC
LIMIT 5;

SELECT id_produto, valor FROM vendas
WHERE id_loja = 3;

SELECT id_produto, valor, data_venda FROM vendas
WHERE data_venda >= '2024-03-01'
AND data_venda <= '2024-03-31';

SELECT id_produto, valor FROM vendas
WHERE id_produto IN (5, 12, 47);


-- Total vendido por produto
SELECT id_produto, SUM(valor) AS total_vendas
FROM vendas
GROUP BY id_produto
ORDER BY total_vendas DESC;

SELECT id_produto, SUM(valor) AS total_vendas
FROM vendas
WHERE data_venda >= "2024-06-01"    -- WHERE filtra a coluna que existe antes da base
GROUP BY id_produto
HAVING total_vendas >= 10000  -- HAVING filtra depois que surge do groupby
ORDER BY total_vendas DESC;


-- Quantidade de vendas por loja
SELECT id_loja, COUNT(id_venda) AS quantidade
FROM vendas
GROUP BY id_loja;





