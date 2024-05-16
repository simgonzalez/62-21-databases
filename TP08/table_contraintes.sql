DROP TABLE heg_club;
DROP TABLE heg_personne;
DROP TABLE heg_competition;
DROP TABLE heg_participe;

CREATE TABLE heg_club
(
    clu_no     NUMBER
        CONSTRAINT pk_heg_club PRIMARY KEY,
    clu_nom    VARCHAR2(20)
        CONSTRAINT nn_heg_club_nom NOT NULL
        CONSTRAINT uk_club_nom UNIQUE,
    clu_email  VARCHAR2(20),
    clu_ville  VARCHAR2(20),
    clu_per_no NUMBER(5)
);

CREATE TABLE heg_personne
(
    per_no     NUMBER
        CONSTRAINT pk_heg_personne PRIMARY KEY,
    per_nom    VARCHAR2(20)
        CONSTRAINT nn_heg_personne_nom NOT NULL,
    per_prenom VARCHAR2(20)
        CONSTRAINT nn_heg_personne_prenom NOT NULL,
    per_sexe   CHAR(1)
        CONSTRAINT ck_heg_personne CHECK (per_sexe IN ('M', 'F')),
    per_email  VARCHAR2(20),
    per_ville  VARCHAR2(20),
    per_clu_no NUMBER(5)
        CONSTRAINT fk_heg_personne REFERENCES heg_club (clu_no),
    CONSTRAINT ck_heg_personne_nom_prenom UNIQUE (per_nom, per_prenom)
);

ALTER TABLE heg_club
    ADD CONSTRAINT fk_heg_club FOREIGN KEY (clu_per_no) REFERENCES heg_personne (per_no);

CREATE TABLE heg_competition
(
    com_no     NUMBER(5)
        CONSTRAINT pk_heg_competition PRIMARY KEY,
    com_nom    VARCHAR2(20)
        CONSTRAINT nn_heg_competition_nom NOT NULL,
    com_date   DATE,
    com_lieu   VARCHAR2(20),
    com_ville  VARCHAR2(20) DEFAULT 'Genève',
    com_prix   NUMBER(3)
        CONSTRAINT ck_heg_competition_prix CHECK (com_prix >= 0),
    com_clu_no NUMBER(5)
        CONSTRAINT fk_heg_competition REFERENCES heg_club (clu_no),
    CONSTRAINT un_heg_competition UNIQUE (com_nom, com_date, com_lieu, com_ville),
    CONSTRAINT ck_heg_competition_date CHECK (com_lieu IS NOT NULL or com_ville IS NOT NULL)
);

CREATE TABLE heg_participe
(
    par_per_no NUMBER(5)
        CONSTRAINT fk_heg_participe_per_no REFERENCES heg_personne (per_no),
    par_com_no NUMBER(5)
        CONSTRAINT fk_heg_participe_com_no REFERENCES heg_competition (com_no) ON DELETE CASCADE,
    CONSTRAINT pk_heg_participe PRIMARY KEY (par_per_no, par_com_no)
);