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
    SONG_ID INT,
    PLAY_DATE timestamp,
    foreign key(USER_ID)references USERS(ID_USER),
    foreign key(SONG_ID)references SONGS(SONG_ID),
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

insert into GENRES(NAME)
VALUES
('ROCK'),
('INDIE'),
('MPB'),
('HIPHOP'),
('POP');

insert into ALBUMS(TITLE, RELEASE_YEAR, ARTIST_ID) 
VALUES
('LUX', 2025, 3),
(''),;