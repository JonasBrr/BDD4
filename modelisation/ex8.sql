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

-- 2. Modifiez la table "reservation" en ajoutant une nouvelle colonne "id_disponibilite" (clé étrangère référençant la table "disponibilite").
ALTER TABLE reservation
ADD COLUMN id_disponibilite INT,
ADD CONSTRAINT fk_id_disponibilite
    FOREIGN KEY (id_disponibilite)
    REFERENCES disponibilite(id_disponibilite);

-- 3. Modifiez les contraintes SQL existantes pour prendre en compte les contraintes de disponibilité lors de la création et de la mise à jour des réservations.
ALTER TABLE reservation
ADD CONSTRAINT chk_dates_reservation
CHECK (fin_res > debut_res);

-- 4. Implémentez une fonctionnalité permettant de vérifier la disponibilité d'un matériel pour une période donnée avant de permettre la réservation. Si le matériel n'est pas disponible, affichez un message d'erreur approprié.
-- il faut commencer par insérer des données dans la table
INSERT INTO disponibilite (id_materiel, date_debut, date_fin) VALUES
  (1, CURRENT_DATE - INTERVAL '5 days',  CURRENT_DATE + INTERVAL '2 days'),
  (2, CURRENT_DATE - INTERVAL '1 day',   CURRENT_DATE + INTERVAL '5 days'),
  (3, CURRENT_DATE,                      CURRENT_DATE + INTERVAL '3 days'),
  (4, CURRENT_DATE + INTERVAL '1 day',  CURRENT_DATE + INTERVAL '7 days'),
  (5, CURRENT_DATE + INTERVAL '3 days', CURRENT_DATE + INTERVAL '10 days'),

  (6, CURRENT_DATE + INTERVAL '30 days',  CURRENT_DATE + INTERVAL '45 days'),
  (7, CURRENT_DATE + INTERVAL '40 days',  CURRENT_DATE + INTERVAL '75 days'),
  (8, CURRENT_DATE + INTERVAL '60 days',  CURRENT_DATE + INTERVAL '85 days'),

  (9,  CURRENT_DATE + INTERVAL '180 days', CURRENT_DATE + INTERVAL '210 days'),
  (10, CURRENT_DATE + INTERVAL '200 days', CURRENT_DATE + INTERVAL '230 days'),
  (8, CURRENT_DATE + INTERVAL '365 days', CURRENT_DATE + INTERVAL '395 days');
