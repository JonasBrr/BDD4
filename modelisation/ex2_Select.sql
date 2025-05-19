-- requete permettant d'obtenir toute les entrées de la table materiel la quantité est de plus de 10
SELECT id_materiel, nom_materiel, quantite_materiel
FROM materiel
WHERE quantite_materiel > 10;

-- requete permettant d'obtenir toute les entrées de la table utilisateur où le prénom est Paul
SELECT id_user, email, nom_user, prenom
FROM utilisateur
WHERE prenom = 'Paul';

-- requete permettant d'obtenir toute les entrées de la table reservation pour lesquels le matériel avec l'id 4 a été reservé
SELECT id_res, debut_res, fin_res, quantite_res, id_materiel, id_user
FROM reservation
WHERE id_materiel = 4;
