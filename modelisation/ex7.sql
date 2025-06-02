-- 1. Afficher tous les utilisateurs ayant emprunté au moins un équipement
select distinct id_user, nom_user, prenom from utilisateur inner join reservation on reservation.id_user = utilisateur.id_user;

-- 2. Afficher les équipements n’ayant jamais été empruntés
select id_materiel, nom_materiel from materiel where id_materiel not in(select distinct id_materiel from reservation);

-- 3. Afficher les équipements ayant été emprunté plus de 3 fois
SELECT materiel.nom_materiel, COUNT(reservation.id_res) AS nb_emprunts FROM materiel INNER JOIN reservation ON reservation.id_materiel = materiel.id_materiel GROUP BY materiel.nom_materiel HAVING COUNT(reservation.id_res) > 3;

-- 4. Afficher le nombre d’emprunts pour chaque utilisateur, ordonné par numéro d'étudiant. Les utilisateurs n'ayant pas de réservations en cours doivent également être affichés avec la valeur 0 dans le nombre d'emprunts.
SELECT 
    utilisateur.num_etu,
	utilisateur.id_user,
    utilisateur.nom_user,
    utilisateur.prenom,
    COUNT(reservation.id_res) AS nb_emprunts
FROM utilisateur
LEFT JOIN reservation ON utilisateur.id_user = reservation.id_user
GROUP BY utilisateur.id_user, utilisateur.num_etu, utilisateur.nom_user, utilisateur.prenom
ORDER BY utilisateur.num_etu;