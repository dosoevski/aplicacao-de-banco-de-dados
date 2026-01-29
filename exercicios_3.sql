
use DB_VITORIA_B;

create table if not exists BANK(
	BANK_ID INT auto_increment primary key,
    BANK_NAME varchar(50),
    COUNTRY varchar(30),
    IS_ACTIVE boolean default true,
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

create table if not exists CLIENT(
	CLIENT_ID INT auto_increment primary key,
    CLIENT_NAME varchar(45),
    EMAIL varchar(45),
    IS_ACTIVE boolean default true,
    BANK_ID INT,
    constraint fk_bank_id foreign key(BANK_ID) references BANK(BANK_ID) ON DELETE CASCADE,
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

create table if not exists ACCOUNT(
	ACCOUNT_ID INT auto_increment primary key,
    CLIENT_ID INT,
    BANK_ID INT,
    BALANCE DECIMAL(10,2),
    IS_BLOCKED boolean default false,
    constraint fk_client_id foreign key(CLIENT_ID) references CLIENT(CLIENT_ID),
    constraint fk_bank_id_account foreign key(BANK_ID) references BANK(BANK_ID) ON DELETE CASCADE,
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    
create table if not exists FUND_CATEGORY(
	FUND_CATEGORY_ID INT auto_increment primary key,
    CATEGORY_NAME varchar(30),
    DESCRIPTION varchar(50),
	CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	);
    
create table if not exists FUND(
	FUND_ID INT auto_increment primary key,
    FUND_CATEGORY_ID INT,
    BANK_ID INT,
    FUND_NAME varchar(35),
    RISK_LEVEL INT,
    MINIMUM_INVESTMENT DECIMAL(10,2),
    IS_OPEN boolean default true,
    constraint fk_fund_category_id foreign key (FUND_CATEGORY_ID) references FUND_CATEGORY(FUND_CATEGORY_ID),
	constraint fk_bank_id_fund foreign key(BANK_ID) references BANK(BANK_ID) ON DELETE CASCADE,
	CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	);

create table if not exists PORTFOLIO(
    PORTFOLIO_ID INT auto_increment PRIMARY KEY,
    CLIENT_ID INT,
    ACCOUNT_ID INT,
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    constraint fk_client_id_portfolio foreign key(CLIENT_ID) references CLIENT(CLIENT_ID) ON DELETE CASCADE,
    constraint fk_account_id_portfolio foreign key (ACCOUNT_ID) references ACCOUNT(ACCOUNT_ID) ON DELETE CASCADE
);

create table if not exists PORTFOLIO_FUND (
    PORTFOLIO_FUND_ID INT auto_increment primary key,
    PORTFOLIO_ID INT,
    FUND_ID INT,
    INVESTED_AMOUNT DECIMAL(10,2),
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    constraint fk_portifolio_id FOREIGN KEY (PORTFOLIO_ID) references PORTFOLIO(PORTFOLIO_ID) ON DELETE CASCADE,
    constraint fk_portifolio_fund_id FOREIGN KEY (FUND_ID) references FUND(FUND_ID) ON DELETE CASCADE
);
    
create table if not exists TRANSACTION(
	TRANSACTION_ID INT auto_increment primary key,
    ACCOUNT_ID INT,
    FUND_ID INT,
    AMOUNT DECIMAL(10,2),
    TRANSACTION_TYPE varchar(12),
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    constraint fk_account_id_tac foreign key (ACCOUNT_ID) references ACCOUNT(ACCOUNT_ID) on delete cascade,
    constraint fk_fund_id_tac FOREIGN KEY (FUND_ID) references FUND(FUND_ID) ON DELETE CASCADE
    );
    
    
insert into BANK(BANK_NAME, COUNTRY)
VALUE("Banco Prime","Brasil"),
("Banco Beta","Brasil"),
("Banco Omega","Grécia"),
("Banco Alpha","Grécia");

insert into CLIENT (CLIENT_NAME, EMAIL, BANK_ID)
VALUES("Clementina Sorriso","clementina@gmail.com",1),
( "Ricardo Tarantino","ricardito@gmail.com",3),
( "Anna Katherina","kathkath2000@gmail.com",4),
( "Caitlin de Bitencourt","atiradoradeelite@gmail.com",2),
( "Mauricio Nicholau","mauricio@gmail.com",1),
( "Mattias Tadeu","matias@gmail.com",3),
( "Fyodor Dostoyevski","crimesecastigo@gmail.com",1),
( "Clarice Lispector","horadaestrela@gmail.com",2),
( "Virginia Wolf","profarol1927@gmail.com",2),
( "Jane Austen","orgulhoepreconceito@gmail.com",2);


INSERT INTO ACCOUNT (CLIENT_ID, BANK_ID, BALANCE, IS_BLOCKED)
VALUES 
(1,1,1500.00, false),
(2,3,500.50, false),
(3, 4,0.01, false),
(4,2, 10.050, false),
(5,1,12.970, false),
(9,3,-1800.00, true);

INSERT INTO ACCOUNT (CLIENT_ID, BANK_ID, BALANCE, IS_BLOCKED)
VALUES (10,2,2.550, false),
(6,3,-12.50, true),
(7,1,50, false),
(8,2,2.50, false);

insert into FUND_CATEGORY(CATEGORY_NAME, DESCRIPTION)
VALUES("Fundo de Herança","Só pra herdeiros"),
("Fundo 11","Só pra caixa 2"),
("Frente única","Pra pessoas que não gostam de fundos"),
("Isca","Só pra tubarões de empréstimo ingleses");

insert into FUND(FUND_CATEGORY_ID, BANK_ID, FUND_NAME, RISK_LEVEL, MINIMUM_INVESTMENT)
Values(1,1,"AQUARIO",5,5000),
(2,2,"GLOBAL FUND OF THE PEOPLE",1,1000),
(3,3,"NOT A SCAM",5,50),
(4,4,"VAQUEJADA",3,3100);

insert into PORTFOLIO(CLIENT_ID, ACCOUNT_ID)
values(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10);

insert into PORTFOLIO_FUND (FUND_ID,PORTFOLIO_ID)
VALUEs(1,1),
(2,2),
(3,3),
(4,4),
(1,5),
(1,6),
(2,7),
(2,8),
(3,9),
(4,10);

 SET SQL_SAFE_UPDATES = 0;
 
update ACCOUNT 
set IS_BLOCKED = TRUE 
where BALANCE < 5000;

alter table ACCOUNT
add UPDATED_AT timestamp default current_timestamp;

start transaction;
update ACCOUNT set BALANCE = 2440 where CLIENT_ID = 8; 
ROLLBACK;

delete from ACCOUNT where BALANCE< 100;

select * from FUND 
	WHERE MINIMUM_INVESTMENT >1000 and MINIMUM_INVESTMENT <6000 order by RISK_LEVEL DESC;
    
    
INSERT INTO CLIENT (CLIENT_NAME, EMAIL, BANK_ID) VALUES
('Gabriel Oliveira', 'gabriel.oli@gmail.com', 1),
('Mariana Santos', 'mari.santos@outlook.com', 1),
('Lucas Silva', 'lucas.silva@yahoo.com', 1),
('Ana Beatriz', 'ana.be@hotmail.com', 1),
('Arthur Melo', 'arthur.melo@gmail.com', 1),
('Beatriz Costa', 'biacosta@uol.com.br', 1),
('Caio Ferreira', 'caio.fer@gmail.com', 1),
('Daniela Souza', 'dani.souza@outlook.com', 1),
('Eduardo Lima', 'edu.lima@gmail.com', 1),
('Fernanda Rocha', 'fefe.rocha@yahoo.com', 1),
('Guilherme Alves', 'gui.alves@gmail.com', 2),
('Helena Castro', 'helena.c@hotmail.com', 1),
('Igor Machado', 'igor.mac@gmail.com', 1),
('Juliana Paiva', 'ju.paiva@uol.com.br', 2),
('Kevin Carter', 'k.carter@gmail.com', 1),
('Larissa Gomes', 'lari.gomes@outlook.com', 2),
('Murilo Henrique', 'murilo.h@gmail.com', 1),
('Natalia Dias', 'naty.dias@yahoo.com', 1),
('Otavio Mesquita', 'otavio.m@gmail.com', 1),
('Paola Bracho', 'paola.b@hotmail.com', 1),
('Ricardo Jacques', 'ric.jac@gmail.com', 1),
('Sabrina Sato', 'sabrina.s@uol.com.br', 1),
('Tiago Abravanel', 'tiago.a@gmail.com', 1),
('Ursula Corbero', 'ursula.c@outlook.com', 1),
('Victor Hugo', 'vitor.hugo@gmail.com', 1),
('Wagner Moura', 'wagner.m@yahoo.com', 1),
('Xuxa Meneghel', 'xuxa.m@gmail.com', 3),
('Yago Pikachu', 'yago.p@hotmail.com', 3),
('Zeca Pagodinho', 'zeca.p@gmail.com', 3),
('Aline Moraes', 'aline.m@uol.com.br', 1),
('Bruno Gagliasso', 'bruno.g@gmail.com', 1),
('Camila Queiroz', 'camila.q@outlook.com', 1),
('Diego Lugano', 'diego.l@gmail.com', 1),
('Eliana Amaral', 'eliana.a@yahoo.com', 1),
('Felipe Neto', 'felipe.n@gmail.com', 1),
('Gisele Bundchen', 'gisele.b@hotmail.com', 1),
('Hugo Gloss', 'hugo.g@gmail.com', 1),
('Isabela Freitas', 'isabela.f@uol.com.br', 1),
('Joao Kleber', 'joao.k@gmail.com', 1),
('Karol Conka', 'karol.c@outlook.com', 1),
('Luan Santana', 'luan.s@gmail.com', 2),
('Maísa Silva', 'maisa.s@yahoo.com', 1),
('Neymar Jr', 'ney.jr@gmail.com', 1),
('Oscar Niemeyer', 'oscar.n@hotmail.com', 1),
('Pabllo Vittar', 'pabllo.v@gmail.com', 1),
('Quico Gonzalez', 'quico.g@uol.com.br', 1),
('Rafael Portugal', 'rafael.p@gmail.com', 1),
('Simone Mendes', 'simone.m@outlook.com', 1),
('Tatá Werneck', 'tata.w@gmail.com', 1),
('Umberto Eco', 'umberto.e@yahoo.com', 1),
('Valesca Popozuda', 'valesca.p@gmail.com', 1),
('Will Smith', 'will.s@hotmail.com', 1),
('Xande de Pilares', 'xande.p@gmail.com', 1),
('Yuri Alberto', 'yuri.a@uol.com.br', 2),
('Zico Galinho', 'zico@gmail.com', 1),
('Alok Resende', 'alok@outlook.com', 2),
('Babu Santana', 'babu.s@gmail.com', 1),
('Cauã Reymond', 'caua.r@yahoo.com', 1),
('Deborah Secco', 'deborah.s@gmail.com', 1),
('Emicida Oliveira', 'emicida@hotmail.com', 1),
('Fabio Porchat', 'fabio.p@gmail.com', 1),
('Grazi Massafera', 'grazi.m@uol.com.br', 1),
('Hulk Paraíba', 'hulk.p@gmail.com', 4),
('Ivete Sangalo', 'ivete.s@outlook.com', 4),
('Jão Romania', 'jao.r@gmail.com', 1),
('Klara Castanho', 'klara.c@yahoo.com', 4),
('Ludmilla Silva', 'lud@gmail.com', 4),
('Marcos Mion', 'mion@hotmail.com', 1),
('Nanda Costa', 'nanda.c@gmail.com', 1),
('Olivia Rodrigo', 'olivia.r@uol.com.br', 1),
('Preta Gil', 'preta.g@gmail.com', 1),
('Quevin O Chris', 'kevin.c@outlook.com', 1),
('Rayssa Leal', 'rayssa.l@gmail.com', 1),
('Selena Gomez', 'selena.g@yahoo.com', 1),
('Titi Muller', 'titi.m@gmail.com', 1),
('Ulysses Guimaraes', 'ulysses@hotmail.com', 1),
('Vitor Kley', 'vitor.k@gmail.com', 1),
('Whindersson Nunes', 'whin.n@uol.com.br', 1),
('Xandy Harmonia', 'xandy.h@gmail.com', 1),
('Yasmin Brunet', 'yasmin.b@outlook.com', 1),
('Zezé Di Camargo', 'zeze.c@gmail.com', 1),
('Adriana Esteves', 'adriana.e@yahoo.com', 1),
('Belo Pires', 'belo@gmail.com', 4),
('Cleo Pires', 'cleo.p@hotmail.com', 1),
('Dado Dolabella', 'dado.d@gmail.com', 4),
('Evaristo Costa', 'eva.c@uol.com.br', 1),
('Felipe Massa', 'felipe.m@gmail.com', 1),
('Gloria Pires', 'gloria.p@outlook.com', 3),
('Humberto Carrão', 'humberto.c@gmail.com', 1),
('Isabelle Drummond', 'isabelle.d@yahoo.com', 1),
('Jorge Ben', 'jorge.b@gmail.com', 1),
('Katy Perry', 'katy.p@hotmail.com', 1),
('Lázaro Ramos', 'lazaro.r@gmail.com', 1),
('Marília Mendonça', 'marilia@uol.com.br', 2),
('Nando Reis', 'nando.r@gmail.com', 4),
('Otaviano Costa', 'otaviano@outlook.com', 4),
('Paolla Oliveira', 'paolla.o@gmail.com', 3),
('Quentin Tarantino', 'quentin.t@yahoo.com', 3),
('Rodrigo Hilbert', 'rodrigo.h@gmail.com', 3),
('Susana Vieira', 'susana.v@hotmail.com', 1);
INSERT INTO CLIENT (CLIENT_NAME, EMAIL, BANK_ID) VALUES
('Ayrton Senna', 'senna.sempre@gmail.com', 1),
('Pelé Nascimento', 'rei@futebol.com', 2),
('Garrincha Silva', 'anjo.pernas@uol.com.br', 3),
('Zico Antunes', 'galinho.zico@gmail.com', 4),
('Marta Vieira', 'marta.10@futebol.com', 1),
('Ronaldo Fenomeno', 'r9.nazario@gmail.com', 2),
('Ronaldinho Gaucho', 'bruxo@rolêaleatorio.com', 3),
('Kaká Leite', 'kaka.8@outlook.com', 4),
('Felipe Massa', 'massa.f@f1.com', 1),
('Rubens Barrichello', 'rubinho.b@gmail.com', 2),
('Tony Kanaan', 'tony.k@indy.com', 3),
('Helio Castroneves', 'helio.c@indy.com', 4),
('Anderson Silva', 'spider.silva@ufc.com', 1),
('José Aldo', 'jose.aldo@ufc.com', 2),
('Amanda Nunes', 'lioness.amanda@ufc.com', 3),
('Charles do Bronx', 'charles.bronx@ufc.com', 4),
('Gustavo Kuerten', 'guga.tenis@uol.com.br', 1),
('Fernando Meligeni', 'fino.tenis@gmail.com', 2),
('Maria Esther Bueno', 'maria.bueno@tennis.com', 3),
('Italo Ferreira', 'italo.surf@outlook.com', 4),
('Gabriel Medina', 'medina.g@surf.com', 1),
('Filipe Toledo', 'filipe.t@surf.com', 2),
('Pedro Barros', 'pedro.sk8@gmail.com', 3),
('Leticia Bufoni', 'bufoni.sk8@outlook.com', 4),
('Kelvin Hoefler', 'kelvin.h@sk8.com', 1),
('Rayssa Leal', 'fadinha@sk8.com', 2),
('Arthur Zanetti', 'zanetti.argolas@gmail.com', 3),
('Diego Hypolito', 'diego.h@ginastica.com', 4),
('Daniele Hypolito', 'dani.h@ginastica.com', 1),
('Jade Barbosa', 'jade.b@ginastica.com', 2),
('Arthur Nory', 'nory.a@ginastica.com', 3),
('Isaquias Queiroz', 'isaquias.canoa@uol.com.br', 4),
('Serginho Escadinha', 'serginho.vôlei@gmail.com', 1),
('Giba Godoy', 'giba.7@vôlei.com', 2),
('Bruninho Rezende', 'bruno.r@vôlei.com', 3),
('Fernanda Garay', 'fefe.garay@vôlei.com', 4),
('Sheilla Castro', 'sheilla.c@vôlei.com', 1),
('Thaisa Daher', 'thaisa.d@vôlei.com', 2),
('Fabiana Claudino', 'fabi.c@vôlei.com', 3),
('Wallace de Souza', 'wallace.s@vôlei.com', 4),
('Lucarelli Santos', 'luca.r@vôlei.com', 1),
('Maurício Borges', 'mau.b@vôlei.com', 2),
('Tandara Caixeta', 'tandara.c@vôlei.com', 3),
('Zé Roberto Guimarães', 'ze.coach@vôlei.com', 4),
('Bernardinho Rezende', 'bernardo.coach@gmail.com', 1),
('Oscar Schmidt', 'oscar.mao@basquete.com', 2),
('Hortência Marcari', 'rainha.h@basquete.com', 3),
('Magic Paula', 'magic.paula@basquete.com', 4),
('Janeth Arcain', 'janeth.a@basquete.com', 1),
('Leandro Barbosa', 'leandrinho@nba.com', 2),
('Nenê Hilário', 'nene@nba.com', 3),
('Anderson Varejão', 'varejao@nba.com', 4),
('Tiago Splitter', 'tiago.s@nba.com', 1),
('Bruno Caboclo', 'caboclo@nba.com', 2),
('Yago Mateus', 'yago.m@basquete.com', 3),
('Gui Santos', 'gui.s@nba.com', 4),
('Cesar Cielo', 'cielo.ouro@natacao.com', 1),
('Thiago Pereira', 'thiago.p@natacao.com', 2),
('Bruno Fratus', 'fratus.b@natacao.com', 3),
('Etiene Medeiros', 'etiene.m@natacao.com', 4),
('Ana Marcela Cunha', 'ana.m@maratona.com', 1),
('Poliana Okimoto', 'poliana.o@natacao.com', 2),
('Nicholas Santos', 'nicholas.s@natacao.com', 3),
('Manuella Lyrio', 'manu.l@natacao.com', 4),
('Vanderlei Cordeiro', 'vanderlei.c@maratona.com', 1),
('Joaquim Cruz', 'joaquim.c@atletismo.com', 2),
('Maurren Maggi', 'maurren.m@salto.com', 3),
('Thiago Braz', 'thiago.b@salto.com', 4),
('Fabiana Murer', 'fabiana.m@salto.com', 1),
('Alison dos Santos', 'piu.alison@atletismo.com', 2),
('Caio Bonfim', 'caio.b@marcha.com', 3),
('Darlan Romani', 'darlan.r@arremesso.com', 4),
('Rosângela Santos', 'rosangela.s@atletismo.com', 1),
('Paulo André', 'pa.atleta@gmail.com', 2),
('Robson Caetano', 'robson.c@atletismo.com', 3),
('Claudinei Quirino', 'claudinei.q@atletismo.com', 4),
('Vicente Lenilson', 'vicente.l@atletismo.com', 1),
('André Domingos', 'andre.d@atletismo.com', 2),
('Éder Jofre', 'eder.j@boxe.com', 3),
('Acelino Popó', 'popo.freitas@boxe.com', 4),
('Maguila Rodrigues', 'maguila@boxe.com', 1),
('Robson Conceição', 'robson.c@boxe.com', 2),
('Hebert Conceição', 'hebert.c@boxe.com', 3),
('Esquiva Falcão', 'esquiva.f@boxe.com', 4),
('Bia Ferreira', 'bia.f@boxe.com', 1),
('Servílio de Oliveira', 'servilio.o@boxe.com', 2),
('Everton Lopes', 'everton.l@boxe.com', 3),
('Torben Grael', 'torben.g@vela.com', 4),
('Robert Scheidt', 'robert.s@vela.com', 1),
('Martine Grael', 'martine.g@vela.com', 2),
('Kahena Kunze', 'kahena.k@vela.com', 3),
('Lars Grael', 'lars.g@vela.com', 4),
('Claudio Biekarck', 'claudio.b@vela.com', 1),
('Fernanda Oliveira', 'fernanda.o@vela.com', 2),
('Jorge Zarif', 'jorge.z@vela.com', 3),
('Isabel Swan', 'isabel.s@vela.com', 4),
('Doda Miranda', 'doda.m@hipismo.com', 1),
('Rodrigo Pessoa', 'rodrigo.p@hipismo.com', 2),
('Álvaro de Miranda', 'alvaro.m@hipismo.com', 3),
('Luciana Diniz', 'luciana.d@hipismo.com', 4);

select * FROM CLIENT 
where BANK_ID IN (1, 4) and CLIENT_ID < 100;



SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE TRANSACTION;
TRUNCATE TABLE ACCOUNT;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO ACCOUNT (ACCOUNT_ID, CLIENT_ID, BANK_ID, BALANCE) VALUES 
(1, 1, 1, 5000.00), (2, 2, 1, 3000.00), (3, 3, 2, 1000.00), 
(4, 4, 2, 500.00), (5, 5, 3, 200.00), (6, 6, 3, 8000.00), 
(7, 7, 4, 150.00), (8, 8, 4, 900.00), (9, 9, 1, 450.00), 
(10, 10, 2, 3000.00);

INSERT INTO TRANSACTION (ACCOUNT_ID, FUND_ID, AMOUNT, TRANSACTION_TYPE) VALUES
(1, 1, 500.00, 'BUY'), (2, 2, 1200.50, 'BUY'), (3, 3, 300.00, 'SELL'),
(4, 4, 1500.00, 'BUY'), (5, 5, 50.00, 'DEPOSIT'), (6, 6, 2000.00, 'BUY'),
(7, 7, 150.75, 'SELL'), (8, 8, 900.00, 'BUY'), (9, 9, 450.00, 'WITHDRAW'),
(10, 10, 3000.00, 'BUY');

select * from TRANSACTION where AMOUNT <1200 or TRANSACTION_TYPE = 'BUY' order by ACCOUNT_ID desc;
-- spoilers, pergunta 25, se vc cometer assasinato contra o pai,
-- os filhos também morrem;