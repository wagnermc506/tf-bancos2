-- --------  << Data Mining >>  ----------
--
--                    SCRIPT DE CONSULTAS (DML)
--
-- Data Criacao ...........: 20/09/2022
-- Autor(es) ..............: João Guedes, Luiz Henrique e Wagner Cunha
-- Banco de Dados .........: MySQL 8.0
-- Base de Dados (nome) ...: anime_rec
--
-- PROJETO => 01 Base de Dados
--         => 12 Tabelas
--         => 01 Visao
--
-- ---------------------------------------------------------

USE anime_rec;

-- A consulta retorna um subconjunto da tabela 'assiste' com as notas dos usuários
-- para cada anime, com animes de determinados gêneros excluídos e cujo o acompanhamento
-- do anime está com status 'concluido'

CREATE VIEW notas_de_animes_concluidos (usuario, anime, nota, nome) AS
SELECT a.usuario, a.anime, a.nota, an.nome FROM
	assiste a
    JOIN (
		SELECT p.anime, an.nome FROM participa p
		JOIN ANIME an ON p.anime = an.id
		WHERE p.anime NOT IN (
			SELECT p.anime
            FROM participa p
            JOIN GENERO g ON p.genero = g.id
            WHERE g.id IN (16, 41)
        )
        GROUP BY p.anime, an.nome) as an ON a.anime = an.anime
	WHERE a.acompanhamento = 2
    LIMIT 1000000;