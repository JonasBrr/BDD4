-- compter le nombre de reservation entre les dates du 01/07/2025 et 20/07/2025
SELECT COUNT(id_res) FROM reservation WHERE debut_res >= '2025-07-01' AND fin_res <= '2025-07-20';

-- compter le nombre d'utilisateur qui on déjà fait une reservation
select COUNT(distinct id_user) FROM reservation;
