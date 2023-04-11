CREATE SCHEMA IF NOT EXISTS cia_aerea;

CREATE SEQUENCE cia_aerea.aviao_id_seq
INCREMENT 1
START 1
CACHE 1;

CREATE TABLE IF NOT EXISTS cia_aerea.aviao (
	id BIGINT NOT NULL UNIQUE DEFAULT NEXTVAL('cia_aerea.aviao_id_seq'),
	total_assento INTEGER NOT NULL,
	capacidade_combustivel NUMERIC(8, 2) NOT NULL,
	modelo VARCHAR(200) NOT NULL,
	data_criacao TIMESTAMP NOT NULL
);

ALTER TABLE cia_aerea.aviao ADD CONSTRAINT pk_aviao PRIMARY KEY(id);

CREATE SEQUENCE cia_aerea.pilot_id_seq
INCREMENT 1
START 1
CACHE 1;

CREATE TABLE IF NOT EXISTS cia_aerea.piloto (
	id BIGINT NOT NULL UNIQUE DEFAULT NEXTVAL('cia_aerea.pilot_id_seq'),
	nome VARCHAR(100) NOT NULL,
	documento VARCHAR(30) NOT NULL UNIQUE,
	data_admissao TIMESTAMP NOT NULL DEFAULT NOW()
);

ALTER TABLE cia_aerea.piloto ADD CONSTRAINT pk_piloto PRIMARY KEY(id);

CREATE SEQUENCE cia_aerea.aeroporto_id_seq
INCREMENT 1
START 1
CACHE 1;

CREATE TABLE IF NOT EXISTS cia_aerea.aeroporto (
	id BIGINT NOT NULL UNIQUE DEFAULT NEXTVAL('cia_aerea.aeroporto_id_seq'),
	nome VARCHAR(100) NOT NULL,
	logradouro VARCHAR(200) NOT NULL,
	pais VARCHAR(50) NOT NULL
);

ALTER TABLE cia_aerea.aeroporto ADD CONSTRAINT pk_aeroporto PRIMARY KEY(id);

CREATE SEQUENCE cia_aerea.voo_id_seq
INCREMENT 1
START 1
CACHE 1;

CREATE TABLE IF NOT EXISTS cia_aerea.voo (
	id BIGINT NOT NULL UNIQUE DEFAULT NEXTVAL('cia_aerea.voo_id_seq'),
	nome_voo VARCHAR(100) NOT NULL,
	data_estimada_partida TIMESTAMP NOT NULL,
	data_partida TIMESTAMP NULL,
	data_chegada TIMESTAMP,
	id_aeroporto_origem BIGINT NOT NULL,
	id_aeroporto_destino BIGINT NOT NULL,
	id_aviao BIGINT NOT NULL,
	id_piloto BIGINT NOT NULL,
	id_copiloto BIGINT NOT NULL
);

ALTER TABLE cia_aerea.voo ADD CONSTRAINT pk_voo PRIMARY KEY(id);
ALTER TABLE cia_aerea.voo ADD CONSTRAINT fk_aeroporto_origem FOREIGN KEY(id_aeroporto_origem) REFERENCES cia_aerea.aeroporto(id);
ALTER TABLE cia_aerea.voo ADD CONSTRAINT fk_aeroporto_destino FOREIGN KEY(id_aeroporto_destino) REFERENCES cia_aerea.aeroporto(id);
ALTER TABLE cia_aerea.voo ADD CONSTRAINT fk_aviao FOREIGN KEY(id_aviao) REFERENCES cia_aerea.aviao(id);
ALTER TABLE cia_aerea.voo ADD CONSTRAINT fk_piloto FOREIGN KEY(id_piloto) REFERENCES cia_aerea.piloto(id);
ALTER TABLE cia_aerea.voo ADD CONSTRAINT fk_copiloto FOREIGN KEY(id_copiloto) REFERENCES cia_aerea.piloto(id);

CREATE SEQUENCE cia_aerea.passageiro_id_seq
INCREMENT 1
START 1
CACHE 1;

CREATE TABLE IF NOT EXISTS cia_aerea.passageiro (
	id BIGINT NOT NULL UNIQUE DEFAULT NEXTVAL('cia_aerea.passageiro_id_seq'),
	nome VARCHAR(100) NOT NULL,
	documento VARCHAR(30) NOT NULL UNIQUE,
	data_nascimento TIMESTAMP NOT NULL,
	telefone VARCHAR(20) NOT NULL,
	telefone_emergencia VARCHAR(20)
);

ALTER TABLE cia_aerea.passageiro ADD CONSTRAINT pk_passageiro PRIMARY KEY(id);

CREATE SEQUENCE cia_aerea.passagem_id_seq
INCREMENT 1
START 1
CACHE 1;

CREATE TABLE IF NOT EXISTS cia_aerea.passagem (
	id BIGINT NOT NULL UNIQUE DEFAULT NEXTVAL('cia_aerea.passagem_id_seq'),
	valor NUMERIC(8, 4) NOT NULL,
	id_voo BIGINT NOT NULL,
	id_passageiro BIGINT NOT NULL,
	forma_pagamento VARCHAR(100)
);

ALTER TABLE cia_aerea.passagem ADD CONSTRAINT pk_passagem PRIMARY KEY(id);
ALTER TABLE cia_aerea.passagem ADD CONSTRAINT fk_voo FOREIGN KEY(id_voo) REFERENCES cia_aerea.voo(id);
ALTER TABLE cia_aerea.passagem ADD CONSTRAINT fk_passageiro FOREIGN KEY(id_passageiro) REFERENCES cia_aerea.passageiro(id);
