use DB_VITORIA_B;

-- 1
create table if not exists USERS(
    ID_USER INT auto_increment primary key,
    NAME VARCHAR(45) not null,
    EMAIL VARCHAR(45) not null,
    BIRTH_DATE date,
    IS_PREMIUM boolean,
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP
);

-- 2
create table if not exists ARTISTS(
    ARTIST_ID INT auto_increment primary key,
    NAME VARCHAR(45) not null,
    COUNTRY VARCHAR(20),
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP
);

-- 3
create table if not exists GENRES(
    GENRE_ID INT auto_increment primary key,
    NAME VARCHAR(15) not null,
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP
);

-- 4
create table if not exists ALBUMS(
    ALBUM_ID INT auto_increment primary key,
    TITLE VARCHAR(35) not null,
    RELEASE_YEAR INT,
    ARTIST_ID INT,
    foreign key(ARTIST_ID) references ARTISTS(ARTIST_ID) ON DELETE CASCADE, -- Corrigido de ALBUMS para ARTISTS
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP
);

-- 5
create table if not exists SONGS(
    SONGS_ID INT auto_increment primary key,
    TITLE varchar(30) not null,
    DURATION_SECONDS TIME,
    ALBUM_ID INT,
    GENRE_ID INT,
    ARTIST_ID INT,
    foreign key(ALBUM_ID) references ALBUMS(ALBUM_ID),
    foreign key(GENRE_ID) references GENRES(GENRE_ID), 
    foreign key (ARTIST_ID) references ARTISTS(ARTIST_ID),
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP
);
-- 6
create table if not exists PLAYLISTS(
	PLAYLIST_ID INT auto_increment primary key,
    NAME VARCHAR(15),
    USER_ID INT,
    IS_PUBLIC boolean,
    foreign key(USER_ID) references USERS(ID_USER),
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP);
  
-- 7
create table if not exists PLAYLIST_SONGS(
	PLAYLIST_SONG_ID INT auto_increment primary key,
    PLAYLIST_ID INT,
    SONG_ID INT,
	CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP);
    
-- 8
create table if not exists PLAYS(
	PLAY_ID INT auto_increment primary key,
    USER_ID INT,
    SONGS_ID INT,
    PLAY_DATE timestamp,
    foreign key(USER_ID)references USERS(ID_USER),
    foreign key(SONGS_ID)references SONGS(SONGS_ID),
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP);
    ;
    
-- 9
create table if not exists SONG_REVIEWS(
	SONG_REVIEWS_ID INT auto_increment primary key,
    USER_ID INT,
    SONG_ID INT,
    RATING INT,
    REVIEW_DATE timestamp,
    foreign key(USER_ID)references USERS(ID_USER),
    foreign key(SONG_ID)references SONGS(SONGS_ID),
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP
    );

-- 10
create table if not exists ARTIST_FOLLOWERS(
	ARTIST_FOLLOWER_ID INT auto_increment primary key,
    USER_ID INT,
    ARTIST_ID INT,
    SONG_ID INT,
    FOLLOW_DATE timestamp,
    foreign key(USER_ID)references USERS(ID_USER),
    foreign key(SONG_ID)references SONGS(SONGS_ID),
	foreign key (ARTIST_ID) references ARTISTS(ARTIST_ID),
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT timestamp default current_timestamp ON UPDATE CURRENT_TIMESTAMP
	);

-- 11

insert into USERS(NAME,EMAIL, BIRTH_DATE, IS_PREMIUM)
VALUES
('Ariana Pequena', 'ariana@gmail.com','2001-12-02',true),
('Big Sims', 'bigsims@outlook.com','1999-01-14',true),
('Tara Reynolds', 'tara@outlook.com','2006-10-30',false),
('Anna Katherina', 'anna@hotmail.com','1988-09-03',false),
('Steve', 'steve@gmail.com','2001-12-02',true);
;

