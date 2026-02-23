/* =====================================================
PROJETO – ANALISE PREDITIVA LEAGUE OF LEGENDS (MYSQL)
SOMENTE FAÇA AS CONSULTAS
===================================================== */
 
 
/* =====================================================
NIVEL 1 – FACIL
===================================================== */
 
/* 1) Liste o nickname do jogador e o nome do seu time */
 
-- TABELAS:
-- jogador(id_jogador, nickname, rank_atual, id_time)
-- time_lol(id_time, nome_time, regiao)
 
-- DICA:
-- Use INNER JOIN ligando jogador.id_time com time_lol.id_time
 
 select DISTINCT nickname, nome_time
 from jogador
    inner join time_lol on jogador.id_time = time_lol.id_time


/* 2) Mostre o nickname e a media de kills de cada jogador */
 
-- TABELAS:
-- estatistica_jogo(id_est, id_partida, id_jogador, kills, deaths, assists, dano_total)
-- jogador(id_jogador, nickname)
 
-- DICA:
-- Use AVG(kills) + GROUP BY nickname
 
SELECT nickname, AVG(kills) as media_kills
FROM jogador
    INNER JOIN estatistica_jogo ON jogador.id_jogador = estatistica_jogo.id_jogador
GROUP BY nickname

 
/* =====================================================
NIVEL 2 – INTERMEDIARIO
===================================================== */
 
/* 3) Mostre os 3 jogadores com maior soma de dano total */
 
-- TABELAS:
-- estatistica_jogo(id_jogador, dano_total)
-- jogador(id_jogador, nickname)
 
-- DICA:
-- Use SUM(dano_total)
-- GROUP BY nickname
-- ORDER BY DESC
-- LIMIT 3
 
 select nickname, SUM(dano_total) as soma_dano
 from jogador
    INNER join estatistica_jogo ON jogador.id_jogador = estatistica_jogo.id_jogador
GROUP BY nickname
ORDER BY soma_dano DESC
LIMIT 3

/* 4) Liste as partidas cuja duracao foi maior que a media geral */
 
-- TABELA:
-- partida(id_partida, data_partida, duracao_min, time_vencedor)
 
-- DICA:
-- Use SUBQUERY no WHERE
-- Compare duracao_min com AVG(duracao_min)
 
 select id_partida, duracao_min
 from partida
WHERE duracao_min > (SELECT AVG(duracao_min) FROM partida)

 
/* 5) Mostre os times que tiveram gold acima da media geral */
 
-- TABELAS:
-- metrica_time(id_partida, id_time, gold_total)
-- time_lol(id_time, nome_time)
 
-- DICA:
-- Subquery com AVG(gold_total)
-- JOIN para trazer nome do time
 
 select nome_time, gold_total
 from metrica_time
    INNER JOIN time_lol ON metrica_time.id_time = time_lol.id_time
WHERE gold_total > (select AVG(gold_total) FROM metrica_time)


/* =====================================================
NIVEL 3 – AVANCADO
===================================================== */
 
/* 6) Liste jogadores cujo KDA medio seja maior que o KDA medio global */
 
-- TABELA:
-- estatistica_jogo(id_jogador, kills, deaths, assists)
-- jogador(id_jogador, nickname)
 
-- FORMULA:
-- (kills + assists) / deaths
 
-- DICA:
-- Use NULLIF(deaths,0)
-- GROUP BY id_jogador
-- Subquery para calcular KDA medio global
 
SELECT nickname, 
       (SUM(kills) + SUM(assists)) / NULLIF(SUM(deaths), 0) AS kda_medio
FROM jogador
    INNER JOIN estatistica_jogo ON jogador.id_jogador = estatistica_jogo.id_jogador
GROUP BY nickname
HAVING kda_medio > (
    SELECT (SUM(kills) + SUM(assists)) / NULLIF(SUM(deaths), 0) AS kda_medio_global
    FROM estatistica_jogo
)
 
