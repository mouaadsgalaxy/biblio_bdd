
---------------1.creation la base de donnees biblio-----------------
CREATE DATABASE biblio;

--------2.la creation des tables -----------
---la table auteur
create table auteur(
	code_auteur serial primary key not null,
	nom_auteur varchar(20) not null
);

---la table emprunteur
create table emprunteur(
	code_emp serial primary key not null,
	nom_emp varchar(20),
	prenom_emp varchar(20),
	adresse varchar(20),
	etat_cot bool,
	date_inscription date);

---la table livre
create table livre(
	code_livre serial primary key ,
	code_auteur integer,
	foreign key (code_auteur) references auteur(code_auteur),
	date_editeur date ,
	nom_editeur varchar(30),
	titre varchar(50));

---la table exemplaire
create table exemplaire(
	code_exempl serial primary key,
	code_livre integer,
	foreign key (code_livre) references livre(code_livre),
	valeur integer	);

---la table emprunt
create table emprunt(
	num_emprunt serial primary key, --c'est le numero qui indique l'emprunt
	code_emp integer,
	foreign key(code_emp) references emprunteur(code_emp),
	code_exempl integer,--code emprunteur comme pk
	foreign key(code_exempl) references exemplaire(code_exempl),
	date_emprunt date , --code emprunt 
	date_retour_emprunt date);

-------2.insertions des tables 

-- Insertion dans la table "auteur"
INSERT INTO auteur (nom_auteur) VALUES
('ABAKHAR'),
('ELHANSALI'),
('NICOLAS MACHIAVEL'),
('ÉRIC LAURENT'),
('عبد الله السعيد'),
('فاطمة محمود'),
('محمد عبد الرحمن'),
('لمياء الزهراء'),
('سلمى محمد'),
('علي حسين'),
('فاطمة عبد الله'),
('محمد عبد الرحيم');

-- Insertion dans la table "emprunteur"
INSERT INTO emprunteur (nom_emp, prenom_emp, adresse, etat_cot, date_inscription) VALUES
('AIT SAID', 'AYOUBE', 'AGADIR TIKIOUINE', true, '2023-01-01'),
('MOUAD', 'RGUIBI', 'CASA DERBSULTAN',true, '2023-01-02'),
('HODAIFA', 'ELFASI', 'FES RAHMANIA ',false,'2023-01-03'),
('أحمد مصطفى', 'محمود', 'الجيزة', true, '2023-02-10'),
('ليلى', 'عبد الله', 'الرياض', true, '2023-03-20'),
('محمد', 'علي', 'الدمام', false, '2023-04-15'),
('لمى محمد', 'علي', 'جدة', true, '2023-02-10'),
('حسن', 'فاطمة', 'الخبر', true, '2023-03-20'),
('عبد الله', 'ليلى', 'المدينة المنورة', false, '2023-04-15');

-- Insertion dans la table "livre"
INSERT INTO livre (code_auteur, date_editeur,nom_editeur,titre)VALUES
(1,'2022-02-01',  'DAR ALMAARIFA','نعيم الجهل'),
(2, '2022-08-03', 'DAR ALAAILME','جحيم المعرفة '),
(3, '1532-01-01', 'none', 'كتاب الأمير ميكافيلي'),
(4, '1993-01-01', 'none', 'ذاكرة ملك'),
(5, '2023-05-01', 'دار الحكمة', 'فن البرمجة بلغة البايثون'),
(6, '2023-06-15', 'دار المعرفة', 'علم الذكاء الاصطناعي'),
(7, '2023-07-01', 'دار الكتب', 'الطريق إلى النجاح'),
(8, '2023-08-10', 'دار النشر', 'مأساة الحب الحقيقي'),
(9, '2023-05-01', 'دار الحكمة', 'الألوان في الفنون التشكيلية'),
(10, '2023-06-15', 'دار المعرفة', 'العمارة الإسلامية'),
(11, '2023-07-01', 'دار الكتب', 'أحلام مستغانم - روائية جزائرية'),
(12, '2023-08-10', 'دار النشر', 'الطائر المبكر يحصد الديدان');

-- Suppression des contraintes de clé étrangère
ALTER TABLE emprunt DROP CONSTRAINT IF EXISTS emprunt_code_exempl_fkey;

-- Insertion dans la table "exemplaire"
INSERT INTO exemplaire (code_livre, valeur) VALUES
(3, 70),
(3, 5),
(3, 20),
(1, 30),
(2, 15),
(3, 25),
(4, 10),
(1, 20),
(2, 10),
(3, 30),
(4, 15),
(6, 70),
(8, 5),
(11, 10),
(12, 20),
(12, 10),
(9, 20),
(7, 30),
(5, 15),
(10, 25),
(12, 30),
(12, 15);