-- 12
insert into ARTISTS(NAME, COUNTRY)
VALUES
('BLACK MIDI','ENGLAND'),
('DOECHIII','USA'),
('ROSALIA','SPAIN'),
('YAELOKRE','ICELAND'),
('BACO EXU DO BLUES','BRAZIL'),
('MASSIVE ATTACK','ENGLAND'),
('HOZIER','IRELAND'),
('MICHAEL JACKSON','USA'),
('ANA FRANGO FRITO','BRAZIL')
;

-- 13
select * from GENRES;
insert into GENRES(NAME)
VALUES
('ROCK'),
('INDIE'),
('MPB'),
('HIPHOP'),
('POP');

-- 14
insert into ALBUMS(TITLE, RELEASE_YEAR, ARTIST_ID) 
VALUES
('Hellfire',2022,1),
('Alligator Bites Never Heal',2024,2),
('LUX', 2025, 3),
('HASOS',2025,5),
('Wasteland, Baby!',2019,7),
('Thriller',1982,8)
;

-- 15
INSERT INTO SONGS (TITLE, DURATION_SECONDS, ALBUM_ID, GENRE_ID, ARTIST_ID)
VALUES 
-- Black Midi (Artist 1 - Rock/Indie)
('Sugar/Tzu', '00:03:50', 1, 1, 1),
('Eat Men Eat', '00:03:08', 1, 1, 1),
('Welcome to Hell', '00:03:19', 1, 1, 1),
('Slow', '00:05:37', NULL, 1, 1),

-- Doechii (Artist 2 - HipHop)
('Catfish', '00:02:45', 2, 4, 2),
('Nissan Altima', '00:03:01', 2, 4, 2),
('Persuasive', '00:02:50', 2, 4, 2),
('Yucky Blucky Fruitcake', '00:02:52', NULL, 4, 2),

-- Rosalia (Artist 3 - Pop)
('CHICKEN TERIYAKI', '00:02:02', 3, 5, 3),
('BIZCOCHITO', '00:01:49', 3, 5, 3),
('HENTAI', '00:02:42', 3, 5, 3),
('DESPECHÁ', '00:02:37', NULL, 5, 3),

-- Yaelokre (Artist 4 - Indie)
('Harpy Hare', '00:03:40', NULL, 2, 4),
('And the Hound', '00:03:15', NULL, 2, 4),

-- Baco Exu do Blues (Artist 5 - HipHop/MPB)
('Hotel Caro', '00:03:12', 4, 4, 5),
('20 de Maio', '00:03:30', 4, 4, 5),
('Samba in Paris', '00:02:57', 4, 4, 5),
('Te Amo Disgraça', '00:02:26', NULL, 4, 5),

-- Massive Attack (Artist 6 - Indie/Rock)
('Teardrop', '00:05:30', NULL, 2, 6),
('Angel', '00:06:18', NULL, 2, 6),
('Paradise Circus', '00:04:57', NULL, 2, 6),

-- Hozier (Artist 7 - Indie/Rock)
('Movement', '00:03:57', 5, 2, 7),
('Almost (Sweet Music)', '00:03:37', 5, 2, 7),
('Nina Cried Power', '00:03:45', 5, 2, 7),
('Take Me To Church', '00:04:02', NULL, 2, 7),

-- Michael Jackson (Artist 8 - Pop)
('Billie Jean', '00:04:54', 6, 5, 8),
('Beat It', '00:04:18', 6, 5, 8),
('Thriller', '00:05:57', 6, 5, 8),
('Wanna Be Startin Somethin', '00:06:03', 6, 5, 8),

-- Ana Frango Elétrico (Artist 9 - MPB/Indie)
('Insista em Mim', '00:03:42', NULL, 3, 9),
('Mulher Homem Bicho', '00:03:15', NULL, 3, 9);

select * from SONGS;

-- 16
select * from PLAYLISTS;

insert into PLAYLISTS(NAME, USER_ID, IS_PUBLIC)
VALUES
('RADIO','1', TRUE),
('CHURRASCO LIBERDADE','2', FALSE),
('ROOOCKKKEEEE🎸',3, FALSE),
('DISCORD SERVER',4, FALSE);

