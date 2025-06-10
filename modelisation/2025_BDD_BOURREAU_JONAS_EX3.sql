SELECT u.id_user, u.prenom, u.nom_user, u.email
FROM utilisateur u
JOIN reservation r ON u.id_user = r.id_user
GROUP BY u.id_user, u.prenom, u.nom_user, u.email
HAVING COUNT(r.id_user) = 1;
-- Permet de connaitre les utilisateur qui ont au moins une réservation la deuxième version est plus optimisé

SELECT prenom, nom FROM utilisateur WHERE id_utilisateur IN (SELECT id_utilisateur FROM reservation);

SELECT DISTINCT prenom, nom FROM utilisateur INNER JOIN reservation ON reservation.id_utilisateur = utilisateur.id_utilisateur;


-- Permet de connaitre le materiel emprunté pour un utilisateur donne dans notre cas Sophie mais si on veut un id spécifique on peut changer WHERE utilisateur.id_utilisateur = X


SELECT materiel.designation, reservation.date_debut, reservation.date_fin 
FROM reservation INNER JOIN utilisateur ON reservation.id_utilisateur = utilisateur.id_utilisateur 
				 INNER JOIN materiel ON materiel.id_materiel = reservation.id_materiel WHERE utilisateur.prenom = 'Sophie'