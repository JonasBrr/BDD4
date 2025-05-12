CREATE TABLE utilisateur (
   id_user SERIAL PRIMARY KEY,
   email VARCHAR(50),
   nom_user VARCHAR(50),
   prenom VARCHAR(50)
);

CREATE TABLE materiel (
   id_materiel SERIAL PRIMARY KEY,
   nom_materiel VARCHAR(50),
   quantite_materiel INT
);

CREATE TABLE reservation (
   id_res SERIAL PRIMARY KEY,
   debut_res DATE,
   fin_res DATE,
   quantite_res INT,
   id_materiel INT,
   id_user INT,
   FOREIGN KEY (id_materiel) REFERENCES materiel(id_materiel),
   FOREIGN KEY (id_user) REFERENCES utilisateur(id_user)
);
