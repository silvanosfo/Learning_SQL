USE clinica_V1_1;
#SELECT codigo_postal.localidade, utente.nome FROM codigo_postal LEFT JOIN utente  ON utente.codigo_postal = codigo_postal.codigo_postal;
#SELECT nome, data_nascimento, date(data_hora) AS dia_consulta FROM utente LEFT JOIN consulta_medica ON numero_utente = utente;
#SELECT localidade, numero_utente, realizou_se
#FROM (utente INNER JOIN consulta_medica ON numero_utente = utente)
#RIGHT JOIN codigo_postal ON utente.codigo_postal = codigo_postal.codigo_postal
#WHERE realizou_se IS NULL OR realizou_se = False;
/*SELECT nome FROM utente LEFT JOIN consulta_medica ON numero_utente = utente
WHERE realizou_se IS NULL OR realizou_se = False;*/
#SELECT nome, codigo_postal FROM utente UNION SELECT nome, codigo_postal FROM medico;
#SELECT DISTINCT codigo_postal FROM utente UNION SELECT DISTINCT codigo_postal FROM medico;
#SELECT count(nome) FROM utente;
#SELECT count(DISTINCT(utente)) FROM consulta_medica WHERE realizou_se = 1;
/*SELECT utente, sum(preco) FROM consulta_medica
INNER JOIN medico ON medico = numero_ordem 
INNER JOIN especialidade ON especialidade.codigo = especialidade
GROUP BY utente;*/
/*SELECT medico, sum(preco) FROM consulta_medica
INNER JOIN medico ON medico = numero_ordem 
INNER JOIN especialidade ON especialidade.codigo = especialidade
GROUP BY medico;*/
/*SELECT count(nome) FROM utente
WHERE telefone is NULL;*/
/*SELECT utente, format(avg(preco),2) FROM consulta_medica
INNER JOIN medico ON medico = numero_ordem 
INNER JOIN especialidade ON especialidade.codigo = especialidade
WHERE realizou_se = 1
GROUP BY utente;*/
/*SELECT medico, sum(preco) AS total FROM consulta_medica
INNER JOIN medico ON medico = numero_ordem 
INNER JOIN especialidade ON especialidade.codigo = especialidade
WHERE realizou_se = 1
GROUP BY medico
ORDER BY total DESC
LIMIT 1;*/
/*SELECT especialidade.nome, sum(preco) FROM especialidade
INNER JOIN medico ON especialidade.codigo = especialidade
INNER JOIN consulta_medica ON medico = numero_ordem
WHERE realizou_se = 1
GROUP BY especialidade.nome;*/
/*SELECT sum(preco) FROM especialidade
INNER JOIN medico ON especialidade.codigo = especialidade
INNER JOIN consulta_medica ON medico = numero_ordem
WHERE realizou_se = 1;*/
/*SELECT utente as cont FROM consulta_medica
INNER JOIN medico ON medico = numero_ordem 
INNER JOIN especialidade ON especialidade.codigo = especialidade
WHERE realizou_se = 1
GROUP BY utente
HAVING count(utente) = 3;*/
/*CREATE VIEW total_por_medico_view AS
	SELECT M.numero_ordem, SUM(E.preco) AS total_medico
    FROM medico M INNER JOIN especialidade E ON E.codigo = M.especialidade
    GROUP BY M.numnero_ordem;
-- DROP VIEW total_por_medico_view*/
/*INSERT INTO `clinica_V1_1`.`codigo_postal`
(`codigo_postal`,`localidade`)
VALUES (<{codigo_postal: }>,<{localidade: }>);*/
/*SELECT sum(preco-(preco*0.23)) FROM especialidade
INNER JOIN medico ON especialidade.codigo = especialidade
INNER JOIN consulta_medica ON medico = numero_ordem
WHERE realizou_se = 1;*/
/*SELECT sum(preco/5) FROM especialidade
INNER JOIN medico ON especialidade.codigo = especialidade
INNER JOIN consulta_medica ON medico = numero_ordem
WHERE realizou_se = 1;*/
/*SELECT DISTINCT count(medico) AS 'Nº Consultas', nome
FROM consulta_medica INNER JOIN medico ON numero_ordem = medico
WHERE realizou_se > 0
GROUP BY medico
ORDER BY 'Nº Consultas' ASC
LIMIT 1;*/
/*SELECT DISTINCT count(utente) AS 'Nº', nome
FROM consulta_medica INNER JOIN utente ON numero_utente = utente
WHERE realizou_se > 0
GROUP BY utente
ORDER BY Nº ASC
LIMIT 1;*/
/*SELECT count(especialidade.nome)
FROM especialidade
INNER JOIN medico ON especialidade.codigo = medico.especialidade
INNER JOIN consulta_medica ON numero_ordem = medico
WHERE realizou_se = 0
GROUP BY especialidade.nome;*/
/*SELECT utente, (sum(preco) + count(realizou_se)*2)
FROM consulta_medica
INNER JOIN medico ON numero_ordem = medico
INNER JOIN especialidade ON especialidade.codigo = medico.especialidade
WHERE hour(data_hora) >= 18 && realizou_se = 0
GROUP BY utente;*/
/*SELECT count(nome) FROM utente
WHERE nome LIKE '%Galv%o%';*/
/*SELECT count(especialidade), utente, especialidade FROM medico
INNER JOIN consulta_medica ON numero_ordem = medico
GROUP BY utente, especialidade;*/
/*SELECT count(utente.nome) FROM utente
INNER JOIN consulta_medica ON utente = numero_utente
INNER JOIN medico ON numero_ordem = medico
INNER JOIN especialidade ON especialidade.codigo = medico.especialidade
WHERE utente.telefone IS NULL AND especialidade.nome = 'Ginecologia' AND realizou_se > 0;*/
/*SELECT count(utente.nome) FROM utente
INNER JOIN consulta_medica ON utente = numero_utente
INNER JOIN medico ON numero_ordem = medico
INNER JOIN especialidade ON especialidade.codigo = medico.especialidade
WHERE especialidade.nome = 'Ginecologia' OR 'Cardiologia' AND realizou_se > 0 and day(data_hora) = day(last_day(data_hora));*/
/*CREATE VIEW media_gastos_utente AS
	SELECT utente, format(avg(preco),2) FROM consulta_medica
	INNER JOIN medico ON medico = numero_ordem 
	INNER JOIN especialidade ON especialidade.codigo = especialidade
	WHERE realizou_se = 1
	GROUP BY utente;*/