-- 17
select * from PLAYLIST_SONGS;
INSERT INTO PLAYLIST_SONGS (PLAYLIST_ID, SONG_ID)
VALUES 
-- Playlist 1: 'RADIO'
(1, 1),   -- Sugar/Tzu
(1, 5),   -- Catfish
(1, 9),   -- LUX
(1, 26),  -- Billie Jean
(1, 28),  -- Thriller

-- Playlist 2: 
(2, 26),  -- Billie Jean
(2, 15),  -- Hotel Caro
(2, 17),  -- Te Amo Disgraça
(2, 30),  -- Mulher Homem Bicho
(2, 12),  -- DESPECHÁ

-- Playlist 3: 
(3, 1),   -- Sugar/Tzu 
(3, 3),   -- Welcome to Hell
(3, 22),  -- Movement
(3, 25),  -- Take Me To Church
(3, 27),  -- Beat It

-- Playlist 4: 
(4, 13),  -- Harpy Hare
(4, 19),  -- Teardrop
(4, 21),  -- Paradise Circus
(4, 5),   -- Catfish
(4, 8);  -- What It Is

-- 18
INSERT INTO PLAYS (USER_ID, SONGS_ID, PLAY_DATE)
VALUES 
-- Histórico do Usuário 1 (Escutou muito Black Midi e MJ)
(1, 1, '2026-01-25 08:30:00'),
(1, 26, '2026-01-25 09:15:20'),
(1, 3, '2026-01-26 14:00:10'),
(1, 28, '2026-01-27 19:45:00'),
(1, 1, '2026-01-28 10:20:00'), -- Repetiu a música 1 em dia diferente

-- Histórico do Usuário 2 (Fã de HipHop e MPB)
(2, 5, '2026-01-20 10:00:00'),
(2, 15, '2026-01-21 11:30:45'),
(2, 30, '2026-01-22 15:00:00'),
(2, 17, '2026-01-23 22:10:00'),
(2, 5, '2026-01-24 09:00:00'),

-- Histórico do Usuário 3 (Vibe Indie e Rock)
(3, 22, '2026-01-15 07:00:00'),
(3, 25, '2026-01-16 18:30:00'),
(3, 1, '2026-01-17 21:00:00'),
(3, 19, '2026-01-18 12:45:30'),
(3, 22, '2026-01-19 23:55:00'),

-- Histórico do Usuário 4 (Variedade total)
(4, 13, '2026-01-28 08:00:00'),
(4, 21, '2026-01-28 08:05:00'),
(4, 26, '2026-01-29 13:20:00'),
(4, 9, '2026-01-30 10:00:00'),
(4, 27, '2026-01-30 16:40:00');

-- 19
INSERT INTO SONG_REVIEWS (USER_ID, SONG_ID, RATING, REVIEW_DATE)
VALUES 
-- Michael Jackson (ID 26, 27, 28) - Geralmente notas altas
(1, 26, 5, '2026-01-30 10:00:00'),
(2, 26, 5, '2026-01-30 10:05:00'),
(3, 27, 4, '2026-01-30 10:10:00'),

-- Black Midi (ID 1, 2, 3) - Notas mistas (Experimental)
(4, 1, 5, '2026-01-30 11:00:00'),
(1, 1, 2, '2026-01-30 11:15:00'), -- Alguém que não curtiu o caos
(2, 3, 3, '2026-01-30 11:30:00'),

-- Rosalia (ID 12) e Doechii (ID 5)
(3, 12, 5, '2026-01-30 12:00:00'),
(4, 5, 4, '2026-01-30 12:15:00'),
(1, 8, 1, '2026-01-30 12:30:00'), -- Uma nota bem baixa para variar!

-- Hozier (ID 22, 25)
(2, 22, 5, '2026-01-30 13:00:00'),
(3, 25, 4, '2026-01-30 13:10:00'),

-- Mais variedades (Notas 2 e 3)
(4, 30, 3, '2026-01-30 14:00:00'),
(1, 15, 2, '2026-01-30 14:15:00'),
(2, 19, 3, '2026-01-30 14:30:00'),
(3, 13, 5, '2026-01-30 14:45:00');

