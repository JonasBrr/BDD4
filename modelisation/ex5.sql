-- changer la quantité d'un matériel
UPDATE materiel SET quantite_materiel=20 WHERE id_materiel=4;

-- augmenter la quantité du matériel en cours d'emprunt dont l'emprunt se termine dans moins de deux jours
UPDATE materiel SET quantite_materiel=quantite_materiel+5 WHERE id_materiel IN (select id_materiel from reservation where debut_res < current_date and fin_res < current_date + 2)