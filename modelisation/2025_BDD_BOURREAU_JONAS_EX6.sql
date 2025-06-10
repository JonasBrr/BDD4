-- supprimer une reservation
DELETE FROM reservation WHERE id_res=15;

-- supprimer une reservation dont la date de retour est passée
DELETE FROM reservation WHERE fin_res < current_date ;