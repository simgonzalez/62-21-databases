DROP TABLE heg_billet CASCADE CONSTRAINTS;
DROP TABLE heg_seance CASCADE CONSTRAINTS;
DROP TABLE heg_salle CASCADE CONSTRAINTS;
DROP TABLE heg_film CASCADE CONSTRAINTS;

CREATE TABLE heg_film
(
    fil_no    INT
        CONSTRAINT pk_heg_film PRIMARY KEY,
    fil_titre VARCHAR2(100)
        CONSTRAINT nn_fil_titre NOT NULL,
    fil_duree INT
        CONSTRAINT nn_fil_duree NOT NULL,
    CONSTRAINT un_fil_titre UNIQUE (fil_titre)

);

CREATE TABLE heg_salle
(
    sal_no       INT
        CONSTRAINT pk_heg_salle PRIMARY KEY,
    sal_nom      CHAR(3)
        CONSTRAINT nn_sal_nom NOT NULL,
    sal_capacite INT
        CONSTRAINT nn_sal_capacite NOT NULL,
    CONSTRAINT un_sal_nom UNIQUE (sal_nom)
);

CREATE TABLE heg_seance
(
    sea_no     INT
        CONSTRAINT pk_heg_seance PRIMARY KEY,
    sea_fil_no INT
        CONSTRAINT fk_fil_no REFERENCES heg_film (fil_no),
    sea_sal_no INT
        CONSTRAINT fk_sal_no REFERENCES heg_salle (sal_no),
    sea_date   DATE
        CONSTRAINT nn_sea_date NOT NULL
); -- TODO ajouter un check que la date de séance ne soit pas la même qu'une séance qui a lieu dans la meme salle au meme moment

CREATE TABLE heg_billet
(
    bil_no         INT
        CONSTRAINT pk_bil_no PRIMARY KEY,
    bil_sea_no     INT
        CONSTRAINT fk_sea_no REFERENCES heg_seance (sea_no),
    bil_prix       NUMBER
        CONSTRAINT nn_bil_prix NOT NULL,
    bil_date_achat DATE
        CONSTRAINT nn_date_achat NOT NULL
);

-- q2
ALTER TABLE heg_salle
    MODIFY sal_capacite INT DEFAULT 100;

ALTER TABLE heg_billet
    MODIFY bil_date_achat DATE DEFAULT SYSDATE;

ALTER TABLE heg_salle
    ADD CONSTRAINT ck_capacite CHECK (sal_capacite > 49 AND sal_capacite < 501);

-- q3
INSERT INTO heg_salle
VALUES (1, 'too', 200);
INSERT INTO heg_salle
VALUES (2, 'taa', 300);
INSERT INTO heg_salle
VALUES (3, 'tii', 400);

INSERT INTO heg_film
VALUES (1, 'titanic', 85);
INSERT INTO heg_film
VALUES (2, 'titanic2', 115);
INSERT INTO heg_film
VALUES (3, 'titanic3', 165);
INSERT INTO heg_film
VALUES (4, 'titanic4', 180);

INSERT INTO heg_seance
VALUES (1, 1, 1, SYSDATE);
INSERT INTO heg_seance
VALUES (2, 2, 1, TO_DATE('2024-05-01 19:00:00', 'yyyy-MM-dd hh24:mi:ss'));
INSERT INTO heg_seance
VALUES (3, 3, 2, TO_DATE('2024-05-01 19:00:00', 'yyyy-MM-dd hh24:mi:ss'));
INSERT INTO heg_seance
VALUES (4, 1, 3, TO_DATE('2024-05-01 19:00:00', 'yyyy-MM-dd hh24:mi:ss'));
INSERT INTO heg_seance
VALUES (5, 2, 1, TO_DATE('2024-05-01 19:00:00', 'yyyy-MM-dd hh24:mi:ss'));
INSERT INTO heg_seance
VALUES (6, 1, 1, TO_DATE('2023-05-01 19:00:00', 'yyyy-MM-dd hh24:mi:ss'));

INSERT INTO heg_billet
VALUES (1, 1, 10, SYSDATE);
INSERT INTO heg_billet
VALUES (2, 2, 11, SYSDATE);
INSERT INTO heg_billet
VALUES (3, 3, 12, SYSDATE);
INSERT INTO heg_billet
VALUES (4, 4, 13, SYSDATE);
INSERT INTO heg_billet
VALUES (5, 5, 14, SYSDATE);
INSERT INTO heg_billet
VALUES (6, 6, 15, SYSDATE);

COMMIT;
-- q4
UPDATE heg_salle
SET sal_capacite = 350
WHERE sal_capacite = 300;

COMMIT;
-- q5
SELECT fil_titre,
       fil_duree,
       CASE
           WHEN fil_duree > 120 THEN 'long'
           ELSE 'court'
           END AS fil_type
FROM heg_film
WHERE fil_duree > 90;

SELECT hf.fil_titre, h.sal_nom, hs.sea_date
FROM heg_film hf
         LEFT JOIN heg_seance hs ON hs.sea_fil_no = hf.fil_no
         LEFT JOIN heg_salle h ON hs.sea_sal_no = h.sal_no;

SELECT hf.fil_titre, COUNT(sea_no), SUM(fil_duree)
FROM heg_seance
         JOIN heg_film hf ON heg_seance.sea_fil_no = hf.fil_no
GROUP BY fil_no, fil_titre
HAVING COUNT(sea_no) > 1
ORDER BY COUNT(sea_no) DESC;