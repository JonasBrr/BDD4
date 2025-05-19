SELECT u.id_user, u.prenom, u.nom_user, u.email
FROM utilisateur u
JOIN reservation r ON u.id_user = r.id_user
GROUP BY u.id_user, u.prenom, u.nom_user, u.email
HAVING COUNT(r.id_user) = 1;