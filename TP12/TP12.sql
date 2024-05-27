-- liste des personnes faisant partie du même club que Dorsa
SELECT *
FROM heg_personne
WHERE per_clu_no = (SELECT per_clu_no FROM heg_personne WHERE per_nom = 'Dorsa' AND per_prenom = 'Elsa');

-- liste des compétitions qui ont lieu dans la même ville que le « Triathlon HEG » mais
-- après celui-ci
SELECT *
FROM heg_competition
WHERE com_ville = (SELECT com_ville FROM heg_competition WHERE com_nom = 'Triathlon HEG')
  AND com_date > (SELECT com_date FROM heg_competition WHERE com_nom = 'Triathlon HEG');

-- le nom des compétitions ayant un prix supérieur au prix moyen des compétitions
SELECT com_nom
FROM heg_competition
WHERE com_prix > (SELECT AVG(com_prix) FROM heg_competition);

-- tous les mails connus (des personnes et des clubs)
SELECT per_email AS email
FROM heg_personne
WHERE per_email IS NOT NULL
UNION
SELECT clu_email AS email
FROM heg_club
WHERE clu_email IS NOT NULL;

-- tous les mails connus (des personnes et des clubs) mais en indiquant le nom du club ou de la personne
SELECT per_email || ' est le mail de ' || per_prenom || ' ' || per_nom AS email
FROM heg_personne
WHERE per_email IS NOT NULL
UNION
SELECT clu_email || ' est le mail du club ' || clu_nom AS email
FROM heg_club
WHERE clu_email IS NOT NULL;

-- liste des Alain et des Géo qui ne font pas partie du Football Club 62-21, en indiquant
-- le nom de leur club, ou la mention "Sans club" le cas échéant
SELECT per_nom, per_prenom, COALESCE(clu_nom, 'Sans club') AS club
FROM heg_personne
         LEFT JOIN heg_club ON per_clu_no = clu_no
WHERE (LOWER(per_prenom) = 'alain' OR LOWER(per_prenom) = 'géo' OR LOWER(per_nom) = 'alain' OR LOWER(per_nom) = 'géo')
  AND LOWER(clu_nom) != 'football club 62-21';

--liste des clubs ayant moins de participants que « Traînes-Savates BDD »
SELECT clu_nom
FROM heg_club
WHERE clu_no IN (SELECT per_clu_no
                 FROM heg_personne
                 GROUP BY per_clu_no
                 HAVING
                     COUNT(per_clu_no) < (SELECT per_clu_no FROM heg_personne WHERE per_nom = 'Traînes-Savates BDD'));

-- nombre moyen de participants (avec et/ou sans prendre en compte les compétitions
-- n’ayant aucun participant)
SELECT AVG(COUNT(*)) AS moyenne_participants
FROM heg_participe
GROUP BY par_com_no;

--liste des compétitions où il y a plus de participants que la moyenne
SELECT com_nom AS competition
FROM heg_competition
WHERE com_no IN (SELECT par_com_no
                 FROM heg_participe
                 GROUP BY par_com_no
                 HAVING COUNT(*) > (SELECT AVG(COUNT(*)) AS moyenne_participants
                                    FROM heg_participe
                                    GROUP BY par_com_no));

-- Préparez la requête permettant d'insérer le nouveau club genevois « HEG-SkiClub »
-- en utilisant le prochain numéro libre comme clé.
-- Comme cette requête ne sera pas exécutée tout de suite, on ne connait pas
-- d'avance le numéro à utiliser, il faut donc le chercher ...
insert into heg_club (clu_no, clu_nom, clu_email, clu_ville)
values ((select max(clu_no) + 1 from heg_club), 'HEG-SkiClub', 'feoiaj@fjieai.com', 'Genève');

--  Insérer une nouvelle compétition « Triathlon HEG » qui aura lieu au même endroit
-- que l'autre, exactement 2 mois avant celui-ci, et organisé par le même club.
-- Le prix fixé sera le prix de la compétition la moins chère ayant lieu dans cette ville.
insert into heg_competition (com_no, com_nom, com_date, com_lieu, com_ville, com_prix, com_clu_no)
values ((select max(com_no) + 1 from heg_competition), 'Triathlon HEG', (select add_months(com_date, -2) from heg_competition where com_nom = 'Triathlon HEG'), 'Bains des Pâquis', 'Genève', (select min(com_prix) from heg_competition where com_ville = 'Genève'),(select com_clu_no from heg_competition where com_nom = 'Triathlon HEG'));
