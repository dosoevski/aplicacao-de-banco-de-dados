
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

insert into FUND_CATEGORY()
VALUES();