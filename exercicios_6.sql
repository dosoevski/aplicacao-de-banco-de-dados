use GAME_PLATFORM;

select * from GAMES;

-- 1
select avg(PRICE) from GAMES;
select * from GAMES WHERE PRICE >(select avg(PRICE) from GAMES);

-- 2
select * from USERS;
select * from PURCHASES;

select * from USERS where ID in (SELECT USER_ID from PURCHASES);
-- selecione o id onde equivale ao user_id em purchases

-- 3
select * from REVIEWS;
select * from GAMES where ID in (SELECT USER_ID from REVIEWS);

-- 4
select * from GAMES;
select * from PURCHASES;

select distinct G.TITLE as GAMES, G.PRICE from GAMES G
inner join PURCHASES P on  G.ID = P.GAME_ID 
where G.PRICE > (select avg(PRICE)from GAMES);

-- select game title e game price da tabela games g, inner join entre tabela purchases p no game_id = game_id
-- da tabela games, onde o preço é igual ao preco avf dentro da tabela games;

-- 5
select * from USERS where ID not in (SELECT USER_ID from PURCHASES);

-- 6
select G.TITLE as GAMES, R.SCORE as NOTA from GAMES G
join REVIEWS R on G.ID = R.GAME_ID
group by G.TITLE, R.SCORE having AVG(SCORE)> 4;
-- seleciona o titulo tabela games e score da tabela review, join as tabelas pelo id, 
-- agrupa pelo titulo e score e faz um having um score avg >4

-- 7
-- primeiro ver a média da quantidade de avaliacoes, depois contar os que tem maior que a média
select * from REVIEWS;
select * from GAMES;

select G.TITLE, count(R.ID) from GAMES G
join REVIEWS R on G.ID = R.GAME_ID
group by G.TITLE having count(R.ID) > 
(select avg(TOTAL) from (select count(*) as TOTAL from REVIEWS group by GAME_ID) as subtotal
);
-- seleciona o title, usa count pra verificar o id das reviews e contar quantas reviews tem, dentro da tabela games, faz join
-- com a tabela reviews pro game id = reviews game id, agroupa os titles de games e conta os que tem reviews
-- fazendo com que comece a contar quando for > , criando uma subquery selecionar
-- avg total, definindo + um subquery como total agrupando reviews e count id,  

-- 8
-- LISTE OS USUÁRIOS QUE AVALIARAM JOGOS COM NOTA ABAIXO DA MÉDIA GERAL
-- DICA: SUBQUERY NA CONDIÇÃO
select U.NAME as USUARIOS from USERS U
join REVIEWS R on U.ID = R.USER_ID
where SCORE <(select AVG(SCORE) from REVIEWS);
-- select name user, join com reviews, mesmo u com r user id

-- 9
select TITLE, PRICE from GAMES
where PRICE > ALL (select PRICE from GAMES where GENRE = 'RPG'); 

-- seleciona titulo e preco, onde esta preco > que todos, subquery
-- seleciona o maior entre todos os games onde genero rpg

-- 10
select U.NAME as USUARIOS from USERS U
join PURCHASES P on U.ID =  P.USER_ID
group by USER_ID all > (select * from PURCHASES);