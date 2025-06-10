-- 1 .Modifiez et adaptez le script pour inclure Les noms des colonnes que vous aurez défini:
ALTER TABLE disponibilite DROP CONSTRAINT IF EXISTS disponibilite_id_materiel_fkey;
ALTER TABLE reservation DROP CONSTRAINT IF EXISTS reservation_id_user_fkey;
ALTER TABLE reservation DROP CONSTRAINT IF EXISTS reservation_id_materiel_fkey;
ALTER TABLE reservation DROP CONSTRAINT IF EXISTS reservation_id_disponibilite_fkey;

TRUNCATE TABLE reservation RESTART IDENTITY CASCADE;
TRUNCATE TABLE disponibilite RESTART IDENTITY CASCADE;
TRUNCATE TABLE materiel RESTART IDENTITY CASCADE;
TRUNCATE TABLE utilisateur RESTART IDENTITY CASCADE;

DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..100000 LOOP
        INSERT INTO utilisateur (id_user, nom_user, prenom, email, num_etu)
        VALUES (
            i,
            'nom_' || i,
            'prenom_' || i,
            'user_' || i || '@example.com',
            10000000 + i
        );
    END LOOP;
END $$;

DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..100000 LOOP
        INSERT INTO materiel (id_materiel, nom_materiel, quantite_materiel)
        VALUES (
            i,
            'materiel_' || i,
            (random() * 20)::INT + 1
        );
    END LOOP;
END $$;

DO $$
DECLARE
    i INT;
    start_date DATE;
    end_date DATE;
BEGIN
    FOR i IN 1..200000 LOOP
        start_date := DATE '2025-01-01' + (random() * 365)::INT;
        end_date := start_date + (random() * 30)::INT;

        INSERT INTO disponibilite (id_disponibilite, id_materiel, date_debut, date_fin)
        VALUES (
            i,
            (random() * 99999)::INT + 1,
            start_date,
            end_date
        );
    END LOOP;
END $$;

DO $$
DECLARE
    i INT;
    reservation_date DATE;
    return_date DATE;
    effective_return_date DATE;
BEGIN
    FOR i IN 1..200000 LOOP
        reservation_date := DATE '2025-01-01' + (random() * 365)::INT;
        return_date := reservation_date + (random() * 15)::INT;
        effective_return_date := reservation_date + (random() * 20)::INT;

        INSERT INTO reservation (
            id_res,
            debut_res,
            fin_res,
            id_user,
            id_materiel,
            id_disponibilite,
            date_retour_effectif
        )
        VALUES (
            i,
            reservation_date,
            return_date,
            (random() * 99999)::INT + 1,
            (random() * 99999)::INT + 1,
            (random() * 199999)::INT + 1,
            effective_return_date
        );
    END LOOP;
END $$;

-- 5. Exécutez une recherche impliquant des jointures entre les tables: Matériel, Réservation, Utilisateur, Disponibilité
-- Faites une recherche en vous basant comme critère sur une des colonnes de la table de réservation (ex. la date de début de disponibilité)
SELECT
    materiel.nom_materiel,
    utilisateur.nom_user,
    utilisateur.prenom,
    reservation.debut_res,
    reservation.fin_res,
    disponibilite.date_debut,
    disponibilite.date_fin
FROM reservation
JOIN utilisateur ON reservation.id_user = utilisateur.id_user
JOIN materiel ON reservation.id_materiel = materiel.id_materiel
JOIN disponibilite ON reservation.id_disponibilite = disponibilite.id_disponibilite
WHERE reservation.debut_res >= DATE '2025-06-01'
ORDER BY reservation.debut_res ASC;

-- 6. Affichez le plan d' exécution de la requête à l'aide de l'instruction EXPLAIN ANALYZE. Analysez et indiquez la cause du ralentissement.
-- Vous pouvez également consulter l'onglet `Explain`` pour avoir une représentation graphique.
EXPLAIN ANALYZE
SELECT
    materiel.nom_materiel,
    utilisateur.nom_user,
    utilisateur.prenom,
    reservation.debut_res,
    reservation.fin_res,
    disponibilite.date_debut,
    disponibilite.date_fin
FROM reservation
JOIN utilisateur ON reservation.id_user = utilisateur.id_user
JOIN materiel ON reservation.id_materiel = materiel.id_materiel
JOIN disponibilite ON reservation.id_disponibilite = disponibilite.id_disponibilite
WHERE reservation.debut_res >= DATE '2025-06-01'
ORDER BY reservation.debut_res ASC;

-- le ralentissement peut-être causé par l'absence d'index