/* 7) Descubra qual campeao foi mais utilizado por jogadores Challenger */
 
-- TABELAS:
-- jogador(id_jogador, rank_atual)
-- estatistica_jogo(id_jogador, id_campeao)
-- campeao(id_campeao, nome_campeao)
 
-- DICA:
-- WHERE rank_atual = 'Challenger'
-- COUNT(*)
-- GROUP BY id_campeao
-- ORDER BY DESC
-- LIMIT 1
 
SELECT nome_campeao, COUNT(*) AS vezes_utilizado
FROM jogador
    INNER JOIN estatistica_jogo ON jogador.id_jogador = estatistica_jogo.id_jogador
    INNER JOIN campeao ON estatistica_jogo.id_campeao = campeao.id_campeao
WHERE rank_atual = 'Challenger'
GROUP BY nome_campeao
ORDER BY vezes_utilizado DESC
LIMIT 1
 
/* 8) Calcule a taxa de vitoria (%) de cada time */
 
-- TABELAS:
-- partida(id_partida, time_vencedor)
-- time_lol(id_time, nome_time)
 
-- DICA:
-- Conte quantas vezes o time aparece como vencedor
-- Divida pelo total de partidas
-- Multiplique por 100
-- GROUP BY nome_time
 
SELECT nome_time,
       (COUNT(CASE WHEN time_vencedor = nome_time THEN 1 END) / COUNT(*)) * 100 AS taxa_vitoria
FROM time_lol
    INNER JOIN partida ON time_lol.id_time = partida.time_vencedor
GROUP BY nome_time



/* =====================================================
NIVEL 4 – GIGACHAD
===================================================== */
 
/* 9) Liste partidas onde o time teve:
   - Mais torres que a media
   - Mais gold que a media
   - E venceu a partida */
 
-- TABELAS:
-- metrica_time(id_partida, id_time, torres_destruidas, gold_total)
-- partida(id_partida, time_vencedor)
-- time_lol(id_time, nome_time)
 
-- DICA:
-- Duas subqueries separadas para medias
-- JOIN com partida
-- AND combinando condicoes
 
SELECT nome_time, torres_destruidas, gold_total
FROM metrica_time
    INNER JOIN time_lol ON metrica_time.id_time = time_lol.id_time
    INNER JOIN partida ON metrica_time.id_partida = partida.id_partida
WHERE torres_destruidas > (SELECT AVG(torres_destruidas) FROM metrica_time)
  AND gold_total > (SELECT AVG(gold_total) FROM metrica_time)
  AND nome_time = partida.time_vencedor


 
/* 10) FINAL BOSS – Ranking preditivo de desempenho */
 
-- TABELAS:
-- jogador
-- estatistica_jogo
-- metrica_time
-- partida
-- time_lol
 
-- OBJETIVO:
-- Mostrar:
-- nome_time
-- media_kills
-- media_gold
-- total_vitorias
-- score_final
 
-- FORMULA SCORE:
-- (AVG(kills) * 0.4)
-- + (AVG(gold_total)/1000 * 0.3)
-- + (vitorias * 0.3)
 
-- ORDENAR DO MAIOR PARA O MENOR
 
-- DICA:
-- Vai precisar de varios JOIN
-- GROUP BY nome_time
-- Calculos dentro do SELECT
-- ORDER BY score_final DESC

SELECT nome_time,
       AVG(kills) AS media_kills,
       AVG(gold_total) AS media_gold,
       COUNT(CASE WHEN time_vencedor = nome_time THEN 1 END) AS total_vitorias,
       (AVG(kills) * 0.4) + (AVG(gold_total)/1000 * 0.3) + (COUNT(CASE WHEN time_vencedor = nome_time THEN 1 END) * 0.3) AS score_final
FROM time_lol
    INNER JOIN metrica_time ON time_lol.id_time = metrica_time.id_time
    INNER JOIN partida ON metrica_time.id_partida = partida.id_partida
GROUP BY nome_time
ORDER BY score_final DESC