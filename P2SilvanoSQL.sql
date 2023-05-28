# 2.1.	
# Mostre em que datas se realizou cada jogo.
SELECT JG.id, JG.nome_jogo, data_inicio, data_fim
FROM partida P
INNER JOIN jogo JG ON P.jogo_id = JG.id;

# 2.2.	
# Mostre o número de participantes que cada partida teve;
SELECT P.id, count(J.id) AS 'Total Participantes'
FROM jogador J
INNER JOIN registo_partida RG ON RG.jogador_id = J.id
INNER JOIN partida P ON RG.partida_id = P.id
GROUP BY P.id;

# 2.3.	
# Quantas partidas já existiram até ao momento;
SELECT count(id) AS 'Partidas Existentes'
FROM partida
WHERE data_fim < now();

# 2.4.	
# Liste todas os jogos que cada jogador já jogou;
SELECT J.id, J.nome, JG.id, JG.nome_jogo
FROM jogo JG
INNER JOIN partida P ON P.jogo_id = JG.id
INNER JOIN registo_partida RG on RG.partida_id = P.id
INNER JOIN jogador J ON RG.jogador_id = J.id;

# 2.5.	
# Mostre os utilizadores que nunca participaram em partidas;
SELECT J.id, nome
FROM jogador J
LEFT JOIN registo_partida RG ON RG.jogador_id = J.id
LEFT JOIN partida P ON RG.partida_id = P.id
WHERE partida_id IS NULL;

# 2.6.	
# Qual o jogo que teve menos participantes até ao momento, mas cujo valor é superior a 0;
SELECT JG.id, JG.nome_jogo, count(RG.jogador_id) AS minimo
FROM jogo JG
INNER JOIN partida P ON P.jogo_id = JG.id
INNER JOIN registo_partida RG ON RG.partida_id = P.id
GROUP BY JG.id
HAVING minimo = (
				SELECT count(RG.jogador_id) AS participantes
				FROM jogo JG
				INNER JOIN partida P ON P.jogo_id = JG.id
				INNER JOIN registo_partida RG ON RG.partida_id = P.id
				GROUP BY JG.id
				HAVING participantes > 0
				ORDER BY participantes ASC
				LIMIT 1
                );

# 2.7.	
# Mostre lista de partidas ordenadas por ordem descendente, usando como campo a data de início da partida;
SELECT id, data_inicio
FROM partida
ORDER BY data_inicio DESC;

# 2.8.	
# Se o valor do prémio fosse por cada ponto ganho, quanto cada jogador já tinha arrecadado até ao momento;
SELECT J.id, J.nome, sum(RG.pontuacao*P.valor_premio) AS dinheiro_arrecadado
FROM jogador J
LEFT JOIN registo_partida RG ON RG.jogador_id = J.id
LEFT JOIN partida P ON RG.partida_id = P.id
GROUP BY J.id;

# 2.9.	
# Liste desde a terceira partida até à quinta.
SELECT id
FROM partida
LIMIT 2,3;

# 2.10.	
# Liste desde o jogador 2 até ao 4. Faça com que a listagem seja mostrada por ordem descendente relativamente ao seu nome;
SELECT id, nome
FROM ( SELECT id, nome
	   FROM jogador
       LIMIT 1,3 ) AS segundo_quarto
ORDER BY nome DESC;

# 2.11.	
# Qual a média de partidas jogadas por cada jogador?
SELECT avg(RG.partida_id) AS Média
FROM registo_partida RG
INNER JOIN partida P ON RG.partida_id = P.id;
