USE anime_rec;

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