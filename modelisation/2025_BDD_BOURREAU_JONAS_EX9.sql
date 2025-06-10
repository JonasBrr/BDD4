-- 1. Mettez à jour le modèle de données existant en ajoutant une nouvelle table "RetourMatériel" avec les colonnes suivantes : id_retour (clé primaire) id_reservation (clé étrangère référençant la table "Reservation") date_retour (date à laquelle le matériel a été rendu) retard (indicateur de retard, par exemple, un booléen)
CREATE TABLE RetourMateriel (
    id_retour SERIAL PRIMARY KEY,
    id_reservation INT REFERENCES reservation(id_res) ON DELETE CASCADE,
    date_retour DATE NOT NULL,
    retard BOOLEAN NOT NULL
);

-- 2 Modifiez la table "Reservation" en ajoutant une nouvelle colonne "date_retour_effectif" pour enregistrer la date à laquelle le matériel a été rendu.
ALTER TABLE reservation
ADD COLUMN date_retour_effectif DATE;

-- 3. Implémentez une fonctionnalité permettant de calculer automatiquement le retard sur le retour du matériel, si applicable.
SELECT
  id_res,
  id_user,
  id_materiel,
  debut_res,
  fin_res,
  date_retour_effectif,
  CASE
    WHEN date_retour_effectif IS NULL THEN NULL
    WHEN date_retour_effectif > fin_res THEN TRUE
    ELSE FALSE
  END AS retard
FROM reservation;

-- 4. Implémentez une fonctionnalité permettant de vérifier si un retour est en retard et d'afficher le montant des pénalités, le cas échéant. Testez votre application en effectuant des retours de matériel, certains à l'heure et d'autres en retard, pour vérifier que les contraintes sont correctement appliquées et que les pénalités sont calculées de manière appropriée. 
-- ajouter une colonne penalité
ALTER TABLE RetourMateriel
ADD COLUMN penalite NUMERIC(6,2) DEFAULT 0;

-- Créer une fonction pour insérer un retour et calculer automatiquement le retard et la pénalité
CREATE OR REPLACE FUNCTION inserer_retour(
    p_id_reservation INT,
    p_date_retour DATE
) RETURNS VOID AS $$
DECLARE
    v_fin_res DATE;
    v_retard BOOLEAN;
    v_nb_jours_retard INT;
    v_penalite NUMERIC(6,2);
BEGIN
    -- Récupère la date de fin de la réservation
    SELECT fin_res INTO v_fin_res
    FROM reservation
    WHERE id_res = p_id_reservation;

    -- Calcul du retard
    v_retard := p_date_retour > v_fin_res;
    v_nb_jours_retard := GREATEST(p_date_retour - v_fin_res, 0);
    v_penalite := v_nb_jours_retard * 2.0;

    -- Insère le retour
    INSERT INTO RetourMateriel (id_reservation, date_retour, retard, penalite)
    VALUES (p_id_reservation, p_date_retour, v_retard, v_penalite);

    -- Met à jour la réservation pour garder une trace du retour
    UPDATE reservation
    SET date_retour_effectif = p_date_retour
    WHERE id_res = p_id_reservation;
END;
$$ LANGUAGE plpgsql;

-- tests
SELECT inserer_retour(1, '2025-06-10'); -- Si fin_res = '2025-06-10', pas de pénalité
SELECT inserer_retour(2, '2025-06-15'); -- Si fin_res = '2025-06-12', pénalité = 3 * 2 = 6 €

-- Vérification des pénalités appliquées
SELECT 
  rm.id_reservation,
  rm.date_retour,
  rm.retard,
  rm.penalite,
  r.fin_res
FROM RetourMateriel rm
JOIN reservation r ON r.id_res = rm.id_reservation;
