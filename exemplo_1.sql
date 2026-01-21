create database DB_VITORIA_B;
use DB_VITORIA_B;

create table ESPORTES(
ID INT AUTO_INCREMENT PRIMARY KEY,
NOME VARCHAR(90),
QUANTIDADE_DE_PARTICIPANTES INT,
DETALHES VARCHAR(90),
DIFICULDADE VARCHAR(30));

insert into ESPORTES (NOME, QUANTIDADE_DE_PARTICIPANTES, DETALHES, DIFICULDADE) 
VALUES ('Patinação no Gelo', 
'20', 
'Patina só que no gelo', 
'Difícil');

insert into ESPORTES (NOME, QUANTIDADE_DE_PARTICIPANTES, DETALHES, DIFICULDADE) 
VALUES ('Tiro ao alvo', 
'12', 
'Ganha mais pontos quem for mais preciso e atirar no alvo', 
'Médio');

insert into ESPORTES (NOME, QUANTIDADE_DE_PARTICIPANTES, DETALHES, DIFICULDADE) 
VALUES ('Futebol', 
'22', 
'Chuta uma bola, se acertar a tal bola no gol do outro time, ganha pontos', 
'Médio');

insert into ESPORTES (NOME, QUANTIDADE_DE_PARTICIPANTES, DETALHES, DIFICULDADE) 
VALUES ('Vôlei', 
'12', 
'Ganha quem quebrar o braço de alguma jogadora adversária primeiro', 
'Médio');

insert into ESPORTES()
values(null, 'Natação Individual','8','Reze pro Michael Phelps não aparecer','Médio');
