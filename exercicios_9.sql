/* =====================================================
REVISAO COMPLETA – MYSQL – ANALISE LOL
===================================================== */
 
 
/* =====================================================
PARTE 1 – O QUE E CADA COMANDO
===================================================== */
 
/*
WHERE
Filtra registros com base em uma condicao.
Ex: WHERE idade > 20
------------------------------------------------------
 
AND / OR
AND exige que todas as condicoes sejam verdadeiras.
OR exige que pelo menos uma seja verdadeira.
------------------------------------------------------
 
IN
Filtra valores dentro de uma lista.
Ex: WHERE regiao IN ('KR','BR')
------------------------------------------------------
 
BETWEEN
Filtra valores dentro de um intervalo.
Ex: WHERE idade BETWEEN 20 AND 30
------------------------------------------------------
 
LIKE
Busca padroes de texto.
% = qualquer coisa
_ = um caractere
Ex: WHERE nome LIKE '%a%'
------------------------------------------------------
 
ORDER BY
Ordena resultados.
ASC = crescente
DESC = decrescente
------------------------------------------------------
 
GROUP BY
Agrupa dados para usar funcoes de agregacao.
------------------------------------------------------
 
HAVING
Filtra resultados depois do GROUP BY.
------------------------------------------------------
 
DISTINCT
Remove valores duplicados.
------------------------------------------------------
 
LIMIT
Limita quantidade de resultados.
------------------------------------------------------
 
OFFSET
Pula registros antes de mostrar resultados.
------------------------------------------------------
 
Alias (AS)
Renomeia colunas temporariamente.
Ex: AVG(kills) AS media_kills
------------------------------------------------------
 
FUNCOES NUMERICAS
ROUND()  -> arredonda
CEIL()   -> arredonda para cima
FLOOR()  -> arredonda para baixo
ABS()    -> valor absoluto
------------------------------------------------------
 
FUNCOES TEXTO
CONCAT()     -> junta textos
LOWER()      -> minusculo
UPPER()      -> maiusculo
LENGTH()     -> tamanho do texto
SUBSTRING()  -> extrai parte do texto
TRIM()       -> remove espacos
------------------------------------------------------
 
FUNCOES DATA
NOW()       -> data e hora atual
CURDATE()   -> data atual
DATEDIFF()  -> diferenca entre datas
DATE_ADD()  -> adiciona dias
DATE_SUB()  -> subtrai dias
------------------------------------------------------
 
FUNCOES AGREGACAO
COUNT() -> conta registros
SUM()   -> soma
AVG()   -> media
MAX()   -> maior valor
MIN()   -> menor valor
------------------------------------------------------
 
JOIN
Une tabelas relacionadas.
------------------------------------------------------
 
SUBQUERY
Uma consulta dentro de outra consulta.
*/
 
 
/* =====================================================
PARTE 2 – DEVERES (FAZER SOMENTE AS CONSULTAS)
===================================================== */
 
 
/* 1) Liste jogadores Challenger com idade entre 20 e 27.
   Ordene do mais velho para o mais novo.
*/
 
-- Use WHERE + AND + BETWEEN + ORDER BY
 
use lol_analytics;
select id_jogador, nickname, idade from jogador
where idade between 20 and 27
order by idade desc;
 
/* 2) Mostre campeoes cujo nome contenha 'a'
   e que foram lancados entre 2010 e 2020.
   Exiba o nome em MAIUSCULO.
*/
 
-- Use LIKE + BETWEEN + UPPER()
 select nome_campeao, ano_lancamento from campeao
 where nome_campeao like 'a%' and ano_lancamento between 2010 and 2020;

 
/* 3) Liste DISTINCT regioes da tabela de times.
*/
 
-- Use DISTINCT
 
 select distinct nome_time from time_lol;
 
/* 4) Mostre os 5 jogadores com maior media de dano,
   pulando os 2 primeiros.
*/
 
-- Use JOIN + AVG + GROUP BY + ORDER BY DESC + LIMIT + OFFSET
 
 select j.id_jogador,j.nickname, round(avg(e.dano_total),0) as media_dano from jogador j
 join estatistica_jogo e on j.id_jogador = e.id_jogador
 group by j.id_jogador, j.nickname 
 order by media_dano desc
 limit 5
 offset 2;
 
/* 5) Mostre a media de duracao das partidas
   arredondada para cima.
*/
 
-- Use AVG + CEIL()
 
 select ceil(avg(duracao_min)) from partida;
 
/* 6) Calcule o KDA medio por jogador:
   (kills + assists) / deaths
   Mostre apenas quem tem KDA maior que 3.
*/
 
-- Use JOIN + GROUP BY + HAVING + ROUND
 
select 
    j.nickname,
round(avg(e.kills), 2) as media_kill,
round(avg(e.assists), 2) as media_assist,
round(avg(e.deaths), 2) as media_death,
round((sum(e.kills) + sum(e.assists)) / nullif(sum(e.deaths), 0), 2) as kda
from jogador j
inner join estatistica_jogo e on j.id_jogador = e.id_jogador
group by j.id_jogador, j.nickname
HAVING kda > 3
ORDER BY kda DESC;
 
/* 7) Liste partidas que aconteceram nos ultimos 30 dias.
   Mostre quantos dias se passaram desde cada partida.
*/
 
-- Use CURDATE + DATE_SUB + DATEDIFF
select 
    id_partida, 
    data_partida, datediff(curdate(), data_partida) as dias_quepassaram
from partida
where data_partida >= date_sub(curdate(), interval 30 day);


/* 8) Liste os times com media de gold maior que 75000
   e media de torres maior que 8.
*/
 
-- Use JOIN + GROUP BY + HAVING
 select  
	t.id_time, 
    t.nome_time, 
    round(m.gold_total),
    round(m.torres_destruidas) 
    from time_lol t
 join metrica_time m on t.id_time = m.id_time
 group by t.id_time,t.nome_time, m.gold_total,m.torres_destruidas
 having avg(m.gold_total) > 75000 and 
 (m.torres_destruidas)>8;
 
 
 
/* 9) Mostre jogadores cuja media de kills
   seja maior que a media geral de kills.
*/
 
-- Use SUBQUERY + GROUP BY + HAVING
select 
    j.nickname, 
    round(avg(e.kills),0) as media_jogador
	from jogador j
join estatistica_jogo e on j.id_jogador = e.id_jogador
group by j.id_jogador, j.nickname
having avg(e.kills) > (select avg(kills) from estatistica_jogo);
 
/* 10) Monte um ranking de desempenho por time:
 
score =
(AVG(kills) * 0.4)
+ (AVG(gold_total)/1000 * 0.3)
+ (COUNT(vitorias) * 0.3)
 
Mostre:
- nome_time
- score arredondado
- media_kills
- media_gold
- total_vitorias
 
Ordene do maior para o menor.
*/
 
-- Use JOIN multiplo + GROUP BY + COUNT + AVG + ROUND + ORDER BY DESC
select 
	t.id_time,
    t.nome_time,
    round(
        (avg(e.kills) * 0.4) + 
        (avg(e.ouro_ganho) / 1000 * 0.3) + 
        ((select count(*) from partida p where p.time_vencedor = t.id_time) * 0.3), 
    2) as score,
    round(avg(e.kills),0) as media_kills,
    round(avg(e.ouro_ganho),0) as media_gold,
    (select count(*) from partida p where p.time_vencedor = t.id_time) as total_vitorias
from time_lol t
join estatistica_jogo e on kills
group by t.id_time, t.nome_time
order by score desc;