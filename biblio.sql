----------2-----------
---creation des tables
create table auteur(
	code_auteur serial primary key not null,
	nom_auteur varchar(20) not null
);

create table emprunteur(
	code_emp serial primary key not null,
	nom_emp varchar(20),
	prenom_emp varchar(20),
	adresse varchar(20),
	etat_cot bool,
	date_inscription date);

create table livre(
	code_livre serial primary key ,
	code_auteur integer,
	foreign key (code_auteur) references auteur(code_auteur),
	date_editeur date ,
	nom_editeur varchar(30),
	titre varchar(50));

create table exemplaire(
	code_exempl serial primary key,
	code_livre integer,
	foreign key (code_livre) references livre(code_livre),
	valeur integer	);

create table emprunt(
	num_emprunt serial primary key, --c'est le numero qui indique l'emprunt
	code_emp integer,
	foreign key(code_emp) references emprunteur(code_emp),
	code_exempl integer,--code emprunteur comme pk
	foreign key(code_exempl) references exemplaire(code_exempl),
	date_emprunt date , --code emprunt 
	date_retour_emprunt date);


-----INSERTION DANS LES TALBLES
-- Insertion dans la table "auteur"
INSERT INTO auteur (nom_auteur) VALUES
('ABAKHAR'),
('ELHANSALI'),
('NICOLAS MACHIAVEL'),
('ÉRIC LAURENT');
-- Insertion dans la table "emprunteur"
INSERT INTO emprunteur (nom_emp, prenom_emp, adresse, etat_cot, date_inscription) VALUES
('AIT SAID', 'AYOUBE', 'AGADIR TIKIOUINE', true, '2023-01-01'),
('MOUAD', 'RGUIBI', 'CASA DERBSULTAN',true, '2023-01-02'),
('HODAIFA', 'ELFASI', 'FES RAHMANIA ',false,'2023-01-03');
-- Insertion dans la table "livre"
INSERT INTO livre (code_auteur, date_editeur,nom_editeur,titre)VALUES
(1,'2022-02-01',  'DAR ALMAARIFA','نعيم الجهل'),
(2, '2022-08-03', 'DAR ALAAILME','جحيم المعرفة '),
(3, '1532-01-01', 'none', 'كتاب الأمير ميكافيلي'),
(4, '1993-01-01', 'none', 'ذاكرة ملك');
-- Insertion dans la table "exemplaire"
INSERT INTO exemplaire (code_livre, valeur) VALUES
(3, 70),
(3, 5),
(3, 20);
-- Insertion dans la table "emprunt"
INSERT INTO emprunt (code_emp, code_exempl, date_emprunt, date_retour_emprunt) VALUES
(1, 1, '2023-01-01', '2023-01-15'),
(2, 2, '2023-01-02', '2023-01-16'),
(3, 3, '2023-01-03', '2023-01-17');

ALTER TABLE emprunt
ADD COLUMN titre VARCHAR(50),
ADD COLUMN code_livre INTEGER,
ADD FOREIGN KEY (code_livre) REFERENCES livre(code_livre);


select sum(code_exempl)as "مجموع الأمثلة",code_livre from livre natural join exemplaire 
group by code_livre;
 