-- 20
INSERT INTO ARTIST_FOLLOWERS (USER_ID, ARTIST_ID, FOLLOW_DATE)
VALUES 
-- Michael Jackson (ID 8) com vários seguidores
(1, 8, '2026-01-30 09:00:00'),
(2, 8, '2026-01-30 09:30:00'),
(3, 8, '2026-01-30 10:00:00'),

-- Rosalia (ID 3) com vários seguidores
(1, 3, '2026-01-30 11:00:00'),
(4, 3, '2026-01-30 11:15:00'),

-- Outros artistas
(2, 5, '2026-01-30 12:00:00'), -- Baco Exu do Blues
(3, 7, '2026-01-30 13:00:00'), -- Hozier
(4, 2, '2026-01-30 14:00:00'); -- Doechii

-- 21
select * from SONGS where DURATION_SECONDS >= '00:03:02';

-- 22
SELECT S.* FROM SONGS S join GENRES G ON S.GENRE_ID = G.GENRE_ID where G.NAME in ('ROCK', 'MPB');
-- Tabela Songs =S, Genres =6, faz com que o genre id do song e do genre sejam iguais, 
-- pesquisa qual equivale a rock e mpb usando in;

-- 23
select * from PLAYLISTS where IS_PUBLIC = true;

-- 24
select * from SONGS;
select * from SONGS where TITLE = 'Beat It';
select * from SONGS  WHERE TITLE like '%Chicken%' ;

-- 25
SELECT TITLE, DURATION_SECONDS FROM SONGS 
ORDER BY DURATION_SECONDS DESC;

-- 26
-- 26
SELECT S.TITLE AS SONG, A.NAME AS ARTIST
FROM SONGS S
JOIN ARTISTS A ON S.ARTIST_ID = A.ARTIST_ID;
-- song title = song, artist name = artist. from SONGS S,
-- faz join, artist em cima do song artist id = a+ artist_id

-- 27
select P.NAME as PLAYLIST, U.NAME AS USER from USERS U
join PLAYLISTS P ON P.USER_ID = U.ID_USER;

-- 28
select S.TITLE As SONG, G.NAME As GENRE FROM SONGS S
Join GENRES G on S.GENRE_ID = G.GENRE_ID;

-- 29
select U.NAME as USUARIO, A.NAME as ARTISTA_SEGUIDO
From USERS U
join ARTIST_FOLLOWERS AF on U.ID_USER = AF.USER_ID 
join ARTISTS A On AF.ARTIST_ID = A.ARTIST_ID   
where U.IS_PREMIUM = true;       

-- seleciona o nome do usuario como principal, seleciona nome no artista seguido da users U;
-- primeiro join pra descobrir quem segue quem, artist follower+ user_id que segue
-- segundo join seleciona os artistas no artista seguido id e soma
-- com todas as informacoes, um where simples onde identifica que usuario é premium

-- 30
select S.TITLE, S.DURATION_SECONDS, SR.RATING
from SONGS S join SONG_REVIEWS SR on S.SONGS_ID = SR.SONG_ID
where DURATION_SECONDS > '00:04:00' or SR.RATING <3;

-- 31
select U.NAME AS USER, S.TITLE as TITLE, P.PLAY_DATE as DATA_HORA
from PLAYS P join USERS U ON P.USER_ID = U.ID_USER
join SONGS S ON P.SONGS_ID = S.SONGS_ID;
/*----------------------------------------------------------------------*/
-- 1
CREATE TABLE TEACHERS (
   ID INT PRIMARY KEY AUTO_INCREMENT,
   NAME VARCHAR(100) NOT NULL,
   SUBJECT VARCHAR(50) NOT NULL
);
CREATE TABLE CLASSES (
   ID INT PRIMARY KEY AUTO_INCREMENT,
   CLASS_NAME VARCHAR(50) NOT NULL,
   TEACHER_ID INT,
   FOREIGN KEY (TEACHER_ID) REFERENCES TEACHERS(ID)
);
CREATE TABLE STUDENTS (
   ID INT PRIMARY KEY AUTO_INCREMENT,
   NAME VARCHAR(100) NOT NULL,
   AGE INT NOT NULL,
   CLASS_ID INT,
   FOREIGN KEY (CLASS_ID) REFERENCES CLASSES(ID)
);
CREATE TABLE GRADES (
   ID INT PRIMARY KEY AUTO_INCREMENT,
   STUDENT_ID INT,
   GRADE DECIMAL(4,2),
   FOREIGN KEY (STUDENT_ID) REFERENCES STUDENTS(ID)
);

