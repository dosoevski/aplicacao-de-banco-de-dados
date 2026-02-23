/* =====================================================
ANALISE AVANCADA LOL (MYSQL)
SOMENTE FAZER AS CONSULTAS
===================================================== */
 
 
/* =====================================================
NIVEL 1 – EASY MODE
===================================================== */
 
/* 1) Liste todos os campeoes ordenados pelo ano de lancamento (mais antigo primeiro) */
 
-- TABELA:
-- campeao(id_campeao, nome_campeao, funcao_principal, dificuldade, ano_lancamento)
 
-- DICA:
-- Use ORDER BY ano_lancamento ASC

use lol_analytics;
 
 select nome_campeao as Campeão, ano_lancamento as Ano_Lançamento  from campeao 
 order by ano_lancamento asc;
 
/* 2) Mostre os jogadores que possuem idade maior que 25 anos */
 
-- TABELA:
-- jogador(id_jogador, nickname, idade)
 
-- DICA:
-- Use WHERE idade > 25
 
 select nickname as Jogador, idade as Idade from jogador
 where idade > 25 order by idade asc;
 
/* =====================================================
NIVEL 2 – INTERMEDIARIO
===================================================== */
 
/* 3) Calcule a media de ouro ganho por jogador */
 
-- TABELAS:
-- estatistica_jogo(id_jogador, ouro_ganho)
-- jogador(id_jogador, nickname)
 
-- DICA:
-- AVG(ouro_ganho)
-- GROUP BY nickname
 
 select 
	j.nickname as Jogador, 
    round((avg(e.ouro_ganho)),0) as Media_Ouro 
from estatistica_jogo e
inner join jogador j on e.id_jogador = j.id_jogador
group by nickname order by Media_Ouro desc;

 
/* 4) Mostre a maior duracao de partida ja registrada */
 
-- TABELA:
-- partida(id_partida, duracao_min)
 
-- DICA:
-- Use MAX(duracao_min)
 
select id_partida,  Max(duracao_min) as Máxima_Duração from partida
group by id_partida
order by duracao_min desc
limit 1;
 
 
/* 5) Liste os times que nunca venceram nenhuma partida */
 
-- TABELAS:
-- time_lol(id_time, nome_time)
-- partida(id_partida, time_vencedor)
 
-- DICA:
-- Use NOT IN ou LEFT JOIN + IS NULL
select id_time as Id_Time, nome_time as Nome_Time from time_lol
where id_time not in (select time_vencedor from partida);
 
/* =====================================================
NIVEL 3 – HARD MODE
===================================================== */
 
/* 6) Mostre os jogadores que tiveram mais de 10 kills em alguma partida */
 
-- TABELAS:
-- estatistica_jogo(id_jogador, kills)
-- jogador(id_jogador, nickname)
 
-- DICA:
-- WHERE kills > 10
-- DISTINCT se necessario
 
 select distinct e.id_jogador as Id_Jogador,j.nickname as Nickname, e.kills as Kills from estatistica_jogo e
 join jogador j on e.id_jogador = j.id_jogador
 where kills >10;
 
/* 7) Calcule a media de torres destruidas por time */
 
-- TABELAS:
-- metrica_time(id_time, torres_destruidas)
-- time_lol(id_time, nome_time)
 
-- DICA:
-- AVG(torres_destruidas)
-- GROUP BY nome_time
 
 select m.id_time as ID_TIME, 
 t.nome_time as Nome_Time, 
 round(avg(torres_destruidas),0) as Torres_Destruídas 
 from metrica_time m
 inner join time_lol t on m.id_time = t.id_time
 group by t.id_time,t.nome_time 
 order by Torres_Destruídas desc;
 
/* 8) Liste os campeoes que nunca foram utilizados em nenhuma partida */
 
-- TABELAS:
-- campeao(id_campeao, nome_campeao)
-- estatistica_jogo(id_campeao)
 
-- DICA:
-- NOT IN
-- ou LEFT JOIN + IS NULL
select id_campeao, nome_campeao from campeao
where id_campeao not in(
    select id_campeao from estatistica_jogo 
    where id_campeao is not null);
/* =====================================================
NIVEL 4 – ELITE
===================================================== */
 
/* 9) Encontre os jogadores cujo dano medio seja maior que a media geral de dano */
 
-- TABELAS:
-- estatistica_jogo(id_jogador, dano_total)
-- jogador(id_jogador, nickname)
 
-- DICA:
-- Subquery com AVG(dano_total)
-- GROUP BY id_jogador

select j.id_jogador, j.nickname, round(avg(e.dano_total), 0) as media_jogador
from jogador j
join estatistica_jogo e on j.id_jogador = e.id_jogador
group by j.id_jogador, j.nickname
having avg(e.dano_total) > (select avg(dano_total) from estatistica_jogo);

/* 10) Calcule a media de dragoes por partida e mostre apenas as partidas acima dessa media */
 
-- TABELA:
-- metrica_time(id_partida, dragoes)
 
-- DICA:
-- GROUP BY id_partida
-- HAVING
-- Subquery com AVG(dragoes)
 
 select m.id_partida, sum(dragoes) as dragoes_por_partida from metrica_time m
 group by id_partida
 having sum(dragoes) >
 (select avg(total_por_partida) from
	(select sum(dragoes) as total_por_partida 
    from metrica_time  
    group by id_partida) as dragoes_por_partida
 );
 
 
/* =====================================================
NIVEL 5 – GIGACHAD MODE 🔥
===================================================== */
 
/* 11) Monte um ranking de impacto por jogador usando:
 
impacto =
(AVG(kills) * 0.5) +
(AVG(assists) * 0.3) -
(AVG(deaths) * 0.2)
 
Ordene do maior para o menor.
*/
 
-- TABELAS:
-- estatistica_jogo(id_jogador, kills, assists, deaths)
-- jogador(id_jogador, nickname)
 
-- DICA:
-- GROUP BY id_jogador
-- Calculo direto no SELECT
-- ORDER BY impacto DESC
 
select 
    j.nickname,
round(avg(e.kills), 2) as media_kill,
round(avg(e.assists), 2) as media_assist,
round(avg(e.deaths), 2) as media_death,
round((sum(e.kills) + sum(e.assists)) / nullif(sum(e.deaths), 0), 2) as kda
from jogador j
inner join estatistica_jogo e on j.id_jogador = e.id_jogador
group by j.id_jogador, j.nickname
order by (sum(e.kills) + sum(e.assists)) desc;

/* 12) Descubra qual time tem melhor eficiencia de objetivo:
 
eficiencia =
(AVG(dragoes) + AVG(barons)) / AVG(duracao_min)
 
Ordene do maior para o menor.

-- TABELAS:
-- metrica_time(id_partida, id_time, dragoes, barons)
-- partida(id_partida, duracao_min)
-- time_lol(id_time, nome_time)
 
-- DICA:
-- JOIN metrica_time com partida
-- GROUP BY nome_time
-- Calculo matematico direto no SELECT
-- ORDER BY eficiencia DESC

*/

select 
    t.id_time as ID_TIME,
    t.nome_time as NOME_TIME,
    round((avg(m.dragoes) + avg(m.barons)) / avg(p.duracao_min),2) as Eficiencia
from metrica_time m
join partida p on m.id_partida = p.id_partida
join time_lol t on m.id_time = t.id_time
group by t.id_time, t.nome_time
order by Eficiencia desc;