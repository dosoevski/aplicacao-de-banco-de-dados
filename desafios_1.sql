
create database RH_DB_VITORIA;
use RH_DB_VITORIA;

-- passo 2: criar a tabela departamentos
create table DEPARTAMENTOS (
    ID_DEPTO int primary key,
    NOME_DEPTO varchar(50)
);

-- criar a tabela níveis salariais
create table NIVEIS_SALARIAIS (
    NIVEL varchar(20) primary key,
    SALARIO_MIN decimal(10, 2),
    SALARIO_MAX decimal(10, 2)
);
-- criar a tabela funcionários
create table FUNCIONARIOS (
    ID_FUNC int primary key,
    NOME varchar(100),
    SALARIO decimal(10, 2),
    ID_DEPTO int
);

-- passo 3: inserir os dados iniciais
insert into DEPARTAMENTOS 
values (1, 'Vendas'), (2, 'TI'), (3, 'Inovação');

insert into NIVEIS_SALARIAIS 
values ('Junior', 3000, 5000), ('Pleno', 5001, 9000), ('Senior', 9001, 15000);

insert into FUNCIONARIOS 
values (1, 'Ana', 4500, 1), (2, 'Beto', 8200, 1), (3, 'Clara', 12500, 2);