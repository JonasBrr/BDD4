/* 1. Mettez à jour le modèle de données existant en ajoutant une nouvelle table "disponibilite" avec les colonnes suivantes :
        id_disponibilite (clé primaire)
        id_materiel (clé étrangère référençant la table "materiel")
        date_debut (date de début de la disponibilité)
        date_fin (date de fin de la disponibilité)
*/
CREATE TABLE disponibilite (
    id_disponibilite SERIAL PRIMARY KEY,
    id_materiel INT NOT NULL,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    FOREIGN KEY (id_materiel) REFERENCES materiel(id_materiel)
);