/*SELECT *
FROM media_gastos_utente
WHERE `format(avg(preco),2)` > 173;*/
/*UPDATE consulta_medica
SET diagnostico = 'Colesterol um pouco acima do esperado'
WHERE codigo=5;*/
/*UPDATE medico
SET telefone = '222333333'
WHERE numero_ordem = 555;*/
/*		ESTÁ ERRADO A 19.3
UPDATE especialidade
SET preco = preco-preco*0.1
WHERE especialidade.codigo IN (
	SELECT E.codigo
	FROM especialidade E 
    LEFT JOIN medico M ON M.especialidade = E.codigo 
    LEFT JOIN consulta_medica CM ON CM.medico = M.numero_ordem
	GROUP BY E.codigo
	HAVING count(CM.codigo) < 1 );*/
/*		15.2
SELECT M.nome, sum(E.preco) AS total
FROM medico M
INNER JOIN especialidade E ON E.codigo = M.especialidade 
INNER JOIN consulta_medica CM ON CM.medico = M.numero_ordem
WHERE CM.realizou_se = TRUE
group by M.nome
HAVING total = (
			SELECT sum(E.preco) AS maximo
			FROM medico M
			INNER JOIN especialidade E ON E.codigo = M.especialidade
			INNER JOIN consulta_medica CM ON CM.medico = M.numero_ordem
			WHERE CM.realizou_se = TRUE
			group by M.nome
			ORDER BY maximo DESC
			LIMIT 1 );*/
/*		15.3
SELECT M.nome, count(medico) AS TOTAL
FROM consulta_medica CM
INNER JOIN medico M WHERE M.numero_ordem = CM.medico
GROUP BY medico
HAVING total = (
				SELECT count(medico) AS TOTAL
				FROM consulta_medica CM
				INNER JOIN medico M WHERE M.numero_ordem = CM.medico
				GROUP BY medico
                LIMIT 1
				);*/
/*		15.4
SELECT CM.utente, U.nome, sum(E.preco) AS total
FROM especialidade E
INNER JOIN medico M ON M.especialidade = E.codigo
INNER JOIN consulta_medica CM ON CM.medico = M.numero_ordem
INNER JOIN utente U ON U.numero_utente = CM.utente
GROUP BY CM.utente
HAVING total = (
				SELECT sum(E.preco) AS total
				FROM especialidade E
				INNER JOIN medico M ON M.especialidade = E.codigo
				INNER JOIN consulta_medica CM ON CM.medico = M.numero_ordem
				INNER JOIN utente U ON U.numero_utente = CM.utente
				GROUP BY CM.utente
                ORDER BY total ASC
                LIMIT 1
				);*/
                
/*		15.5	UNION
SELECT nome
FROM utente
WHERE telefone IS NULL
UNION
SELECT nome
FROM medico
WHERE telefone IS NULL;

SELECT nome
FROM (
	SELECT M.nome, M.telefone
	FROM medico M
    UNION
    SELECT U.nome, U.telefone
	FROM utente U
	) AS tabela
WHERE telefone IS NULL;*/

/*		15.6
SELECT U.nome, count(utente) AS total
FROM utente U
INNER JOIN consulta_medica CM ON CM.utente = U.numero_utente
GROUP BY utente
HAVING total = (
				SELECT count(utente) AS total
				FROM utente U
				INNER JOIN consulta_medica CM ON CM.utente = U.numero_utente
				GROUP BY utente
				ORDER BY total ASC
				LIMIT 1
				);*/
SELECT E.nome, count(E.codigo) AS total
FROM especialidade E
INNER JOIN medico M ON M.especialidade = E.codigo
INNER JOIN consulta_medica CM ON CM.medico = M.numero_ordem
WHERE realizou_se = 1
GROUP BY E.nome
HAVING total = (
				SELECT count(E.codigo) AS total
				FROM especialidade E
				INNER JOIN medico M ON M.especialidade = E.codigo
				INNER JOIN consulta_medica CM ON CM.medico = M.numero_ordem
				WHERE realizou_se = 0
				GROUP BY E.nome
				ORDER BY total DESC
				LIMIT 1
				);




