-- 2
INSERT INTO TEACHERS (NAME, SUBJECT) VALUES
('Carlos Silva', 'Math'),
('Ana Souza', 'Portuguese'),
('Marcos Lima', 'History'),
('Juliana Rocha', 'Geography');
INSERT INTO CLASSES (CLASS_NAME, TEACHER_ID) VALUES
('1A', 1),
('1B', 2),
('2A', 1),
('2B', 3),
('3A', 4);
INSERT INTO STUDENTS (NAME, AGE, CLASS_ID) VALUES
('John', 15, 1),
('Mary', 14, 1),
('Peter', 15, 1),
('Anna', 14, 2),
('Lucas', 16, 2),
('Fernanda', 15, 2),
('Rafael', 16, 3),
('Beatriz', 15, 3),
('Camila', 16, 4),
('Bruno', 17, 4),
('Daniel', 17, 5),
('Larissa', 16, 5);
INSERT INTO GRADES (STUDENT_ID, GRADE) VALUES
(1, 8.0), (1, 7.5),
(2, 9.0), (2, 8.5),
(3, 6.0),
(4, 7.0), (4, 6.5),
(5, 8.0),
(6, 9.5),
(7, 5.5),
(8, 7.5),
(9, 6.0),
(10, 8.0),
(11, 9.0),
(12, 7.0);

-- 3
/*
EXEMPLO DIDÁTICO:
SELECT NAME
FROM EMPLOYEES
WHERE SALARY > (
   SELECT AVG(SALARY)
   FROM EMPLOYEES
);
EXPLICAÇÃO:
- A subquery (query interna) é executada primeiro.
- O resultado dela é usado como filtro na query externa.
- A subquery pode retornar um único valor.
*/

-- 1
select S.NAME as ALUNO, C.CLASS_NAME as TURMA, T.NAME AS PROF,
T.SUBJECT AS MATERIA
from STUDENTS S 
join CLASSES C on S.CLASS_ID = C.ID
join TEACHERS T on C.TEACHER_ID =T.ID;
-- exibir aluno, classe, materia
-- principal dos students

-- 2 
select S.NAME AS ALUNO, G.GRADE AS NOTAS, T.SUBJECT AS MATERIA 
FROM GRADES G 
join STUDENTS S ON G.STUDENT_ID = S.ID 
join CLASSES C ON S.CLASS_ID = C.ID 
join TEACHERS T ON C.TEACHER_ID = T.ID;

-- 3
select S.NAME AS ALUNO, G.GRADE AS NOTAS 
FROM STUDENTS S
INNER JOIN GRADES G ON S.ID = G.STUDENT_ID;

-- 4
select * from GRADES;

-- select S.NAME as ALUNO, S.AGE as IDADE, G.GRADES from STUDENT S,
-- where AVG GRADE G > (AVG GRADES);

select S.NAME AS ALUNO, S.AGE AS IDADE
from STUDENTS S
join GRADES G on S.ID = G.STUDENT_ID
group by S.NAME, S.AGE
having AVG(G.GRADE) > (SELECT AVG(GRADE) FROM GRADES);

-- 5
select S.NAME as ALUNO, G.GRADE as NOTAS, T.NAME as TEACHERS
from STUDENTS S
join GRADES G on S.ID = G.STUDENT_ID
join CLASSES C on S.CLASS_ID = C.ID
join TEACHERS T on C.TEACHER_ID = T.ID
where T.NAME = 'Carlos Silva';

