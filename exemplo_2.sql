create database bd_vendas;
use bd_vendas;

-- 1. Tabela de Produtos (Nomes de colunas não podem ter espaços)
CREATE TABLE tbl_produto (
    cod_produto INT UNSIGNED AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL, 
    desc_produto VARCHAR(100) NOT NULL,
    unid_medida VARCHAR(2) NOT NULL,
    estoque_atual INT DEFAULT 0,
    estoque_min INT DEFAULT 0,
    estoque_max INT DEFAULT 0,
    valor DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (cod_produto)
);

-- 2. Tabela de Endereços (Fechamento de parênteses corrigido)
CREATE TABLE tbl_endereco (
    id INT(10) NOT NULL,
    cep INT(9) NOT NULL,
    logradouro VARCHAR(90) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado CHAR(2) NOT NULL,
    CONSTRAINT pk_endereco PRIMARY KEY (cep)
);

-- 3. Tabela de Clientes (Correção de aspas e vírgulas nos DEFAULTS)
CREATE TABLE tbl_cliente (
    cod_cliente INT UNSIGNED AUTO_INCREMENT,
    nome_cliente VARCHAR(45) NOT NULL,
    cpf VARCHAR(11) DEFAULT '',
    data_nasc DATE,
    cep INT(9) DEFAULT 0,
    numero VARCHAR(10),
    complemento VARCHAR(20) DEFAULT '',
    PRIMARY KEY (cod_cliente),
    CONSTRAINT fk_cliencep FOREIGN KEY (cep) REFERENCES tbl_endereco(cep)
);

-- 4. Tabela de Pedidos
CREATE TABLE tbl_pedido (
    cod_pedido INT UNSIGNED AUTO_INCREMENT,
    data_pedido DATE,
    data_entrega DATE,
    cod_cliente INT UNSIGNED NOT NULL,
    PRIMARY KEY (cod_pedido),
    CONSTRAINT fk_cliente FOREIGN KEY (cod_cliente) REFERENCES tbl_cliente (cod_cliente)
);

-- 5. Tabela de Itens do Pedido (Correção do nome da coluna na referência)
CREATE TABLE tbl_itempedido (
    qtde INT UNSIGNED NOT NULL,
    i_cod_pedido INT UNSIGNED NOT NULL, 
    i_cod_produto INT UNSIGNED NOT NULL, 
    i_valor DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_pedido1 FOREIGN KEY (i_cod_pedido) REFERENCES tbl_pedido (cod_pedido),
    CONSTRAINT fk_tbl_produto1 FOREIGN KEY (i_cod_produto) REFERENCES tbl_produto (cod_produto)
);
