CREATE DATABASE IF NOT EXISTS anime_rec;

USE anime_rec;

CREATE TABLE ANIME (
    id INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    tipo ENUM('TV', 'MOVIE', 'OVA', 'SPECIAL', 'ONA', 'MUSIC'),
    num_episodios INT NOT NULL,
--     estreia DATE NOT NULL,
    material_original VARCHAR(30) NOT NULL,
--     duracao_min FLOAT NOT NULL,
--     classificacao_indicativa VARCHAR(120) NOT NULL,
    `rank` INT NOT NULL,
    popularidade INT NOT NULL,
    num_membros INT NOT NULL,
    num_favoritos INT NOT NULL,
    ano INT,
    estacao ENUM('inverno', 'primavera', 'verao', 'outono'),
    nota INT NOT NULL,
    num_nota1 INT NOT NULL,
    num_nota2 INT NOT NULL,
    num_nota3 INT NOT NULL,
    num_nota4 INT NOT NULL,
    num_nota5 INT NOT NULL,
    num_nota6 INT NOT NULL,
    num_nota7 INT NOT NULL,
    num_nota8 INT NOT NULL,
    num_nota9 INT NOT NULL,
    num_nota10 INT NOT NULL,
    
    CONSTRAINT anime_pk PRIMARY KEY (id)
)ENGINE = InnoDB;

CREATE TABLE USUARIO (
    id INT NOT NULL,

    CONSTRAINT usuario_pk PRIMARY KEY (id)
)ENGINE = InnoDB;

CREATE TABLE PRODUTOR (
    id INT NOT NULL,
    nome VARCHAR(150) NOT NULL,

    CONSTRAINT produtor_pk PRIMARY KEY (id)
)ENGINE = InnoDB;

CREATE TABLE LICENCIADOR (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,

    CONSTRAINT licenciador_pk PRIMARY KEY (id)
)ENGINE = InnoDB;

CREATE TABLE ESTUDIO (
    id INT NOT NULL,
    nome VARCHAR(50) NOT NULL,

    CONSTRAINT estudio_pk PRIMARY KEY (id)
)ENGINE = InnoDB;

CREATE TABLE GENERO (
    id INT NOT NULL,
    nome VARCHAR(40),

    CONSTRAINT genero_pk PRIMARY KEY (id)
)ENGINE = InnoDB;

CREATE TABLE ACOMPANHAMENTO (
    id INT NOT NULL,
    description VARCHAR(25) NOT NULL,

    CONSTRAINT acompanhamento_pk PRIMARY KEY (id)
)ENGINE = InnoDB;

CREATE TABLE produz (
    produtor INT NOT NULL,
    anime INT NOT NULL,

    CONSTRAINT produz_produtor_fk FOREIGN KEY (produtor) REFERENCES PRODUTOR(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,
    CONSTRAINT produz_anime_fk FOREIGN KEY (anime) REFERENCES ANIME(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
)ENGINE = InnoDB;

CREATE TABLE licencia (
    licenciador INT NOT NULL,
    anime INT NOT NULL,

    CONSTRAINT licencia_licenciador_fk FOREIGN KEY (licenciador) REFERENCES LICENCIADOR(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,
    CONSTRAINT licencia_anime_fk FOREIGN KEY (anime) REFERENCES ANIME(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
)ENGINE = InnoDB;

CREATE TABLE anima (
    estudio INT NOT NULL,
    anime INT NOT NULL,

    CONSTRAINT anima_estudio_fk FOREIGN KEY (estudio) REFERENCES ESTUDIO(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,
    CONSTRAINT anima_anime_fk FOREIGN KEY (anime) REFERENCES ANIME(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
)ENGINE = InnoDB;

CREATE TABLE participa (
    genero INT NOT NULL,
    anime INT NOT NULL,

    CONSTRAINT participa_genero_fk FOREIGN KEY (genero) REFERENCES GENERO(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,
    CONSTRAINT participa_anime_fk FOREIGN KEY (anime) REFERENCES ANIME(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
)ENGINE = InnoDB;

CREATE TABLE assiste (
    anime INT NOT NULL,
    usuario INT NOT NULL,
    acompanhamento INT NOT NULL,
    nota INT NOT NULL,
    num_episodios_assistidos INT NOT NULL,

    CONSTRAINT assiste_anime_fk FOREIGN KEY (anime) REFERENCES ANIME(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,
    CONSTRAINT assiste_usuario_fk FOREIGN KEY (usuario) REFERENCES USUARIO(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,
    CONSTRAINT assiste_acomp_fk FOREIGN KEY (acompanhamento) REFERENCES ACOMPANHAMENTO(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
)ENGINE = InnoDB;


CREATE TABLE conecta_anime_recomendados(
    anime1 INT NOT NULL,
    anime2 INT NOT NULL,
    usuario INT NOT NULL,

    CONSTRAINT conecta_anime_recomendados_anime1_fk FOREIGN KEY (anime1) REFERENCES ANIME(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,
    CONSTRAINT conecta_anime_recomendados_anime2_fk FOREIGN KEY (anime2) REFERENCES ANIME(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,

    CONSTRAINT conecta_anime_recomendados_usuario_fk FOREIGN KEY (usuario) REFERENCES USUARIO(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,

    CONSTRAINT conecta_anime_recomendados_unique UNIQUE (anime1, anime2, usuario)
)ENGINE = InnoDB;
