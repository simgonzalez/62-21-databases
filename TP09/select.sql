--tous les renseignements possibles de chaque personne
SELECT * FROM heg_personne;

--la liste des noms et prénoms de toutes les personnes (32)
--Avec conditions : (entre parenthèses, le nombre d’enregistrements concernés/affichés)
SELECT per_nom, per_prenom FROM heg_personne;

--la liste des noms et prénoms de tous les « Alain »
SELECT per_nom, per_prenom FROM heg_personne
    WHERE LOWER(per_prenom) = 'alain' OR LOWER(per_nom) = 'alain';

--la liste de toutes les femmes qui font partie du club n° 3
SELECT per_nom, per_prenom FROM heg_personne
    WHERE per_sexe = 'F' AND per_clu_no = 3;

--noms et prénoms des personnes 2, 3, 4, 6 et 9
SELECT per_nom, per_prenom FROM heg_personne
    WHERE per_no IN (2, 3, 4, 6, 9);

--le nom&prénom de toutes les personnes dont le prénom a pour première lettre "A"
SELECT per_nom, per_prenom FROM heg_personne
    WHERE LOWER(per_prenom) LIKE 'a%';

--la liste de tous les hommes qui ne font pas partie d’un club, triée par nom/prénom
SELECT per_nom, per_prenom FROM heg_personne
    WHERE per_sexe = 'M' AND per_clu_no IS NULL
    ORDER BY per_nom, per_prenom;

--le nom et la ville des personnes qui n'habitent pas à Genève
SELECT per_nom, per_ville FROM heg_personne
    WHERE per_ville != 'Genève';

--les personnes qui ont un mail @heg.ch
SELECT * FROM heg_personne
    WHERE lower(per_email) LIKE '%@heg.ch';

--le nom, le lieu et la date des compétitions qui auront lieu en juin 2022, trié par date
SELECT com_nom, com_lieu, com_date FROM heg_competition
    WHERE com_date BETWEEN '01/06/2022' AND '30/06/2022'
    ORDER BY com_date;

-- prénom et nom des personnes dans une seule colonne nommée "Nom Complet"
SELECT per_prenom || ' ' || per_nom AS "Nom Complet" FROM heg_personne;

--la liste des compétitions triées par date sous la forme suivante : (10)
--« Le 20/06/21 a lieu à Battelle (Carouge) la compétition : Course diplômésHEG »
SELECT 'Le ' || com_date || ' a lieu à ' || com_lieu || ' (' || com_ville || ') la compétition : ' || com_nom AS "Compétition" FROM heg_competition
    ORDER BY com_date;

--prénom & nom des personnes qui ne font partie d'aucun club
SELECT per_prenom, per_nom FROM heg_personne
    WHERE per_clu_no IS NULL;

--prénom & nom des personnes faisant partie d'un club, avec le nom du club
SELECT per_prenom, per_nom, clu_nom FROM heg_personne
    JOIN heg_club ON per_clu_no = clu_no;

--prénom & nom des personnes faisant partie d'un club de Genève
SELECT per_prenom, per_nom FROM heg_personne
    JOIN heg_club ON per_clu_no = clu_no
    WHERE clu_ville = 'Genève';

--prénom & nom de TOUTES les personnes, avec nom de leur club éventuel (vide sinon)
SELECT per_prenom, per_nom, clu_nom FROM heg_personne
    LEFT JOIN heg_club ON per_clu_no = clu_no;

--liste de TOUS les clubs, avec le nom des personnes qui en font partie
SELECT clu_nom, per_nom, per_prenom FROM heg_club
    LEFT JOIN heg_personne ON per_clu_no = clu_no;

--liste de tous les clubs, avec nom du président
SELECT clu_nom, per_nom, per_prenom FROM heg_club
    JOIN heg_personne ON clu_per_no = per_no;

-- liste des compétitions, avec nom du club organisateur
SELECT com_nom, clu_nom FROM heg_competition
    JOIN heg_club ON com_clu_no = clu_no;

--prénom & nom des personnes, avec le nom et la date des compétitions auxquelles elles participent
SELECT per_prenom, per_nom, com_nom, com_date FROM heg_personne
    JOIN heg_participe ON per_no = par_per_no
    JOIN heg_competition ON par_com_no = com_no;

--prénom & nom des personnes participant à au moins une compétition (en n'affichant qu'une seule fois chaque personne !)
SELECT DISTINCT per_prenom, per_nom FROM heg_personne
    JOIN heg_participe ON per_no = par_per_no;

--prénom & nom des personnes participant à au moins une compétition en 2022
SELECT DISTINCT per_prenom, per_nom FROM heg_personne
    JOIN heg_participe ON per_no = par_per_no
    JOIN heg_competition ON par_com_no = com_no
    WHERE com_date BETWEEN '01/01/2022' AND '31/12/2022';

--prénom & nom des personnes ne participant à aucune compétition
SELECT per_prenom, per_nom FROM heg_personne
    WHERE per_no NOT IN (SELECT par_per_no FROM heg_participe);

--« question bonus » : prénom & nom des personnes, avec le nom de leur club (vide le cas échéant), ainsi que le nom du président du club
SELECT per_prenom, per_nom, clu_nom, per_nom AS "Président" FROM heg_personne
    LEFT JOIN heg_club ON per_clu_no = clu_no
    LEFT JOIN heg_personne ON clu_per_no = per_no;