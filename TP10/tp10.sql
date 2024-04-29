--le prix des compétitions en Frs et en € (cours appliqué 1.1), liste triée par date
SELECT COM_DATE, COM_PRIX, COM_PRIX * 1.1 as Prix_EUR
from heg_competition
order by com_date;

-- le prix moyen des compétitions (arrondi au Franc)
SELECT ROUND(AVG(COM_PRIX), 0) as Prix_Moyen
from heg_competition;

-- le nombre de « Tour du Campus » organisés
SELECT COUNT(*) as Nb_Tour_Campus
from heg_competition
where com_nom = 'Tour du Campus';

-- le prix de la compétition la moins chère et la plus chère à Carouge
SELECT MIN(COM_PRIX) as Prix_Min, MAX(COM_PRIX) as Prix_Max
from heg_competition
where com_ville = 'Carouge';

-- la liste des compétitions à venir en indiquant le nombre de jours à attendre
SELECT COM_NOM, COM_DATE, TRUNC(COM_DATE - SYSDATE) as Nb_Jours
from heg_competition
where COM_DATE > SYSDATE
order by COM_DATE;

-- le nombre de chaque type de compétition (selon le nom), la moins chère, la plus chère et le prix moyen
SELECT COM_NOM,
       COUNT(*)                as Nb,
       MIN(COM_PRIX)           as Prix_Min,
       MAX(COM_PRIX)           as Prix_Max,
       ROUND(AVG(COM_PRIX), 0) as Prix_Moyen
from heg_competition
group by COM_NOM;

-- le nombre de compétitions par lieu & ville, liste triée du plus grand au plus petit nombre
SELECT COM_LIEU || ' (' || com_ville || ')' as Lieu, COUNT(com_no) as "Nombre compétition"
from heg_competition
group by COM_LIEU, COM_VILLE
order by count(com_no) desc;

-- le nombre de participants par lieu des compétitions
SELECT COM_LIEU as Lieu,
       case COUNT(par_per_no)
           when 0 then 'Aucun participant'
           when 1 then 'un seul participant'
           else to_char(COUNT(par_per_no)) || ' participants'
           end
                as "Nombre participants"
from heg_competition
         left join heg_participe on com_no = par_com_no
group by COM_LIEU
order by count(par_per_no) desc;

-- le nombre de compétitions par mois (7) Bonus: liste triée par date
SELECT TO_CHAR(COM_DATE, 'MM-yyyy') as Mois, COUNT(*) as "Nombre compétitions"
from HEG_COMPETITION
group by TO_CHAR(COM_DATE, 'MM-yyyy')
order by max(com_date);

-- la liste des lieux où il n'y a qu'une seule compétition
select com_nom, com_lieu
from heg_competition
group by com_lieu, com_nom
having count(com_lieu) = 1;

-- la liste des lieux où le prix moyen des compétitions est de moins de 40.-
SELECT COM_LIEU as Lieu, ROUND(AVG(COM_PRIX), 0) as Prix_Moyen
from heg_competition
group by COM_LIEU
having AVG(COM_PRIX) < 40;

-- les lieux où il y a plusieurs compétitions (au moins 2) qui coûtent moins de 40.-
SELECT COM_LIEU as Lieu, COUNT(*) as "Nombre compétitions", ROUND(AVG(COM_PRIX), 0) as Prix_Moyen
from heg_competition
group by COM_LIEU
having COUNT(*) >= 2
   and AVG(COM_PRIX) < 40;

-- le nombre de compétitions par tranche de prix :
SELECT case
           when COM_PRIX is null then 'Non défini'
           when COM_PRIX >= 40 then 'Chère (40.- et plus)'
           when COM_PRIX >= 20 then 'Prix standard (moins de 40.-)'
           else 'Bon marché (moins de 20.-)'
           end  as Catégorie,
       COUNT(*) as "Nb compétitions"
from heg_competition
group by case
             when COM_PRIX is null then 'Non défini'
             when COM_PRIX >= 40 then 'Chère (40.- et plus)'
             when COM_PRIX >= 20 then 'Prix standard (moins de 40.-)'
             else 'Bon marché (moins de 20.-)'
             end;