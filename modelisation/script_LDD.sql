CREATE TABLE user_(
   id_user COUNTER,
   email VARCHAR(50),
   nom_user VARCHAR(50),
   prenom VARCHAR(50),
   PRIMARY KEY(id_user)
);

CREATE TABLE materiel(
   id_materiel COUNTER,
   nom_materiel VARCHAR(50),
   quantite_materiel INT,
   PRIMARY KEY(id_materiel)
);

CREATE TABLE reservation(
   id_res COUNTER,
   debut_res DATE,
   fin_res DATE,
   quantite_res INT,
   id_materiel INT,
   id_user INT,
   PRIMARY KEY(id_res),
   FOREIGN KEY(id_materiel) REFERENCES materiel(id_materiel),
   FOREIGN KEY(id_user) REFERENCES user_(id_user)
);
