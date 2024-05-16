INSERT INTO heg_club (clu_no, clu_nom)
VALUES (1, 'HEG-Running');
INSERT INTO heg_club (clu_no, clu_nom)
VALUES (2, 'Football Club 62-21');
INSERT INTO heg_club (clu_no, clu_nom)
VALUES (3, 'Tra^ines-Savates BDD');


INSERT INTO heg_personne (per_no, per_nom, per_prenom, per_ville, per_clu_no)
VALUES (1, 'BON', 'Jean', 'Genève', 3);
INSERT INTO heg_personne (per_no, per_nom, per_prenom, per_ville, per_clu_no)
VALUES (2, 'REMORD', 'Yves', 'Genève', 1);
INSERT INTO heg_personne (per_no, per_nom, per_prenom, per_ville, per_clu_no)
VALUES (3, 'TERIEUR', 'Alex', 'Genève', 1);
INSERT INTO heg_personne (per_no, per_nom, per_prenom, per_ville)
VALUES (4, 'PROVISTE', 'Alain', 'Genève');
INSERT INTO heg_personne (per_no, per_nom, per_prenom, per_ville)
VALUES (5, 'TERIEUR', 'Alain', 'Genève');
INSERT INTO heg_personne (per_no, per_nom, per_prenom, per_ville, per_clu_no)
VALUES (6, 'DISSOIRE', 'Sam', 'Genève', 2);

INSERT INTO HEG_COMPETITION (com_no, com_nom, com_date, com_lieu, com_ville, com_prix, com_clu_no)
VALUES (1, 'Course diplomésHEG', to_date('20.06.2020', 'dd.mm.yyyy'), 'Batelle', 'Carouge', 25, 1);
INSERT INTO HEG_COMPETITION (com_no, com_nom, com_date, com_lieu, com_ville, com_prix, com_clu_no)
VALUES (2, 'Tour du Campus', to_date('26.03.2020', 'dd.mm.yyyy'), 'Batelle', 'Carouge', 10, 1);
INSERT INTO HEG_COMPETITION (com_no, com_nom, com_date, com_lieu, com_prix, com_clu_no)
VALUES (3, 'TouDouMollo-Run', to_date('31.10.2020', 'dd.mm.yyyy'), 'Bout-du-Monde', 30, 3);

UPDATE heg_club
SET clu_per_no = 3
WHERE clu_no in (1, 3);
INSERT INTO heg_club (clu_no, clu_nom)
VALUES (4, 'HEG-SwimmingClub');
INSERT INTO heg_personne (PER_NO, PER_NOM, PER_PRENOM, PER_SEXE, PER_CLU_NO)
VALUES (7, 'DORSA', 'Elsa', 'F', 4);
UPDATE heg_club
SET clu_per_no = 7
WHERE clu_no = 4;
INSERT INTO heg_participe (par_per_no, par_com_no)
VALUES (7, 3);
INSERT INTO heg_participe (par_per_no, par_com_no)
VALUES (6, 3);
INSERT INTO heg_participe (par_per_no, par_com_no)
VALUES (1, 1);
INSERT INTO heg_participe (par_per_no, par_com_no)
VALUES (1, 2);
INSERT INTO heg_participe (par_per_no, par_com_no)
VALUES (2, 1);
INSERT INTO heg_participe (par_per_no, par_com_no)
VALUES (2, 2);
INSERT INTO heg_participe (par_per_no, par_com_no)
VALUES (3, 1);
INSERT INTO heg_participe (par_per_no, par_com_no)
VALUES (3, 2);
UPDATE heg_personne
SET per_clu_no = 2
WHERE per_no = 5;
UPDATE heg_personne
SET per_clu_no = null
WHERE per_no = 6;
DELETE
FROM heg_competition
where com_no = 3;
DELETE
FROM heg_club
where clu_no = 3;