-- Insertion dans la table "emprunt"
INSERT INTO emprunt (code_emp, code_exempl, date_emprunt, date_retour_emprunt) VALUES
(1, 1, '2023-01-01', '2023-01-15'),
(2, 2, '2023-01-02', '2023-01-16'),
(3, 5, '2023-01-03', '2023-01-17'),
(4, 5, '2023-05-15', '2023-06-01'),
(5, 5, '2023-06-20', '2023-07-05'),
(6, 6, '2023-07-10', '2023-07-25'),
(7, 7, '2023-05-15', '2023-06-01'),
(7, 8, '2023-06-20', '2023-07-05'),
(7, 3, '2023-07-10', '2023-07-25');



ALTER TABLE emprunt
ADD COLUMN titre VARCHAR(50),
ADD COLUMN code_livre INTEGER,
ADD FOREIGN KEY (code_livre) REFERENCES livre(code_livre);






---------3.calculer le nombre d'exemplaire par livre 
--------le nombre d'exemplaire par livre

SELECT livre.titre, COUNT(exemplaire.code_exempl) AS nombre_exemplaires
FROM livre
JOIN exemplaire ON livre.code_livre = exemplaire.code_livre
GROUP BY livre.titre;

--------4.quel livre a le plus petit valeur 


SELECT livre.titre, MIN(exemplaire.valeur) AS plus_petit_valeur
FROM livre
JOIN exemplaire ON livre.code_livre = exemplaire.code_livre
GROUP BY livre.titre
ORDER BY plus_petit_valeur
LIMIT 1;

---5.A la date d'aujurd'hui ,afficher les noms des emprunteurs qui n'ont pas encore rendu leur livre----------
SELECT DISTINCT nom_emp
FROM emprunteur
NATURAL JOIN emprunt
WHERE date_retour_emprunt IS NULL AND date_emprunt <= CURRENT_DATE;

---------6.afficher les livres qui n'ont jamais ete empruntes
SELECT l.titre
FROM livre l
WHERE NOT EXISTS (
    SELECT 1
    FROM emprunt e
    JOIN exemplaire e2 ON e.code_exempl = e2.code_exempl
    JOIN livre l2 ON e2.code_livre = l2.code_livre
    WHERE l.titre = l2.titre
);


---6.1  .afficher les livres qui n'ont jamais ete empruntes------

 SELECT livre.*
FROM livre
NATURAL JOIN emprunt
WHERE livre.code_livre NOT IN (SELECT code_livre FROM emprunt);
------------------------6.2  afficher les livres qui n'ont jamais ete empruntes       -----------------------------------
SELECT livre.*
FROM livre
NATURAL JOIN emprunt
WHERE emprunt.code_livre IS NULL;


-----------7.afficher les emprunteurs qui ont emprunte le maximum des livres (des livres differents)--------------------------------------------------
SELECT emprunteur.*
FROM emprunteur
NATURAL JOIN emprunt
GROUP BY emprunteur.code_emp
HAVING COUNT(emprunt.code_exempl) = (
    SELECT MAX(nbr_exemplaire)
    FROM (
        SELECT code_emp, COUNT(code_exempl) AS nbr_exemplaire
        FROM emprunt
        GROUP BY code_emp
    ) AS counts
);





------------------------------------------8.afficher l'exemplaire le plus chere pour chaque livre --------------------------------------------

SELECT code_livre, MAX(valeur) AS max_valeur
FROM exemplaire
NATURAL JOIN livre
GROUP BY code_livre;

------------------------------------9.vider  le contenu de toutes les tables -----------------------------------------------


-- Supprimer toutes les données de la table "emprunt"
DELETE FROM biblio.emprunt;

-- Supprimer toutes les données de la table "exemplaire"
DELETE FROM biblio.exemplaire;

-- Supprimer toutes les données de la table "livre"
DELETE FROM biblio.livre;

-- Supprimer toutes les données de la table "emprunteur"
DELETE FROM biblio.emprunteur;

-- Supprimer toutes les données de la table "auteur"
DELETE FROM biblio.auteur;



----------ou bien supprimer les tables avec son contenu 

DROP TABLE IF EXISTS emprunt;
DROP TABLE IF EXISTS exemplaire;
DROP TABLE IF EXISTS livre;
DROP TABLE IF EXISTS emprunteur;
DROP TABLE IF EXISTS auteur;



----------10.supprimer la base de donnee biblio----------------------------------------------------

DROP DATABASE biblio;







