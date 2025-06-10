--chaque table contient un id automatiquement incrémenté

INSERT INTO public.utilisateur(
	email, nom_user, prenom)
	VALUES 
    ('toto@gmail.com', 'toto', 'dupond'),
    ('titi@gmail.com', 'titi', 'jean'),
    ('lulu@gmail.com', 'lulu', 'marc'),
    ('mimi@gmail.com', 'mimi', 'lucie'),
    ('nana@gmail.com', 'nana', 'julie'),
    ('bobo@gmail.com', 'bobo', 'antoine'),
    ('paul.dupont@example.com', 'dupont', 'Paul'),
    ('marie.lefevre@example.com', 'lefevre', 'Marie'),
    ('céline.moreau@example.com', 'moreau', 'Céline'),
    ('nicolas.laurent@example.com', 'laurent', 'Nicolas'),
    ('élise.martin@example.com', 'martin', 'Élise');

INSERT INTO public.materiel (
    nom_materiel, quantite_materiel
)
VALUES
    ('Projecteur HD', 5),
    ('Enceinte Bluetooth', 10),
    ('Micro sans fil', 8),
    ('Tente pliante 3x3', 4),
    ('Chaise pliante', 100),
    ('Table rectangulaire', 20),
    ('Écran de projection', 3),
    ('Caméra vidéo', 2),
    ('Pupitre de conférence', 6),
    ('Lumière LED', 15);

INSERT INTO reservation (
    debut_res, fin_res, quantite_res, id_materiel, id_user
)
VALUES
    ('2025-06-01', '2025-06-10', 5, 1, 3),  
    ('2025-06-05', '2025-06-15', 10, 3, 7),  
    ('2025-06-10', '2025-06-20', 8, 7, 2),
    ('2025-06-15', '2025-06-25', 4, 2, 9), 
    ('2025-06-20', '2025-06-30', 100, 8, 5), 
    ('2025-07-01', '2025-07-10', 20, 6, 1),
    ('2025-07-05', '2025-07-15', 3, 10, 4),
    ('2025-07-10', '2025-07-20', 2, 4, 8), 
    ('2025-07-15', '2025-07-25', 6, 5, 6), 
    ('2025-07-20', '2025-07-30', 15, 9, 10), 
    ('2025-07-01', '2025-07-10', 5, 1, 11), 
    ('2025-07-05', '2025-07-15', 10, 6, 3),
    ('2025-07-10', '2025-07-20', 8, 4, 7),
    ('2025-07-15', '2025-07-25', 4, 10, 2),
    ('2025-07-20', '2025-07-30', 100, 8, 9);